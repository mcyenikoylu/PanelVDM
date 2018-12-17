using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.EditForms
{
    public partial class AktivasyonFaturaliEditForm : EditFormUserControl
    {
        DMPortalEntities db = new DMPortalEntities();
        protected void Page_Init(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["HatSozlesmesiDosyaAdi"] = "";
                Session["KimlikFotokopisiDosyaAdi"] = "";
                Session["EvraklarDosyaAdi"] = "";
            }
            var sehir = db.S_AdresSehir().ToList();
            if (sehir.Count > 0)
                foreach (var item in sehir)
                    CmbSehir.Items.Add(item.SehirAdi, item.ID);

            var tarife = db.S_Tarife(-1).Where(c => c.Aktif == true).ToList();
            if (tarife.Count > 0)
                foreach (var item in tarife)
                    CmbHattinTarifesi.Items.Add(item.TarifeAdi, item.ID);
        }
        protected void CmbIlce_Callback(object sender, CallbackEventArgsBase e)
        {
            FillCityCombo(e.Parameter);
        }
        protected void FillCityCombo(string countryName)
        {
            if (string.IsNullOrEmpty(countryName)) return;

            using (var context = new DMPortalEntities())
            {
                var list = context.S_AdresIlce(Convert.ToInt32(countryName)).ToList();
                CmbIlce.DataSource = list;
                CmbIlce.ValueField = "ID";
                CmbIlce.TextField = "IlceAdi";
                CmbIlce.DataBind();
            }
        }
        public override int SaveChanges(string args)
        {
            int sonucId = 0;
            var callbackArgs = DemoUtils.DeserializeCallbackArgs(args);//resimleri ekledikten sonra ne olduysa hep edit olarak geliyor artık. resim eklemesemde edit olarak geliyor işin kötüsü. 
            //sanırım bir yerleri değiştirdim bu upload controllerini eklerken. yada js dosyasında bir değişiklik yaptım. 
            if (callbackArgs[0] == "New")
            {
                ProfileBase curProfile = ProfileBase.Create(Membership.GetUser().UserName);
                string bayiid = curProfile.GetPropertyValue("BayiID").ToString();
                bool Mnp = Convert.ToBoolean(int.Parse(RbMnp.SelectedItem.Value.ToString()));
                int tipId9 = -1;
                if (Mnp)
                    tipId9 = 25; //Faturalı Mnp
                else
                    tipId9 = 27; //Faturali Hat

                Guid guid;
                guid = (Guid)Membership.GetUser().ProviderUserKey;

                var sonuc = db.I_Aktivasyon(Convert.ToInt32(bayiid), guid,
                    TxtAdi.Text,
                    TxtSoyadi.Text,
                    Convert.ToDecimal(TxtTCKN.Text),
                    TxtAnneKizlikSoyadi.Text,
                    TxtAdresTextBox.Text,
                    Convert.ToInt32(CmbSehir.SelectedItem != null ? CmbSehir.SelectedItem.Value : -1),
                    Convert.ToInt32(CmbIlce.SelectedItem != null ? CmbIlce.SelectedItem.Value : -1),
                    Convert.ToInt32(TxtPostaKoduTextBox.Text),
                    TxtEmailTextBox.Text,
                    TxtSabitTelTextBox.Text,
                    TxtCepTelTextBox.Text,
                    TxtSimSeriNo.Text,
                    Convert.ToInt32(CmbHattinTarifesi.SelectedItem.Value),
                    TxtAciklama.Text,
                    Mnp,
                    tipId9,null).ToList();
                sonucId = (int)sonuc.First().ID;
                db.I_AktivasyonEvrak(Session["HatSozlesmesiDosyaAdi"].ToString(), 1, 31, sonucId);
                db.I_AktivasyonEvrak(Session["KimlikFotokopisiDosyaAdi"].ToString(), 1, 32, sonucId);
                db.I_AktivasyonEvrak(Session["EvraklarDosyaAdi"].ToString(), 1, 33, sonucId);
            }
            else if (callbackArgs[0] == "Edit")
            {
                int id = Convert.ToInt32(callbackArgs[1]);
                //bu satıra update sp gelecek.
                sonucId = id;
            }
            Session["HatSozlesmesiDosyaAdi"] = "";
            Session["KimlikFotokopisiDosyaAdi"] = "";
            Session["EvraklarDosyaAdi"] = "";
            return sonucId;
        }
        public override Guid SaveChangesKullanici(string args)
        {
            return new Guid();
        }
        protected void PcAktFaturali_WindowCallback(object source, PopupWindowCallbackArgs e)
        {
            string id = e.Parameter.ToString();
            //var list = db.S_Bayi(Convert.ToInt32(id)).ToList();
            //if (list.Count > 0)
            //{
            //    //BayiKoduTextBox.Text = list.First().BayiKodu;
            //    //BayiAdiTextBox.Text = list.First().BayiAdi;
            //    //BayiCariAdiTextBox.Text = list.First().BayiCariAdi;
            //    //YetkiliAdiSoyadiTextBox.Text = list.First().YetkiliAdiSoyadi;
            //    //AdresTextBox.Text = list.First().Adres;
            //    //CmbSehir.Text = list.First().SehirAdi;//cmbSehir.Value = list.First().SehirID;
            //    //CmbIlce.Text = list.First().IlceAdi;//cmbIlce.Value = list.First().IlceID;
            //    ////PostaKoduTextBox.Text = 
            //    //EmailTextBox.Text = list.First().Mail;
            //    //CepTelTextBox.Text = list.First().Cep;
            //    //SabitTelTextBox.Text = list.First().Telefon;
            //    //FaksTelTextBox.Text = list.First().Faks;
            //    //cmbMusteriTemsilcisi.Value = list.First().MusteriTemsilcisiID.ToString();
            //    //cmbGrup.Text = list.First().GrupAdi;//cmbGrup.Value = list.First().Grup_TipID1;
            //    //cmbBolge.Text = list.First().BolgeAdi; //cmbBolge.Value = list.First().Bolge_TipID2;
            //    //cmbBayiTipi.Text = list.First().BayiTipiAdi; //cmbBayiTipi.Value = list.First().BayiTipi_TipID3;
            //    //BayiDurumCheckBox.Checked = Convert.ToBoolean(list.First().Aktif);
            //}
            PcAktFaturali.JSProperties["cpEmployeeID"] = id;// list.First().ID;
            PcAktFaturali.JSProperties["cpHeaderText"] = string.Format("Aktivasyon Faturalı ({0} {1})", "", "");
        }
        protected void UcHatSozlesmesi_FilesUploadComplete(object sender, FilesUploadCompleteEventArgs e)
        {
            try
            {
                string fileContent = "";
                foreach (UploadedFile file in UcHatSozlesmesi.UploadedFiles)
                {
                    string uploadFolder = Server.MapPath("~/Images/UploadAktivasyon/");
                    string resultExtension = Path.GetExtension(file.FileName);
                    string resultFileName = Path.ChangeExtension(Path.GetRandomFileName(), resultExtension);
                    string fileName = resultFileName;
                    file.SaveAs(uploadFolder + fileName);
                    Session["HatSozlesmesiDosyaAdi"] += fileName + ",";
                    string extension = System.IO.Path.GetExtension(file.FileName).TrimStart('.');
                    string header = string.Format("data:image/{0};base64,", extension);
                    fileContent = string.Format("{0}{1}", header, Convert.ToBase64String(file.FileBytes));
                }
                Session["HatSozlesmesiDosyaAdi"] = Session["HatSozlesmesiDosyaAdi"].ToString().Substring(0, Session["HatSozlesmesiDosyaAdi"].ToString().Length - 1);
                e.CallbackData = "success" + "|" + fileContent;
            }
            catch (Exception hata)
            {
                e.CallbackData = "error: " + hata.Message;
            }
        }
        protected void UcKimlikFotokopisi_FilesUploadComplete(object sender, FilesUploadCompleteEventArgs e)
        {
            try
            {
                string fileContent = "";
                foreach (UploadedFile file in UcKimlikFotokopisi.UploadedFiles)
                {
                    string uploadFolder = Server.MapPath("~/Images/UploadAktivasyon/");
                    string resultExtension = Path.GetExtension(file.FileName);
                    string resultFileName = Path.ChangeExtension(Path.GetRandomFileName(), resultExtension);
                    string fileName = resultFileName;
                    file.SaveAs(uploadFolder + fileName);
                    Session["KimlikFotokopisiDosyaAdi"] += fileName + ",";
                    string extension = System.IO.Path.GetExtension(file.FileName).TrimStart('.');
                    string header = string.Format("data:image/{0};base64,", extension);
                    fileContent = string.Format("{0}{1}", header, Convert.ToBase64String(file.FileBytes));
                }
                Session["KimlikFotokopisiDosyaAdi"] = Session["KimlikFotokopisiDosyaAdi"].ToString().Substring(0, Session["KimlikFotokopisiDosyaAdi"].ToString().Length - 1);
                e.CallbackData = "success" + "|" + fileContent;
            }
            catch (Exception hata)
            {
                e.CallbackData = "error: " + hata.Message;
            }
        }
        protected void UcEvraklar_FilesUploadComplete(object sender, FilesUploadCompleteEventArgs e)
        {
            try
            {
                string fileContent = "";
                foreach (UploadedFile file in UcEvraklar.UploadedFiles)
                {
                    string uploadFolder = Server.MapPath("~/Images/UploadAktivasyon/");
                    string resultExtension = Path.GetExtension(file.FileName);
                    string resultFileName = Path.ChangeExtension(Path.GetRandomFileName(), resultExtension);
                    string fileName = resultFileName;
                    file.SaveAs(uploadFolder + fileName);
                    Session["EvraklarDosyaAdi"] += fileName + ",";
                    string extension = System.IO.Path.GetExtension(file.FileName).TrimStart('.');
                    string header = string.Format("data:image/{0};base64,", extension);
                    fileContent += string.Format("{0}{1}", header, Convert.ToBase64String(file.FileBytes)) + "@";
                }
                Session["EvraklarDosyaAdi"] = Session["EvraklarDosyaAdi"].ToString().Substring(0, Session["EvraklarDosyaAdi"].ToString().Length - 1);
                e.CallbackData = "success" + "|" + fileContent;
            }
            catch (Exception hata)
            {
                e.CallbackData = "error: " + hata.Message;
            }
        }
    }
}