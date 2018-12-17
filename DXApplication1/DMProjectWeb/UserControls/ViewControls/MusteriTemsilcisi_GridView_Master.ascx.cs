using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.ViewControls
{
    public partial class MusteriTemsilcisi_GridView_Master : MasterUserControl
    {
        DMPortalEntities db = new DMPortalEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            Update();
            EmployeesGrid.DataBind();
        }

        public override void Update()
        {
            BindGrid();
            UpdateDetail();
        }

        protected void BindGrid()
        {
            var list = db.S_Kullanici().ToList();
            if (list.Count > 0)
            {
                GridViewDataComboBoxColumn combo = EmployeesGrid.Columns["UserID"] as GridViewDataComboBoxColumn;
                combo.PropertiesComboBox.ValueType = typeof(Guid);
                combo.PropertiesComboBox.DataSource = list;
            }
        }
        protected List<S_MusteriTemsilcisi_Result> GridUpdating()
        {
            var list = db.S_MusteriTemsilcisi(null).ToList();
            if (list.Count > 0)
                return list;
            else
                return null;
        }
        protected void EmployeesGrid_DataBinding(object sender, EventArgs e)
        {
            EmployeesGrid.DataSource = GridUpdating();
        }

        protected void EmployeesGrid_CellEditorInitialize(object sender, ASPxGridViewEditorEventArgs e)
        {
            ASPxGridView grid = sender as ASPxGridView;
            if (grid.IsNewRowEditing)
            {
                if (e.Column.FieldName == "AdiSoyadi")
                    e.Editor.ReadOnly = !grid.IsNewRowEditing;
                if (e.Column.FieldName == "UserID")
                    e.Editor.ReadOnly = !grid.IsNewRowEditing;
            }
        }

        protected void EmployeesGrid_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            string AdiSoyadi = e.NewValues["AdiSoyadi"] == null ? "" : e.NewValues["AdiSoyadi"].ToString();
            string UserID = e.NewValues["UserID"] == null ? "" : e.NewValues["UserID"].ToString();
            Guid guid = new Guid(UserID);
            db.I_MusteriTemsilcisi(AdiSoyadi,guid);
            e.Cancel = true;
            EmployeesGrid.CancelEdit();
            Update();
        }

        protected void EmployeesGrid_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            string id = grid.GetRowValues(grid.EditingRowVisibleIndex, "ID").ToString();
            string AdiSoyadi = e.NewValues["AdiSoyadi"] == null ? "" : e.NewValues["AdiSoyadi"].ToString();
            string UserID = e.NewValues["UserID"] == null ? "" : e.NewValues["UserID"].ToString();
            Guid guid = new Guid(UserID);
            db.U_MusteriTemsilcisi(Convert.ToInt32(id),AdiSoyadi,guid);
            e.Cancel = true;
            EmployeesGrid.CancelEdit();
            Update();
        }

        protected void EmployeesGrid_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int rowindex = EmployeesGrid.FindVisibleIndexByKeyValue(e.Keys[EmployeesGrid.KeyFieldName]);
            ASPxGridView grid = (ASPxGridView)sender;
            var id = grid.GetRowValues(rowindex, "ID").ToString();
            db.D_MusteriTemsilcisi(Convert.ToInt32(id));
            e.Cancel = true;
            EmployeesGrid.CancelEdit();
            Update();
        }

        
    }
}