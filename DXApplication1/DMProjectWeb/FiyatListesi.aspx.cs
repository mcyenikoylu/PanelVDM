using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb
{
    public partial class FiyatListesi : MasterDetailPage
    {
        public override string PageName { get { return "FiyatListesi"; } }
        MasterUserControl masterUC;
        DetailUserControl detailUC;
        public override MasterUserControl MasterUC { get { return masterUC; } }
        public override DetailUserControl DetailUC { get { return detailUC; } }

        DMPortalEntities db = new DMPortalEntities();
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
        protected void Page_Init(object sender, EventArgs e)
        {
            LoadUserControls();
            var list = db.S_Dokumanlar(-1).Where(c => c.DokumanTipi_TipID5 == 12).ToList();
            if (list.Count > 0)
            {
                
            }
        }
        protected void LoadUserControls()
        {
            var viewMode = "GridView";// DemoUtils.IsEmployeeGridViewMode ? "GridView" : "CardView";
            this.masterUC = LoadControl("~/UserControls/ViewControls/PDFViewer_DataView_Master.ascx") as MasterUserControl;//LoadControl(string.Format("~/UserControls/ViewControls/Dokumanlar_{0}_Master.ascx", viewMode)) as MasterUserControl;
            //this.detailUC = LoadControl(string.Format("~/UserControls/ViewControls/HedefSatisDurumu_{0}_Detail.ascx", viewMode)) as DetailUserControl;

            MasterContainer.Controls.Add(MasterUC);
            //DetailsCallbackPanel.Controls.Add(DetailUC);
        }

        protected void DetailsCallbackPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {

        }
    }
}