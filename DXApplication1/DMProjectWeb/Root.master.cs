using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using System.Web.Security;
using System.Web.Profile;
using DMProjectWeb.Class;

namespace DMProjectWeb {
    public partial class RootMaster : System.Web.UI.MasterPage {

        protected void Page_Init(object sender, EventArgs e)
        {
            var pageNameScript = string.Format("<script type='text/javascript'>DevAVPageName = '{0}';</script>", PageName);
            Page.Header.Controls.AddAt(0, new LiteralControl(pageNameScript));
        }

        protected string PageName
        {
            get
            {
                var page = Page as BasePage;
                return page != null ? page.PageName : string.Empty;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //UserProfile Profile = UserProfile.GetUserProfile();
            ////Profile.CariAdi = "test";

            //Label1.Text = HttpContext.Current.Profile.GetPropertyValue("CariAdi").ToString();
            //Label1.Text = Context.Profile.GetPropertyValue("CariAdi").ToString();
            //Label1.Text = DMProjectWeb.Class.UserProfile.GetUserProfile().CariAdi;
            ////Label1.Text = Membership.GetUser().UserName;
            //Label1.Text = Profile.CariAdi;
            //Label1.Text = ProfileBase.Properties["CariAdi"].DefaultValue.ToString();

            
        }
    }
}