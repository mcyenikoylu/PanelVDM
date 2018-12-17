using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.ViewControls
{
    public partial class KullaniciRoles_GridView_Master : MasterUserControl
    {
        DMPortalEntities db = new DMPortalEntities();
        public override Guid SelectedItemGuid
        {
            get
            {
                var rolesGuid = EmployeesGrid.GetRowValues(EmployeesGrid.FocusedRowIndex, "RoleId");
                return (Guid)rolesGuid;
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
            EmployeesGrid.DataSource = db.S_Roles().ToList();
            EmployeesGrid.DataBind();
        }
    }
}