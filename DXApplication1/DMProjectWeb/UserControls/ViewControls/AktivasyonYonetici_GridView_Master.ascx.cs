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
    public partial class AktivasyonYonetici_GridView_Master : MasterUserControl
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
           
            var list = db.S_AktivasyonYonetici(-1).ToList();
            if (list.Count > 0)
            {
                EmployeesGrid.DataSource = list;
                EmployeesGrid.DataBind();
            }
        }
    }
}