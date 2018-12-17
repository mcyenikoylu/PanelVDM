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
    public partial class DosyaYuklemeForm2 : EditFormUserControl
    {
        DMPortalEntities db = new DMPortalEntities();

        public override int SaveChanges(string args)
        {
            return -1;
        }
        public override Guid SaveChangesKullanici(string args) //kullanmasamda zorunlu olarak koymak zorunda kalıyorum her sayfaya.
        {
            Guid guid = new Guid();
            return guid;
        }
        protected void DosyaYuklemePopup_WindowCallback(object source, DevExpress.Web.PopupWindowCallbackArgs e)
        {
            DosyaYuklemePopup.JSProperties["cpCustomerEmployeeID"] = -1;// customerEmployee.Id;
            DosyaYuklemePopup.JSProperties["cpHeaderText"] = "test";// string.Format("Edit Customer Contact ({0} {1})", "customerEmployee.FirstName", "customerEmployee.LastName");
        }
        protected void UploadControl_FilesUploadComplete(object sender, DevExpress.Web.FilesUploadCompleteEventArgs e)
        {
            try
            {
                foreach (UploadedFile file in UploadControl.UploadedFiles)
                {
                    //string dosyaAdiUret = DateTime.Now.ToString().Replace(".", "").Replace(":", "").Replace(" ", "");

                    string uploadFolder = Server.MapPath("~/App_Data/UploadDirectory/");

                    //string fileName = file.FileName;
                    //fileName = fileName.Replace(" ", "").Replace("-", "").Replace("İ","I").Replace("Ü","U").Replace("Ş","S").Replace("Ç","C").Replace("Ö","O").Replace("Ğ","G");
                    //fileName = dosyaAdiUret + fileName;
                    string resultExtension = Path.GetExtension(file.FileName);
                    string resultFileName = Path.ChangeExtension(Path.GetRandomFileName(), resultExtension);
                    string fileName = resultFileName;

                    file.SaveAs(uploadFolder + fileName);
                    e.CallbackData = fileName;

                    Guid UserGUID = new Guid(Membership.GetUser().ProviderUserKey.ToString());
                    var sonuc = db.I_AktivasyonAraRapor_Excel(uploadFolder + fileName, UserGUID).ToList().FirstOrDefault().Sonuc;
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