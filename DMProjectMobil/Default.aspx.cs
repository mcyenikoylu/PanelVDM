using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectMobil {
    public partial class _Default : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack)
            {
                //LOGÝN GÝRÝÞ BAÞLANGIÇ
                Guid userId = new Guid();
                if (Membership.GetUser() != null)
                    userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());
                else
                {
                    FormsAuthentication.SignOut();
                    Session.Abandon();
                    Response.Redirect("~/Account/Login.aspx");
                    return;
                }
                //LOGÝN GÝRÝÞ BÝTÝÞ

            }
        }

    }
}