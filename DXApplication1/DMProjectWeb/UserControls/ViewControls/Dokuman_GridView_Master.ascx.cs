using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.ViewControls
{
    public partial class Dokuman_GridView_Master : MasterUserControl
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
            var tip = db.S_Tip(5).ToList();
            if (tip.Count > 0)
            {
                GridViewDataComboBoxColumn combo = EmployeesGrid.Columns["DokumanTipi_TipID5"] as GridViewDataComboBoxColumn;
                combo.PropertiesComboBox.ValueType = typeof(int);
                combo.PropertiesComboBox.DataSource = tip;
            }
        }

        protected void ucDoc_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            string uploadFolder = Server.MapPath("~/Docs/");
            string resultExtension = Path.GetExtension(e.UploadedFile.FileName);
            string resultFileName = Path.ChangeExtension(Path.GetRandomFileName(), resultExtension);
            string fileName = resultFileName;
            e.UploadedFile.SaveAs(uploadFolder + fileName);
            DataProvider.docAdi = fileName;
        }

        protected void EmployeesGrid_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            string DokumanAdi = e.NewValues["DokumanAdi"].ToString();
            string tipid = e.NewValues["DokumanTipi_TipID5"].ToString();
            ASPxCheckBox checkBox = EmployeesGrid.FindEditFormTemplateControl("ASPxGridViewTemplateReplacement6") as ASPxCheckBox;
            //ASPxCheckBox checkBox = ((ASPxGridView)sender).FindEditFormLayoutItemTemplateControl("ASPxGridViewTemplateReplacement6") as ASPxCheckBox;
            db.I_Dokuman(DokumanAdi, DataProvider.docAdi, Convert.ToBoolean(checkBox.Checked), Convert.ToInt32(tipid));
            e.Cancel = true;
            EmployeesGrid.CancelEdit();
            GridUpdating();
        }

        protected void EmployeesGrid_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int rowindex = EmployeesGrid.FindVisibleIndexByKeyValue(e.Keys[EmployeesGrid.KeyFieldName]);
            ASPxGridView grid = (ASPxGridView)sender;
            var id = grid.GetRowValues(rowindex, "ID").ToString();
            db.D_Dokumanlar(Convert.ToInt32(id));
            e.Cancel = true;
            EmployeesGrid.CancelEdit();
            GridUpdating();
        }

        protected void EmployeesGrid_DataBinding(object sender, EventArgs e)
        {
            EmployeesGrid.DataSource = GridUpdating();
        }
        protected List<S_Dokumanlar_Result> GridUpdating()
        {
            var list = db.S_Dokumanlar(-1).ToList();
            if (list.Count > 0)
                return list;
            else
                return null;
        }

        protected void EmployeesGrid_CellEditorInitialize(object sender, ASPxGridViewEditorEventArgs e)
        {
            ASPxGridView grid = sender as ASPxGridView;
            if (grid.IsNewRowEditing)
            {
                if (e.Column.FieldName == "DokumanAdi")
                    e.Editor.ReadOnly = !grid.IsNewRowEditing;
                if (e.Column.FieldName == "DokumanTipi_TipID5")
                    e.Editor.ReadOnly = !grid.IsNewRowEditing;
            }
        }

        protected void ASPxCallback1_Callback(object source, CallbackEventArgs e)
        {
            int editingRowVisibleIndex = EmployeesGrid.EditingRowVisibleIndex;
            if (editingRowVisibleIndex > -1)
            {
                string rowValue = EmployeesGrid.GetRowValues(editingRowVisibleIndex, "Aktif").ToString();
                e.Result = rowValue;
            }
            else
                e.Result = "False";
        }

        protected void downloadButton_Click(object sender, EventArgs e)
        {
            //string filename = "Docs\\2kk2di2p.pdf";

            //ASPxButton button = (ASPxButton)sender;
            //GridViewDataItemTemplateContainer container = button.NamingContainer as GridViewDataItemTemplateContainer;
            //int visibleIndex = container.VisibleIndex;

            ////string text = container.Grid.GetRowValues(visibleIndex, "Text").ToString();

            //Response.Clear();
            //Response.Buffer = false;
            ////Response.AppendHeader("Content-Type", "text/html; charset=utf-8");
            ////Response.AppendHeader("Content-Transfer-Encoding", "binary");
            //Response.AppendHeader("Content-Disposition", "attachment; filename="+ filename);
            ////Response.BinaryWrite(new UTF8Encoding().GetBytes(text));
            //Response.End();

            ASPxButton button = (ASPxButton)sender;
            GridViewDataItemTemplateContainer container = button.NamingContainer as GridViewDataItemTemplateContainer;
            int visibleIndex = container.VisibleIndex;
            string text = container.Grid.GetRowValues(visibleIndex, "ID").ToString();
            var list = db.S_Dokumanlar(Convert.ToInt32(text)).ToList();
            if(list.Count>0)
            {
                SendFile(list.FirstOrDefault().DosyaAdi);
            }


        }
        private void SendFile(string param)
        {
            string fileName = "Docs/" + param;
            string filePath = Server.MapPath(fileName);
            if (!File.Exists(filePath))
            {
                Response.SuppressContent = false;
                Response.Write("Dosya bulunamadı.");
                Response.End();
                return;
            }
            string[] split = param.Split('.');
            if(split[1].ToString()=="pdf")
                Response.ContentType = "application/pdf";
            //if (split[1].ToString() == "xls")
            //    Response.ContentType = "application/xls";
            //if (split[1].ToString() == "xlsx")
            //    Response.ContentType = "application/xlsx";
            //if (split[1].ToString() == "doc")
            //    Response.ContentType = "application/doc";
            //if (split[1].ToString() == "docx")
            //    Response.ContentType = "application/docx";

            Response.AddHeader("Content-Disposition", "attachment; filename=" + param);
            Response.TransmitFile(filePath);
            Response.End();
        }
    }
}