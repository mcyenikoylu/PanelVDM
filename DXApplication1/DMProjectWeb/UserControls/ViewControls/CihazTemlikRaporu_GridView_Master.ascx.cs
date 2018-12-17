using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.ViewControls
{
    public partial class CihazTemlikRaporu_GridView_Master : MasterUserControl
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
            ProfileBase curProfile = ProfileBase.Create(Membership.GetUser().UserName);
            string BayiID = curProfile.GetPropertyValue("BayiID").ToString();
            if (Roles.GetRolesForUser(Membership.GetUser().UserName)[0].ToString() == "PersonelYonetici" ||
                Roles.GetRolesForUser(Membership.GetUser().UserName)[0].ToString() == "PersonelTeknik" ||
                Roles.GetRolesForUser(Membership.GetUser().UserName)[0].ToString() == "TemsilciYonetici" ||
                Roles.GetRolesForUser(Membership.GetUser().UserName)[0].ToString() == "DeveloperUser" ||
                Roles.GetRolesForUser(Membership.GetUser().UserName)[0].ToString() == "Muhasebe") //if ile vdm personel yönetici yetkisi için roles dan kontrol edip -1 göndermek lazım.
            {
                if (BayiID == null || BayiID == "" || BayiID == "130" || BayiID == "140")
                    BayiID = "-1";
            }
            var list = db.S_CihazTemlikRaporu(Convert.ToInt32(BayiID)).ToList();
            if (list.Count > 0)
            {
                EmployeesGrid.DataSource = list.ToList();
                EmployeesGrid.DataBind();
            }
            else
            {
                EmployeesGrid.DataSource = null;
                EmployeesGrid.DataBind();
            }

        }
    }
}