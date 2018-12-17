using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Web.Profile;

namespace DMProjectWeb {
    public partial class Register : System.Web.UI.Page {

        DMPortalEntities db = new DMPortalEntities();

        protected void Page_Load(object sender, EventArgs e) {
            
        }

        protected void btnCreateUser_Click(object sender, EventArgs e) {
            try {

                MembershipUser user = Membership.CreateUser(tbUserName.Text, tbPassword.Text, tbEmail.Text);
                Roles.AddUserToRole(tbUserName.Text, cmbRole.Text);

                //sp den o kullanýcýnýn seçmiþ 

                //ProfileBase curProfile = ProfileBase.Create(Membership.GetUser().UserName);

                //curProfile.SetPropertyValue("BayiCariAdi", Membership.GetUser().UserName);
                //curProfile.SetPropertyValue("BayiKodu", Membership.GetUser().UserName);
                //curProfile.SetPropertyValue("BayiID", Membership.GetUser().UserName);

                //curProfile.Save();

                Response.Redirect(Request.QueryString["ReturnUrl"] ?? "~/Account/RegisterSuccess.aspx");
            }
            catch (MembershipCreateUserException exc) {
                if (exc.StatusCode == MembershipCreateStatus.DuplicateEmail || exc.StatusCode == MembershipCreateStatus.InvalidEmail) {
                    tbEmail.ErrorText = exc.Message;
                    tbEmail.IsValid = false;
                }
                else if (exc.StatusCode == MembershipCreateStatus.InvalidPassword) {
                    tbPassword.ErrorText = exc.Message;
                    tbPassword.IsValid = false;
                }
                else {
                    tbUserName.ErrorText = exc.Message;
                    tbUserName.IsValid = false;
                }
            }
        }
    }
}