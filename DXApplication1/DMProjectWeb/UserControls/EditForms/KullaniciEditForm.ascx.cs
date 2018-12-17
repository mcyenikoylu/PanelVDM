using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.EditForms
{
    public partial class KullaniciEditForm : EditFormUserControl
    {
        DMPortalEntities db = new DMPortalEntities();
        static string ResimAdi = "";
        protected void Page_Init(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                foreach (var item in Roles.GetAllRoles())
                {
                    cmbRole.Items.Add(item);
                }
                var bayilist = db.S_Bayi(-1).ToList();
                if (bayilist.Count > 0)
                {
                    foreach (var item in bayilist)
                    {
                        BayiKoduComboBox.Items.Add(item.BayiAdi, item.BayiKodu);
                    }
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public override Guid SaveChangesKullanici(string args)
        {
            var callbackArgs = DemoUtils.DeserializeCallbackArgs(args);
            Guid guid = new Guid();
            List<MembershipUser> employee = null;
            if (callbackArgs[0] == "New")
            {
                try
                {
                    MembershipCreateStatus status;
                    MembershipUser user = Membership.CreateUser(UserNameTextBox.Text, tbPassword.Text, EmailTextBox.Text, null, null, PurchaseAuthorityCheckBox.Checked, out status);
                    if(MembershipCreateStatus.Success != status)
                    {
                        tbPassword.ErrorText = "Şifrenin en az 6 karakter olması, büyük küçük harf ve bir özel karakter içermesi gerekmektedir. Örnek: Pamuk@22017";
                        tbPassword.IsValid = false;
                    }
                }
                catch (MembershipCreateUserException exc)
                {
                    if (exc.StatusCode == MembershipCreateStatus.DuplicateEmail || exc.StatusCode == MembershipCreateStatus.InvalidEmail)
                    {
                        EmailTextBox.ErrorText = exc.Message;
                        EmailTextBox.IsValid = false;
                    }
                    else if (exc.StatusCode == MembershipCreateStatus.InvalidPassword)
                    {
                        tbPassword.ErrorText = exc.Message;
                        tbPassword.IsValid = false;
                    }
                    else
                    {
                        UserNameTextBox.ErrorText = exc.Message;
                        UserNameTextBox.IsValid = false;
                    }
                }

                Roles.AddUserToRole(UserNameTextBox.Text, cmbRole.Text);

                int bayiId = Convert.ToInt32(db.S_BayiID(BayiKoduComboBox.SelectedItem.Value.ToString().Replace("\r\n", "")).FirstOrDefault().BayiID);
                if (bayiId == null)
                    bayiId = -1;

                ProfileBase curProfile = ProfileBase.Create(UserNameTextBox.Text);
                curProfile.SetPropertyValue("BayiCariAdi", BayiKoduComboBox.SelectedItem.Text);
                curProfile.SetPropertyValue("BayiKodu", BayiKoduComboBox.SelectedItem.Value);
                curProfile.SetPropertyValue("BayiID", bayiId.ToString());
                curProfile.SetPropertyValue("Ismi", FirstNameTextBox.Text);
                curProfile.SetPropertyValue("Soyismi", LastNameTextBox.Text);
                curProfile.SetPropertyValue("Onek", PrefixComboBox.SelectedItem == null ? "" : PrefixComboBox.SelectedItem.Value);
                curProfile.SetPropertyValue("DogumTarihi", HireDateEdit.Date.ToShortDateString());
                curProfile.SetPropertyValue("CepNumarasi", MobileNumberTextBox.Text);
                curProfile.SetPropertyValue("DepartmanAdi", DeptComboBox.SelectedItem == null ? "" : DeptComboBox.SelectedItem.Value);
                curProfile.SetPropertyValue("Unvani", TitleTextBox.Text);
                curProfile.SetPropertyValue("ResimAdi", "DefaultEmployee.png");
                curProfile.Save();
            }
            else if (callbackArgs[0] == "Edit")
            {
                if (BayiKoduComboBox.SelectedItem == null)
                    return new Guid();

                int bayiId = Convert.ToInt32(db.S_BayiID(BayiKoduComboBox.SelectedItem.Value.ToString().Replace("\r\n", "")).FirstOrDefault().BayiID);
                if (bayiId == null)
                    bayiId = -1;

                ProfileBase curProfile = ProfileBase.Create(UserNameTextBox.Text);
                curProfile.SetPropertyValue("BayiCariAdi", BayiKoduComboBox.SelectedItem.Text);
                curProfile.SetPropertyValue("BayiKodu", BayiKoduComboBox.SelectedItem.Value);
                curProfile.SetPropertyValue("BayiID", bayiId.ToString());
                curProfile.SetPropertyValue("Ismi", FirstNameTextBox.Text);
                curProfile.SetPropertyValue("Soyismi", LastNameTextBox.Text);
                curProfile.SetPropertyValue("Onek", PrefixComboBox.SelectedItem == null ? "" : PrefixComboBox.SelectedItem.Value);
                curProfile.SetPropertyValue("DogumTarihi", HireDateEdit.Date.ToShortDateString());
                curProfile.SetPropertyValue("CepNumarasi", MobileNumberTextBox.Text);
                curProfile.SetPropertyValue("DepartmanAdi", DeptComboBox.SelectedItem == null ? "" : DeptComboBox.SelectedItem.Value);
                curProfile.SetPropertyValue("Unvani", TitleTextBox.Text);
                curProfile.SetPropertyValue("ResimAdi", ResimAdi);
                curProfile.Save();

                if (Roles.GetRolesForUser(UserNameTextBox.Text)[0] == null)
                    Roles.AddUserToRole(UserNameTextBox.Text, cmbRole.Text);
                else
                {
                    if (cmbRole.Text != Roles.GetRolesForUser(UserNameTextBox.Text)[0].ToString())
                        Roles.AddUserToRole(UserNameTextBox.Text, cmbRole.Text);
                }

                MembershipUser user = Membership.GetUser(UserNameTextBox.Text);
                user.Email = EmailTextBox.Text;
                if (!chkHesapKiliti.Checked)
                {
                    user.UnlockUser();
                    chkHesapKiliti.Enabled = false;
                }
                user.IsApproved = PurchaseAuthorityCheckBox.Checked;
                Membership.UpdateUser(user);
            }

            //Guid guid = new Guid();
            if (employee == null)
                return guid;

            guid = new Guid(Membership.GetUser(UserNameTextBox.Text).ProviderUserKey.ToString());
            return guid;
        }

        public override int SaveChanges(string args)
        {
            return 0; //EditFormUserControl class'ında zorunlu olduğu için duruyor. bu ekranda guid olduğu için kullanılmıyor.
        }

        protected void KullaniciEditPopup_WindowCallback(object source, DevExpress.Web.PopupWindowCallbackArgs e)
        {
            string kullaniciAdi = e.Parameter.ToString();
            if (kullaniciAdi == null)
                return;
            ASPxEdit editor = GetNestedEditor(EmployeeEditFormLayout, "ParolaAlani");
            if (editor != null)
            {
                if (kullaniciAdi == "")
                {
                    ParolayiDegistir.Visible = false;
                    tbPassword.Visible = true;
                }
                else
                {
                    ParolayiDegistir.Visible = true;
                    tbPassword.Visible = false;
                }
            }

            var employee = Membership.GetAllUsers().Cast<MembershipUser>().Where(c => c.UserName == kullaniciAdi).FirstOrDefault(); //DataProvider.Employees.FirstOrDefault(em => em.Id == id);
            if (employee == null)
            {
                KullaniciEditPopup.JSProperties["cpUserKey"] = null;
                KullaniciEditPopup.JSProperties["cpHeaderText"] = string.Format("Yeni Kullanıcı Oluştur ({0} {1})", "", "");
            }
            else
            {
                ProfileBase curProfile = ProfileBase.Create(kullaniciAdi);

                FirstNameTextBox.Text = curProfile.GetPropertyValue("Ismi").ToString();
                LastNameTextBox.Text = curProfile.GetPropertyValue("Soyismi").ToString();
                PrefixComboBox.Value = curProfile.GetPropertyValue("Onek").ToString();
                HireDateEdit.Value = curProfile.GetPropertyValue("DogumTarihi");

                UserNameTextBox.Text = employee.UserName;
                tbPassword.Text = "parola değiştirilemez";
                EmailTextBox.Value = employee.Email;
                MobileNumberTextBox.Value = curProfile.GetPropertyValue("CepNumarasi");

                BayiKoduComboBox.Value = curProfile.GetPropertyValue("BayiKodu");
                DeptComboBox.Value = curProfile.GetPropertyValue("DepartmanAdi");
                TitleTextBox.Text = curProfile.GetPropertyValue("Unvani").ToString();
                ResimAdi = curProfile.GetPropertyValue("ResimAdi").ToString();

                PurchaseAuthorityCheckBox.Checked = employee.IsApproved;

                if (Roles.GetRolesForUser(UserNameTextBox.Text)[0] != null)
                    cmbRole.Value = Roles.GetRolesForUser(kullaniciAdi)[0] != null ? Roles.GetRolesForUser(kullaniciAdi)[0].ToString() : "";

                MembershipUser user = Membership.GetUser(employee.UserName);
                chkHesapKiliti.Enabled = user.IsLockedOut;
                chkHesapKiliti.Checked = user.IsLockedOut;

                KullaniciEditPopup.JSProperties["cpUserKey"] = kullaniciAdi;
                KullaniciEditPopup.JSProperties["cpHeaderText"] = string.Format("Kullanıcı Düzenleme ({0} {1})", curProfile.GetPropertyValue("Ismi").ToString(), curProfile.GetPropertyValue("Soyismi").ToString());
            }
        }

        protected void confirmButton_Click(object sender, EventArgs e)
        {
            bool result = Membership.GetUser(UserNameTextBox.Text).ChangePassword(Membership.GetUser(UserNameTextBox.Text).ResetPassword(), cnpsw.Text);
            ASPxPopupControl2.ShowOnPageLoad = false;
            Response.Redirect("~/KullaniciTanimlari.aspx");
        }

        private ASPxEdit GetNestedEditor(ASPxFormLayout formLayout, string itemName)
        {
            LayoutItem item = formLayout.FindItemOrGroupByName(itemName) as LayoutItem;
            if (item != null)
                return item.GetNestedControl() as ASPxEdit;
            return null;
        }

        protected void UploadControl_FilesUploadComplete(object sender, FilesUploadCompleteEventArgs e)
        {
            try
            {
                foreach (UploadedFile file in UploadControl.UploadedFiles)
                {
                    string uploadFolder = Server.MapPath("~/Images/UploadPersonel/");
                    string resultExtension = Path.GetExtension(file.FileName);
                    string resultFileName = Path.ChangeExtension(Path.GetRandomFileName(), resultExtension);
                    string fileName = resultFileName;
                    file.SaveAs(uploadFolder + fileName);
                    e.CallbackData = fileName;
                    ResimAdi = fileName.ToString();
                }
                e.CallbackData = "success";
            }
            catch (Exception hata)
            {
                e.CallbackData = "error: " + hata.Message;
            }
        }
    }
}