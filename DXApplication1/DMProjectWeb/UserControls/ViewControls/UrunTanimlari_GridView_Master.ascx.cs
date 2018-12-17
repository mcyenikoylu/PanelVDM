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
    public partial class UrunTanimlari_GridView_Master : MasterUserControl
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
            var tip = db.S_Tip(4).ToList();
            if (tip.Count > 0)
            {
                GridViewDataComboBoxColumn combo = EmployeesGrid.Columns["KategoriID_TipID4"] as GridViewDataComboBoxColumn;
                combo.PropertiesComboBox.ValueType = typeof(int);
                combo.PropertiesComboBox.DataSource = tip;
            }
        }
        protected List<S_Urunler_Result> GridUpdating()
        {
            var list = db.S_Urunler().ToList();
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
                if (e.Column.FieldName == "UrunKodu")
                    e.Editor.ReadOnly = !grid.IsNewRowEditing;
                if (e.Column.FieldName == "UrunAdi")
                    e.Editor.ReadOnly = !grid.IsNewRowEditing;
                if (e.Column.FieldName == "KategoriID_TipID4")
                    e.Editor.ReadOnly = !grid.IsNewRowEditing;
                if (e.Column.FieldName == "Marka")
                    e.Editor.ReadOnly = !grid.IsNewRowEditing;
                if (e.Column.FieldName == "Model")
                    e.Editor.ReadOnly = !grid.IsNewRowEditing;
                if (e.Column.FieldName == "Fiyat")
                    e.Editor.ReadOnly = !grid.IsNewRowEditing;
            }
        }

        protected void EmployeesGrid_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            string UrunKodu = e.NewValues["UrunKodu"] == null ? "" : e.NewValues["UrunKodu"].ToString();
            string resimadi = DataProvider.urunresmi;
            string UrunAdi = e.NewValues["UrunAdi"] == null ? "" : e.NewValues["UrunAdi"].ToString();
            string KategoriID_TipID4 = e.NewValues["KategoriID_TipID4"] == null ? "" : e.NewValues["KategoriID_TipID4"].ToString();
            string Marka = e.NewValues["Marka"] == null ? "" : e.NewValues["Marka"].ToString();
            string Model = e.NewValues["Model"] == null ? "" : e.NewValues["Model"].ToString();
            string Fiyat = e.NewValues["Fiyat"] == null ? "" : e.NewValues["Fiyat"].ToString();
            db.I_UrunTanimlari(UrunKodu, UrunAdi, Convert.ToInt32(KategoriID_TipID4), Marka, Model, Convert.ToDecimal(Fiyat), resimadi);
            e.Cancel = true;
            EmployeesGrid.CancelEdit();
            Update();
        }

        protected void EmployeesGrid_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            string id = grid.GetRowValues(grid.EditingRowVisibleIndex, "ID").ToString();
            string UrunKodu = e.NewValues["UrunKodu"] == null ? "" : e.NewValues["UrunKodu"].ToString();
            string resimadi = DataProvider.urunresmi;
            string UrunAdi = e.NewValues["UrunAdi"] == null ? "" : e.NewValues["UrunAdi"].ToString();
            string KategoriID_TipID4 = e.NewValues["KategoriID_TipID4"] == null ? "" : e.NewValues["KategoriID_TipID4"].ToString();
            string Marka = e.NewValues["Marka"] == null ? "" : e.NewValues["Marka"].ToString();
            string Model = e.NewValues["Model"] == null ? "" : e.NewValues["Model"].ToString();
            string Fiyat = e.NewValues["Fiyat"] == null ? "" : e.NewValues["Fiyat"].ToString();
            db.U_UrunTanimlari(Convert.ToInt32(id), UrunKodu, UrunAdi, Convert.ToInt32(KategoriID_TipID4), 
                Marka, Model, Convert.ToDecimal(Fiyat), resimadi);
            e.Cancel = true;
            EmployeesGrid.CancelEdit();
            Update();
        }

        protected void EmployeesGrid_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int rowindex = EmployeesGrid.FindVisibleIndexByKeyValue(e.Keys[EmployeesGrid.KeyFieldName]);
            ASPxGridView grid = (ASPxGridView)sender;
            var id = grid.GetRowValues(rowindex, "ID").ToString();
            db.D_UrunTanimlari(Convert.ToInt32(id));
            e.Cancel = true;
            EmployeesGrid.CancelEdit();
            Update();
        }

        protected void ucDoc_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            string uploadFolder = Server.MapPath("~/Images/UploadUrunler/");
            string resultExtension = Path.GetExtension(e.UploadedFile.FileName);
            string resultFileName = Path.ChangeExtension(Path.GetRandomFileName(), resultExtension);
            string fileName = resultFileName;
            e.UploadedFile.SaveAs(uploadFolder + fileName);
            DataProvider.urunresmi = fileName;
        }
    }
}