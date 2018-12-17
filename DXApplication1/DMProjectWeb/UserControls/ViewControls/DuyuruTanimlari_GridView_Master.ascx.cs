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
    public partial class DuyuruTanimlari_GridView_Master : MasterUserControl
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
            if (!IsPostBack)
                Session["resimadi"] = "";

            Update();//duyurular
            GridUpdating();//slider duyurular
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

            var list = db.S_Duyurularim(null).ToList();
            if (list.Count > 0)
            {
                EmployeesGrid.DataSource = list;
                EmployeesGrid.DataBind();
            }
        }
        void GridUpdating()
        {
            var list = db.S_DuyurularSlider(-1).ToList();
            if (list.Count > 0)
            {
                DuyurularSliderGrid.DataSource = list;
                DuyurularSliderGrid.DataBind();
            }
        }
        protected void EmployeesGrid_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            string Baslik = e.NewValues["Baslik"].ToString();
            string Aciklama = e.NewValues["Aciklama"].ToString();
            string Tarih = e.NewValues["DuyuruTarihi"].ToString();
            db.I_Duyurular(Baslik, Aciklama, Convert.ToDateTime(Tarih));
            e.Cancel = true;
            grid.CancelEdit();
            BindGrid();
        }

        protected void EmployeesGrid_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            string id = grid.GetRowValues(grid.EditingRowVisibleIndex, "ID").ToString();
            string Baslik = e.NewValues["Baslik"].ToString();
            string Aciklama = e.NewValues["Aciklama"].ToString();
            string Tarih = e.NewValues["DuyuruTarihi"].ToString();
            db.U_Duyurular(Convert.ToInt32(id), Baslik, Aciklama, Convert.ToDateTime(Tarih));
            e.Cancel = true;
            grid.CancelEdit();
            BindGrid();
        }

        protected void EmployeesGrid_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            int rowindex = EmployeesGrid.FindVisibleIndexByKeyValue(e.Keys[EmployeesGrid.KeyFieldName]);
            string id = grid.GetRowValues(rowindex, "ID").ToString();
            db.D_Duyurular(Convert.ToInt32(id));
            e.Cancel = true;
            grid.CancelEdit();
            BindGrid();
            
        }

        protected void DuyurularSliderGrid_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            ASPxCheckBox checkBox = ((ASPxGridView)sender).FindEditFormLayoutItemTemplateControl("ASPxGridViewTemplateReplacement6") as ASPxCheckBox;
            string SlideAdi = e.NewValues["SlideAdi"].ToString();
            string SiraNo = e.NewValues["SiraNo"].ToString();
            db.I_DuyurularSlider(Session["resimadi"].ToString(), Convert.ToInt32(SiraNo), checkBox.Checked, SlideAdi);
            Session["resimadi"] = "";
            e.Cancel = true;
            grid.CancelEdit();
            GridUpdating();
        }

        protected void DuyurularSliderGrid_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            ASPxGridView grid = (ASPxGridView)sender;
            string id = grid.GetRowValues(grid.EditingRowVisibleIndex, "ID").ToString();
            string SlideAdi = e.NewValues["SlideAdi"].ToString();
            string SiraNo = e.NewValues["SiraNo"].ToString();
            ASPxCheckBox checkBox = ((ASPxGridView)sender).FindEditFormLayoutItemTemplateControl("ASPxGridViewTemplateReplacement6") as ASPxCheckBox;
            db.U_DuyurularSlider(Convert.ToInt32(id), Session["resimadi"].ToString(), Convert.ToInt32(SiraNo), checkBox.Checked, SlideAdi);
            Session["resimadi"] = "";
            e.Cancel = true;
            grid.CancelEdit();
            GridUpdating();
        }

        protected void DuyurularSliderGrid_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int rowindex = DuyurularSliderGrid.FindVisibleIndexByKeyValue(e.Keys[DuyurularSliderGrid.KeyFieldName]);
            ASPxGridView grid = (ASPxGridView)sender;
            var id = grid.GetRowValues(rowindex, "ID").ToString();
            db.D_DuyurularSlider(Convert.ToInt32(id));
            e.Cancel = true;
            grid.CancelEdit();
            GridUpdating();
        }

        protected void SlideResmiAktif_Callback(object source, CallbackEventArgs e)
        {
            int editingRowVisibleIndex = DuyurularSliderGrid.EditingRowVisibleIndex;
            if (editingRowVisibleIndex > -1)
            {
                string rowValue = DuyurularSliderGrid.GetRowValues(editingRowVisibleIndex, "Aktif").ToString();
                e.Result = rowValue;
            }
            else
                e.Result = "False";
        }

        protected void MyUploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            if (e.IsValid)
            {
                //string dosyaAdiUret = DateTime.Now.ToString().Replace(".", "").Replace(":", "").Replace(" ", "").Replace("/", "");
                string uploadFolder = Server.MapPath("~/Images/UploadImageSlider/");
                string resultExtension = Path.GetExtension(e.UploadedFile.FileName);
                string resultFileName = Path.ChangeExtension(Path.GetRandomFileName(), resultExtension);
                string fileName = resultFileName;//e.UploadedFile.FileName;
                //fileName = fileName.Replace(" ", "").Replace("-", "").Replace("İ", "I").Replace("Ü", "U").Replace("Ş", "S").Replace("Ç", "C").Replace("Ö", "O").Replace("Ğ", "G").Replace("ş", "s").Replace("ç", "c").Replace("ğ", "g").Replace("ö", "o").Replace("ü", "u");
                //fileName = dosyaAdiUret + fileName;
                e.UploadedFile.SaveAs(uploadFolder + fileName);
                Session["resimadi"] = fileName;

                string extension = System.IO.Path.GetExtension(e.UploadedFile.FileName).TrimStart('.');
                string header = string.Format("data:image/{0};base64,", extension);
                string fileContent = string.Format("{0}{1}", header, Convert.ToBase64String(e.UploadedFile.FileBytes));
                string fileDate = DateTime.Now.ToShortDateString();
                e.CallbackData = e.UploadedFile.FileName + "|" + extension + "|" + fileDate + "|" + fileContent + "|" + fileName;
            }
        }
        public string popupresimyolu { get; set; }
        protected void UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            //popup duyuru
            string resultExtension = Path.GetExtension(e.UploadedFile.FileName);
            string resultFileName = Path.ChangeExtension(Path.GetRandomFileName(), resultExtension);
            string resultFileUrl = "~/Images/UploadImagePopupDuyuru/" + resultFileName;
            string resultFilePath = MapPath(resultFileUrl);
            db.I_DuyurularPopup(resultFileName, "");
            e.UploadedFile.SaveAs(resultFilePath);
            popupresimyolu = resultFileUrl.Replace("~/", "../../");
        }
    }
}