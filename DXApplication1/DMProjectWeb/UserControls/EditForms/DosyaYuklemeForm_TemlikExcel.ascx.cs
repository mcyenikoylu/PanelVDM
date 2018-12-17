using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.EditForms
{
    public partial class DosyaYuklemeForm_TemlikExcel : EditFormUserControl
    {
        DMPortalEntities db = new DMPortalEntities();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void UploadControl_FilesUploadComplete(object sender, DevExpress.Web.FilesUploadCompleteEventArgs e)
        {
            try
            {
                foreach (UploadedFile file in UploadControl.UploadedFiles)
                {
                    //string dosyaAdiUret = DateTime.Now.ToString().Replace(".", "").Replace(":", "").Replace(" ", "");
                    string uploadFolder = Server.MapPath("~/App_Data/UploadDirectory/");
                    string resultExtension = Path.GetExtension(file.FileName);
                    string resultFileName = Path.ChangeExtension(Path.GetRandomFileName(), resultExtension);
                    string fileName = resultFileName;//e.UploadedFile.FileName;
                    file.SaveAs(uploadFolder + fileName);
                    e.CallbackData = fileName;
                    Guid UserGUID = new Guid(Membership.GetUser().ProviderUserKey.ToString());
                    var sonuc = db.I_TemlikRapor_Excel(uploadFolder + fileName, UserGUID).ToList();
                    //var sonuc = db.I_AktivasyonAraRapor_Excel(uploadFolder + fileName, UserGUID).ToList().FirstOrDefault().Sonuc;
                }

                ////ASPxGridView1.DataSource = DataProvider.GetCagriIstekYenile();
                ////ASPxGridView1.DataSourceID = String.Empty;
                ////ASPxGridView1.DataBind();

                //DosyaYuklemePopup.JSProperties["cpVisible"] = "false";
                e.CallbackData = "success";
            }
            catch (Exception hata)
            {
                e.CallbackData = "error: " + hata.Message;
            }
        }

        protected void DosyaYuklemePopup_WindowCallback(object source, DevExpress.Web.PopupWindowCallbackArgs e)
        {
            DosyaYuklemePopup.JSProperties["cpCustomerEmployeeID"] = -1;// customerEmployee.Id;
            DosyaYuklemePopup.JSProperties["cpHeaderText"] = "test";// string.Format("Edit Customer Contact ({0} {1})", "customerEmployee.FirstName", "customerEmployee.LastName");
        }
        public override int SaveChanges(string args)
        {
            return -1;
        }
        public override Guid SaveChangesKullanici(string args) //kullanmasamda zorunlu olarak koymak zorunda kalıyorum her sayfaya.
        {
            Guid guid = new Guid();
            return guid;
        }

        protected void UploadControlGuncelle_FilesUploadComplete(object sender, FilesUploadCompleteEventArgs e)
        {
            // ay ve yıl combobox'ın daki parametreleri SP ye gönderip o ay aralığındaki kayıtları silip yeni excel yüklenecek.

            try
            {
                foreach (UploadedFile file in UploadControlGuncelle.UploadedFiles)
                {
                    //string dosyaAdiUret = DateTime.Now.ToString().Replace(".", "").Replace(":", "").Replace(" ", "");
                    string uploadFolder = Server.MapPath("~/App_Data/UploadDirectory/");
                    string resultExtension = Path.GetExtension(file.FileName);
                    string resultFileName = Path.ChangeExtension(Path.GetRandomFileName(), resultExtension);
                    string fileName = resultFileName;//e.UploadedFile.FileName;
                    file.SaveAs(uploadFolder + fileName);
                    e.CallbackData = fileName;
                    Guid UserGUID = new Guid(Membership.GetUser().ProviderUserKey.ToString());
                    db.D_TemlikRapor_Excel(Convert.ToInt32(CmbAy.Value) , Convert.ToInt32(CmbYil.Value), "", null);
                    var sonuc = db.I_TemlikRapor_Excel(uploadFolder + fileName, UserGUID).ToList();
                    //var sonuc = db.I_AktivasyonAraRapor_Excel(uploadFolder + fileName, UserGUID).ToList().FirstOrDefault().Sonuc;
                }

                ////ASPxGridView1.DataSource = DataProvider.GetCagriIstekYenile();
                ////ASPxGridView1.DataSourceID = String.Empty;
                ////ASPxGridView1.DataBind();

                //DosyaYuklemePopup.JSProperties["cpVisible"] = "false";

                e.CallbackData = "success";
            }
            catch (Exception hata)
            {
                e.CallbackData = "error: " + hata.Message;
            }
        }
    }
}