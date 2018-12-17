using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.EditForms
{
    public partial class BayiEditForm : EditFormUserControl
    {
        DMPortalEntities db = new DMPortalEntities();
        protected void Page_Init(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var list = db.S_Tip(-1).ToList();
                if (list.Count > 0)
                {
                    //foreach (var item in list.Where(c => c.AyiracID == 1))
                    //{
                    //    cmbGrup.Items.Add(item.TipAdi, item.ID);
                    //}
                    //foreach (var item in list.Where(c => c.AyiracID == 2))
                    //{
                    //    cmbBolge.Items.Add(item.TipAdi, item.ID);
                    //}

                    foreach (var item in list.Where(c => c.AyiracID == 3))
                    {
                        cmbBayiTipi.Items.Add(item.TipAciklama, item.ID);
                    }

                    var bolge = db.S_Bolge().ToList();
                    if(bolge.Count>0)
                        foreach (var item in bolge)
                        {
                            cmbBolge.Items.Add(item.Adi, item.ID);
                        }

                    var grup = db.S_Grup().ToList();
                    if(grup.Count>0)
                    {
                        foreach (var item in grup)
                        {
                            cmbGrup.Items.Add(item.Adi, item.ID);
                        }
                    }
                }
                var musteriTemsilcisi = db.S_MusteriTemsilcisi(null).ToList();
                if (musteriTemsilcisi.Count > 0)
                {
                    foreach (var item in musteriTemsilcisi)
                    {
                        cmbMusteriTemsilcisi.Items.Add(item.AdiSoyadi, item.ID);
                    }
                }

                var sehir = db.S_AdresSehir().ToList();
                if (sehir.Count > 0)
                {
                    foreach (var item in sehir)
                    {
                        CmbSehir.Items.Add(item.SehirAdi, item.ID);
                    }
                }
            }
        }
        public override int SaveChanges(string args)
        {
            var callbackArgs = DemoUtils.DeserializeCallbackArgs(args);
            if (callbackArgs[0] == "New")
            {
                var listbayi = db.I_Bayi(Convert.ToBoolean(BayiDurumCheckBox.Checked),
                    BayiKoduTextBox.Text,
                    BayiAdiTextBox.Text,
                    BayiCariAdiTextBox.Text,
                   Convert.ToInt32(cmbGrup.SelectedItem.Value),
                   Convert.ToInt32(cmbBolge.SelectedItem.Value),
                   Convert.ToInt32(CmbSehir.SelectedItem.Value),
                   CmbIlce.SelectedItem != null ? Convert.ToInt32(CmbIlce.SelectedItem.Value) : -1,
                   Convert.ToInt32(-1),
                   Convert.ToInt32(-1),
                   Convert.ToInt32(PostaKoduTextBox.Value),
                    AdresTextBox.Text,
                    SabitTelTextBox.Text,
                    FaksTelTextBox.Text,
                    CepTelTextBox.Text,
                   EmailTextBox.Text,
                    YetkiliAdiSoyadiTextBox.Text,
                    Convert.ToInt32(cmbMusteriTemsilcisi.SelectedItem.Value),
                    Convert.ToInt32(cmbBayiTipi.SelectedItem.Value),
                    "").ToList();

                if(listbayi.Count>0)
                {
                    BayiEditPopup.JSProperties["cpEmployeeID"] = listbayi.First().ID.ToString();

                }
                else
                {
                    BayiEditPopup.JSProperties["cpEmployeeID"] = 0;

                }
            }
            else if (callbackArgs[0] == "Edit")
            {
                int bayiId = Convert.ToInt32(callbackArgs[1]);
                db.U_Bayi(bayiId,
                    Convert.ToBoolean(BayiDurumCheckBox.Checked),
                    BayiKoduTextBox.Text,
                    BayiAdiTextBox.Text,
                    BayiCariAdiTextBox.Text,
                   Convert.ToInt32(cmbGrup.SelectedItem.Value),
                   Convert.ToInt32(cmbBolge.SelectedItem.Value),
                   Convert.ToInt32(CmbSehir.SelectedItem.Value),
                    Convert.ToInt32(CmbIlce.SelectedItem == null ? -1 : CmbIlce.SelectedItem.Value),
                   Convert.ToInt32(-1),
                   Convert.ToInt32(-1),
                   Convert.ToInt32(PostaKoduTextBox.Value),
                    AdresTextBox.Text,
                    SabitTelTextBox.Text,
                    FaksTelTextBox.Text,
                    CepTelTextBox.Text,
                   EmailTextBox.Text,
                    YetkiliAdiSoyadiTextBox.Text,
                    Convert.ToInt32(cmbMusteriTemsilcisi.SelectedItem.Value),
                    Convert.ToInt32(cmbBayiTipi.SelectedItem.Value),
                    "");
            }
            else if(callbackArgs[0] == "NewVeKullanici")
            {
                var list = db.I_Bayi(Convert.ToBoolean(BayiDurumCheckBox.Checked),
                    BayiKoduTextBox.Text,
                    BayiAdiTextBox.Text,
                    BayiCariAdiTextBox.Text,
                   Convert.ToInt32(cmbGrup.SelectedItem.Value),
                   Convert.ToInt32(cmbBolge.SelectedItem.Value),
                   Convert.ToInt32(CmbSehir.SelectedItem.Value),
                   CmbIlce.SelectedItem != null ? Convert.ToInt32(CmbIlce.SelectedItem.Value) : -1,
                   Convert.ToInt32(-1),
                   Convert.ToInt32(-1),
                   Convert.ToInt32(PostaKoduTextBox.Value),
                    AdresTextBox.Text,
                    SabitTelTextBox.Text,
                    FaksTelTextBox.Text,
                    CepTelTextBox.Text,
                   EmailTextBox.Text,
                    YetkiliAdiSoyadiTextBox.Text,
                    Convert.ToInt32(cmbMusteriTemsilcisi.SelectedItem.Value),
                    Convert.ToInt32(cmbBayiTipi.SelectedItem.Value),
                    "").ToList();

                if(list.Count>0)
                {
                    //kullanici kaydı
                    try
                    {
                        bool purchaseAuthorityCheckBox = true; //kullanici kaydı aktif mi olacak.
                        MembershipCreateStatus status;
                        MembershipUser user = Membership.CreateUser(BayiKoduTextBox.Text, "123456", EmailTextBox.Text, null, null, purchaseAuthorityCheckBox, out status);
                        //if (MembershipCreateStatus.Success != status)
                        //{
                        //    tbPassword.ErrorText = "Şifrenin en az 6 karakter olması, büyük küçük harf ve bir özel karakter içermesi gerekmektedir. Örnek: Pamuk@22017";
                        //    tbPassword.IsValid = false;
                        //}
                    }
                    catch (MembershipCreateUserException exc)
                    {
                        if (exc.StatusCode == MembershipCreateStatus.DuplicateEmail || exc.StatusCode == MembershipCreateStatus.InvalidEmail)
                        {
                            EmailTextBox.ErrorText = exc.Message;
                            EmailTextBox.IsValid = false;
                        }
                        //else if (exc.StatusCode == MembershipCreateStatus.InvalidPassword)
                        //{
                        //    tbPassword.ErrorText = exc.Message;
                        //    tbPassword.IsValid = false;
                        //}
                        //else
                        //{
                        //    UserNameTextBox.ErrorText = exc.Message;
                        //    UserNameTextBox.IsValid = false;
                        //}
                    }

                    Roles.AddUserToRole(BayiKoduTextBox.Text, cmbBayiTipi.Text); //silver bayi guid si; 9EE02807-FA76-427B-BFDC-8884B9E5448F

                    int bayiId = Convert.ToInt32(db.S_BayiID(BayiKoduTextBox.Text.Replace("\r\n", "")).FirstOrDefault().BayiID);
                    if (bayiId == null)
                        bayiId = -1;

                    ProfileBase curProfile = ProfileBase.Create(BayiKoduTextBox.Text);
                    curProfile.SetPropertyValue("BayiCariAdi", BayiCariAdiTextBox.Text);
                    curProfile.SetPropertyValue("BayiKodu", BayiKoduTextBox.Text);
                    curProfile.SetPropertyValue("BayiID", bayiId.ToString());
                    curProfile.SetPropertyValue("Ismi", YetkiliAdiSoyadiTextBox.Text);
                    curProfile.SetPropertyValue("Soyismi", "");
                    curProfile.SetPropertyValue("Onek", "");
                    curProfile.SetPropertyValue("DogumTarihi", "");
                    curProfile.SetPropertyValue("CepNumarasi", CepTelTextBox.Text);
                    curProfile.SetPropertyValue("DepartmanAdi", "");
                    curProfile.SetPropertyValue("Unvani", "");
                    curProfile.SetPropertyValue("ResimAdi", "DefaultEmployee.png");
                    curProfile.Save();

                    BayiEditPopup.JSProperties["cpEmployeeID"] = list.First().ID.ToString();
                }
                else
                {
                    BayiEditPopup.JSProperties["cpEmployeeID"] = 0;
                }
            }
            return 0; //EditFormUserControl class'ında zorunlu olduğu için duruyor. bu ekranda guid olduğu için kullanılmıyor.
        }
        public override Guid SaveChangesKullanici(string args)
        {
            return new Guid();
        }
        private ASPxEdit GetNestedEditor(ASPxFormLayout formLayout, string itemName)
        {
            LayoutItem item = formLayout.FindItemOrGroupByName(itemName) as LayoutItem;
            if (item != null)
                return item.GetNestedControl() as ASPxEdit;
            return null;
        }
        protected void BayiEditPopup_WindowCallback(object source, PopupWindowCallbackArgs e)
        {
            string id = e.Parameter.ToString();
            if (id != "")
            {
                var list = db.S_Bayi(Convert.ToInt32(id)).ToList();
                if (list.Count > 0)
                {
                    BayiKoduTextBox.Text = list.First().BayiKodu;
                    BayiAdiTextBox.Text = list.First().BayiAdi;
                    BayiCariAdiTextBox.Text = list.First().BayiCariAdi;
                    YetkiliAdiSoyadiTextBox.Text = list.First().YetkiliAdiSoyadi;
                    AdresTextBox.Text = list.First().Adres;
                    CmbSehir.Text = list.First().SehirAdi;//cmbSehir.Value = list.First().SehirID;
                    CmbIlce.Text = list.First().IlceAdi;//cmbIlce.Value = list.First().IlceID;
                                                        //PostaKoduTextBox.Text = 
                    EmailTextBox.Text = list.First().Mail;
                    CepTelTextBox.Text = list.First().Cep;
                    SabitTelTextBox.Text = list.First().Telefon;
                    FaksTelTextBox.Text = list.First().Faks;
                    cmbMusteriTemsilcisi.Value = list.First().MusteriTemsilcisiID.ToString();
                    cmbGrup.Text = list.First().GrupAdi;//cmbGrup.Value = list.First().Grup_TipID1;
                    cmbBolge.Text = list.First().BolgeAdi; //cmbBolge.Value = list.First().Bolge_TipID2;
                    cmbBayiTipi.Text = list.First().BayiTipiAdi; //cmbBayiTipi.Value = list.First().BayiTipi_TipID3;
                    BayiDurumCheckBox.Checked = Convert.ToBoolean(list.First().Aktif);
                    BayiEditPopup.JSProperties["cpEmployeeID"] = list.First().ID;
                    BayiEditPopup.JSProperties["cpHeaderText"] = string.Format("Yeni Bayi Oluştur ({0} {1})", list.First().YetkiliAdiSoyadi, "");
                }
            }
            else
            {
                BayiEditPopup.JSProperties["cpEmployeeID"] = null;
                BayiEditPopup.JSProperties["cpHeaderText"] = string.Format("Yeni Bayi Oluştur ({0} {1})", "", "");
            }
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
    }
}