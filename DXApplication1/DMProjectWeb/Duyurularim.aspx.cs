using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb
{

    public partial class Duyurularim : MasterDetailPage
    {
        public override string PageName { get { return "Duyurularim"; } }
        MasterUserControl masterUC;
        DetailUserControl detailUC;
        public override MasterUserControl MasterUC { get { return masterUC; } }
        public override DetailUserControl DetailUC { get { return detailUC; } }

        DMPortalEntities db = new DMPortalEntities();
        List<S_Duyurularim_Result> list = new List<S_Duyurularim_Result>();

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

            list = db.S_Duyurularim(null).ToList();
            if (list.Count > 0)
            {
                DuyurularimGrid.DataSource = list;
                DuyurularimGrid.DataBind();
            }

        }

      
    }
}