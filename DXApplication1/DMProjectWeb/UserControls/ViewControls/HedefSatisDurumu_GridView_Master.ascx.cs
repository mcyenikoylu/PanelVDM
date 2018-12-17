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
    
    public partial class HedefSatisDurumu_GridView_Master : MasterUserControl
    {
        DMPortalEntities db = new DMPortalEntities();

        private DateTime _BaslangicTarihi = new DateTime();
        private DateTime _BitisTarihi = new DateTime();

        //public override long SelectedItemID
        //{
        //    get
        //    {
        //        var employeeID = EmployeesGrid.GetRowValues(EmployeesGrid.FocusedRowIndex, EmployeesGrid.KeyFieldName);
        //        return employeeID != null ? (long)employeeID : DataProvider.emptyEntryID;
        //    }
        //    set
        //    {
        //        BindGrid();
        //        EmployeesGrid.FocusedRowIndex = EmployeesGrid.FindVisibleIndexByKeyValue(value);
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

            _BaslangicTarihi = OwnerPage.BaslangicTarihi;
            _BitisTarihi = OwnerPage.BitisTarihi;
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
            var list = db.S_HedefSatisDurumu(Convert.ToInt32(BayiID), _BaslangicTarihi, _BitisTarihi).ToList();
            if (list.Count > 0)
            {
                EmployeesGrid.DataSource = list;
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