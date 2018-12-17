using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.ViewControls
{
    public partial class KullaniciTanimlari_GridView_Master : MasterUserControl
    {
        DMPortalEntities db = new DMPortalEntities();

        //public override long SelectedItemID
        //{
        //    get
        //    {
        //        var employeeID = EmployeesGrid.GetRowValues(EmployeesGrid.FocusedRowIndex, EmployeesGrid.KeyFieldName);
        //        return employeeID != null ? (long)employeeID : DataProvider.emptyEntryID; //bu emptyEntryID değişkeni DevAV projesinde -1 olarak tanımlanmış ve bir çok yerde kullanılmış. ama başka sayfalarda değer alıyormu detaylı incelemedim. bir proje arajtırması yaptım ctrl+f ile sadece Employee sayfasıyla ilişkili olanlara baktım. derinlemesine bakmadım.
        //    }
        //    set
        //    {
        //        BindGrid();
        //        //EmployeesGrid.FocusedRowIndex = EmployeesGrid.FindVisibleIndexByKeyValue(value);
        //        UpdateDetail();
        //    }
        //}

        public override Guid SelectedItemGuid
        {
            get
            {
                Guid a = new Guid();
                var UserGuid = EmployeesGrid.GetRowValues(EmployeesGrid.FocusedRowIndex, "ProviderUserKey");
                if (UserGuid != null)
                    return (Guid)UserGuid;
                else
                    return a;
            }
            set
            {
                BindGrid();
                EmployeesGrid.FocusedRowIndex = EmployeesGrid.FindVisibleIndexByKeyValue(value);
                UpdateDetail();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Update();

        }

        public override void Update()
        {
            BindGrid();
            UpdateDetail();
        }

        protected void BindGrid()
        {
            //EmployeesGrid.DataSource = DataProvider.Employees.ToList();
            //EmployeesGrid.FilterExpression = OwnerPage.FilterBag.GetExpression(false);
            //EmployeesGrid.DataBind();

            var users = Membership.GetAllUsers();
            var userList = new List<MembershipUser>();
            foreach (MembershipUser user in users)
            {
                userList.Add(user);
            }
            EmployeesGrid.DataSource = userList.ToList();
            EmployeesGrid.DataBind();

        }

    }
}