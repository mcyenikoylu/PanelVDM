using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb
{
    public partial class SiparisHareketleri : MasterDetailPage
    {
        DMPortalEntities db = new DMPortalEntities();
        public override string PageName { get { return "SiparisHareketleri"; } }
        MasterUserControl masterUC;
        DetailUserControl detailUC;
        public override MasterUserControl MasterUC { get { return masterUC; } }
        public override DetailUserControl DetailUC { get { return detailUC; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
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
            }
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            LoadUserControls();
        }
        protected void LoadUserControls()
        {
            var viewMode = "GridView";// DemoUtils.IsEmployeeGridViewMode ? "GridView" : "CardView";
            this.masterUC = LoadControl(string.Format("~/UserControls/ViewControls/Siparis_{0}_Master.ascx", viewMode)) as MasterUserControl;
            //this.detailUC = LoadControl(string.Format("~/UserControls/ViewControls/HedefSatisDurumu_{0}_Detail.ascx", viewMode)) as DetailUserControl;

            MasterContainer.Controls.Add(MasterUC);
            //DetailsCallbackPanel.Controls.Add(DetailUC);
        }

        protected void DetailsCallbackPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {

        }
    }
}