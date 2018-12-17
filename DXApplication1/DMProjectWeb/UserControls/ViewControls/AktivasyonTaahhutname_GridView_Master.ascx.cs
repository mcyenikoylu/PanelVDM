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
    public partial class AktivasyonTaahhutname_GridView_Master : MasterUserControl
    {
        DMPortalEntities db = new DMPortalEntities();
        public override int SelectedItemID
        {
            get
            {
                var employeeID = EmployeesGrid.GetRowValues(EmployeesGrid.FocusedRowIndex, EmployeesGrid.KeyFieldName);
                return employeeID != null ? (int)employeeID : DataProvider.emptyEntryID;
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
            ProfileBase curProfile = ProfileBase.Create(Membership.GetUser().UserName);
            string bayiid = curProfile.GetPropertyValue("BayiID").ToString();
            var list = db.S_AktivasyonTaahhutname(-1,Convert.ToInt32(bayiid)).ToList();
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