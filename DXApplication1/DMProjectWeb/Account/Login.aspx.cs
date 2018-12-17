using System;
using System.Text;
using System.Web;
using System.Web.Profile;
using System.Web.Security;

namespace DMProjectWeb.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (Request.Browser.IsMobileDevice)
                Response.Redirect("~/Mobil.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                //sonradan kaldırdım sanırım hatırlamıyoruma ama projenin hiç bir yerinde kullanılmıyor. Session["BayiID"] = ""; 
                if (Request.Cookies["DMProjectWeb"] != null)
                {
                    if (Request.Cookies["DMProjectWeb"]["kullaniciadi"] != null)
                    {
                        tbUserName.Text = Request.Cookies["DMProjectWeb"]["kullaniciadi"].ToString();
                        CmbBayiTipi.Value = Request.Cookies["DMProjectWeb"]["bayitipi"].ToString();
                        chkBeniHatirla.Checked = true;
                    }
                }
                versiyonNumarasi.InnerText = "Version " + System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString();
            }
        }

        protected void btnGiris_Click(object sender, EventArgs e)
        {
            if (Membership.ValidateUser(tbUserName.Text, tbPassword.Text))
            {
                if (string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                {
                    FormsAuthentication.SetAuthCookie(tbUserName.Text, chkBeniHatirla.Checked);
                    if (chkBeniHatirla.Checked)
                    {
                        if (Request.Cookies["DMProjectWeb"] != null)
                            Response.Cookies.Remove("DMProjectWeb");
                        
                        HttpCookie cookienesne = new HttpCookie("DMProjectWeb");
                        cookienesne["kullaniciadi"] = tbUserName.Text;
                        cookienesne["bayitipi"] = CmbBayiTipi.SelectedItem.Value.ToString();
                        cookienesne.Expires = DateTime.Now.AddMonths(12);
                        Response.Cookies.Add(cookienesne);

                    }
                    HttpCookie authCookie = FormsAuthentication.GetAuthCookie(tbUserName.Text, false);
                    FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                    FormsAuthenticationTicket newTicket = new FormsAuthenticationTicket(ticket.Version, ticket.Name, ticket.IssueDate, ticket.Expiration, ticket.IsPersistent,ticket.UserData);
                    authCookie.Value = FormsAuthentication.Encrypt(newTicket);
                    authCookie.Expires = newTicket.Expiration.AddHours(24);
                    Response.Cookies.Add(authCookie);
                    Response.Redirect("~/");
                }
                else
                    FormsAuthentication.RedirectFromLoginPage(tbUserName.Text, false);
            }
            else
            {
                tbUserName.ErrorText = " ";
                ErrorText.Text = "Hatalı kullanıcı adı veya şifre! Yada henüz onaylanmamış bir üyelik girişi yapmaya çalıştınız.";
                tbUserName.IsValid = false;
            }
        }

        protected void btnGonder_Click(object sender, EventArgs e)
        {
            try
            {
                MembershipCreateStatus status;
                MembershipUser user = Membership.CreateUser(txtKullaniciAdi_Kayit.Text, txtParola_Kayit.Text, txtEmailAdresi_Kayit.Text, null, null, false, out status);
                Response.Redirect(Request.QueryString["ReturnUrl"] ?? "~/Account/RegisterSuccess.aspx");
            }
            catch (MembershipCreateUserException exc)
            {
                if (exc.StatusCode == MembershipCreateStatus.DuplicateEmail || exc.StatusCode == MembershipCreateStatus.InvalidEmail)
                {
                    txtEmailAdresi_Kayit.ErrorText = exc.Message;
                    txtEmailAdresi_Kayit.IsValid = false;
                }
                else if (exc.StatusCode == MembershipCreateStatus.InvalidPassword)
                {
                    tbPassword.ErrorText = exc.Message;
                    tbPassword.IsValid = false;
                }
                else
                {
                    tbUserName.ErrorText = exc.Message;
                    tbUserName.IsValid = false;
                }
                ErrorTextKayit.Text = exc.Message;
            }
        }
    }
}