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
    public partial class GrupTanimlari_GridView_Master : MasterUserControl
    {
        DMPortalEntities db = new DMPortalEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            Update();
            EmployeesGrid.DataBind();
        }

        public override void Update()
        {
            //BindGrid();
            UpdateDetail();
        }

        //protected void BindGrid()
        //{
        //    var list = db.S_Kullanici().ToList();
        //    if (list.Count > 0)
        //    {
        //        GridViewDataComboBoxColumn combo = EmployeesGrid.Columns["UserID"] as GridViewDataComboBoxColumn;
        //        combo.PropertiesComboBox.ValueType = typeof(Guid);
        //        combo.PropertiesComboBox.DataSource = list;
        //    }
        //}
        protected List<S_Grup_Result> GridUpdating()
        {
            var list = db.S_Grup().ToList();
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
                if (e.Column.FieldName == "Adi")
                    e.Editor.ReadOnly = !grid.IsNewRowEditing;

            }
        }

        protected void EmployeesGrid_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            string Adi = e.NewValues["Adi"] == null ? "" : e.NewValues["Adi"].ToString();
            db.I_Grup(Adi);
            e.Cancel = true;
            EmployeesGrid.CancelEdit();
            Update();
        }

        protected void EmployeesGrid_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            string id = grid.GetRowValues(grid.EditingRowVisibleIndex, "ID").ToString();
            string Adi = e.NewValues["Adi"] == null ? "" : e.NewValues["Adi"].ToString();
            db.U_Grup(Convert.ToInt32(id), Adi);
            e.Cancel = true;
            EmployeesGrid.CancelEdit();
            Update();
        }

        protected void EmployeesGrid_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int rowindex = EmployeesGrid.FindVisibleIndexByKeyValue(e.Keys[EmployeesGrid.KeyFieldName]);
            ASPxGridView grid = (ASPxGridView)sender;
            var id = grid.GetRowValues(rowindex, "ID").ToString();
            db.D_Grup(Convert.ToInt32(id));
            e.Cancel = true;
            EmployeesGrid.CancelEdit();
            Update();
        }

    }
}