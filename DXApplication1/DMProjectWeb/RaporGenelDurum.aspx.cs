using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb
{
    public partial class RaporGenelDurum : MasterDetailPage
    {
        DMPortalEntities db = new DMPortalEntities();
        public override string PageName { get { return "RaporGenelDurum"; } }
        MasterUserControl masterUC;
        DetailUserControl detailUC;
        public override MasterUserControl MasterUC { get { return masterUC; } }
        public override DetailUserControl DetailUC { get { return detailUC; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                //LOGİN GİRİŞ BAŞLANGIÇ
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
                //LOGİN GİRİŞ BİTİŞ

            }
        }
    }
}