using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.ViewControls
{
    public partial class Siparisler_GridView_Master : MasterUserControl
    {
        DMPortalEntities db = new DMPortalEntities();

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
            var urun = db.S_Urunler().ToList();
            if (urun.Count > 0)
            {
                GridViewDataComboBoxColumn combo = EmployeesGrid.Columns["UrunID"] as GridViewDataComboBoxColumn;
                combo.PropertiesComboBox.ValueType = typeof(int);
                combo.PropertiesComboBox.DataSource = urun;
            }
            var bayi = db.S_Bayi(-1).ToList();
            if(bayi.Count>0)
            {
                GridViewDataComboBoxColumn combo = EmployeesGrid.Columns["BayiID"] as GridViewDataComboBoxColumn;
                combo.PropertiesComboBox.ValueType = typeof(int);
                combo.PropertiesComboBox.DataSource = bayi;
            }
            var tip = db.S_Tip(6).ToList();
            if(tip.Count>0)
            {
                GridViewDataComboBoxColumn combo = EmployeesGrid.Columns["Onay"] as GridViewDataComboBoxColumn;
                combo.PropertiesComboBox.ValueType = typeof(int);
                combo.PropertiesComboBox.DataSource = tip;
            }
            var list = db.S_Siparisler(-1).ToList();
            if (list.Count > 0)
            {
                EmployeesGrid.DataSource = list;
                EmployeesGrid.DataBind();
            }
        }

        protected void EmployeesGrid_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            string adet = e.NewValues["Adet"].ToString();
            string urunid = e.NewValues["UrunID"].ToString();
            string bayiid = e.NewValues["BayiID"].ToString();
            db.I_Siparislerim(Convert.ToInt32(bayiid), Convert.ToInt32(urunid), Convert.ToInt32(adet));
            e.Cancel = true;
            EmployeesGrid.CancelEdit();
            Update();
        }

        protected void EmployeesGrid_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            string id = grid.GetRowValues(grid.EditingRowVisibleIndex, "ID").ToString();
            string onay = e.NewValues["Onay"].ToString();
            db.U_Siparis(Convert.ToInt32(id), Convert.ToInt32(onay));
            e.Cancel = true;
            EmployeesGrid.CancelEdit();
            Update();
        }

        protected void EmployeesGrid_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int rowindex = EmployeesGrid.FindVisibleIndexByKeyValue(e.Keys[EmployeesGrid.KeyFieldName]);
            ASPxGridView grid = (ASPxGridView)sender;
            var id = grid.GetRowValues(rowindex, "ID").ToString();
            db.D_Siparis(Convert.ToInt32(id));
            e.Cancel = true;
            EmployeesGrid.CancelEdit();
            Update();
        }
    }
}