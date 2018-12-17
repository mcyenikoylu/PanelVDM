using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb
{
    public partial class RaporMalzemeSonAlimMaliyeti : MasterDetailPage
    {
        DMPortalEntities db = new DMPortalEntities();
        public override string PageName { get { return "RaporMalzemeSonAlimMaliyeti"; } }
        MasterUserControl masterUC;
        DetailUserControl detailUC;
        public override MasterUserControl MasterUC { get { return masterUC; } }
        public override DetailUserControl DetailUC { get { return detailUC; } }
        protected void Page_Init(object sender, EventArgs e)
        {
            LoadUserControls();
        }
        protected void LoadUserControls()
        {
            var viewMode = "GridView";// DemoUtils.IsEmployeeGridViewMode ? "GridView" : "CardView";
            this.masterUC = LoadControl(string.Format("~/UserControls/ViewControls/RaporMalzemeSonAlimMaliyeti_{0}_Master.ascx", viewMode)) as MasterUserControl;
            //this.detailUC = LoadControl(string.Format("~/UserControls/ViewControls/HedefSatisDurumu_{0}_Detail.ascx", viewMode)) as DetailUserControl;

            MasterContainer.Controls.Add(MasterUC);
            //DetailsCallbackPanel.Controls.Add(DetailUC);
        }
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

        protected void DetailsCallbackPanel_Callback(object sender, CallbackEventArgsBase e)
        {
            var args = DemoUtils.DeserializeCallbackArgs(e.Parameter);
            if (args.Count == 0)
                return;
            var callbackName = args[0];
            //if (callbackName == "SaveEditForm")
            //    GetEditForm(args[1]).SaveChanges(args[2]);
            //if(callbackName == "DeleteEntry") {
            //    long entryID = long.Parse(args[2]);
            //    if(entryID == DataProvider.emptyEntryID)
            //        return;
            //    switch(args[1]) {
            //        case "Task":
            //            DataProvider.DeleteTask(entryID);
            //            break;
            //        case "Evaluation":
            //            DataProvider.DeleteEvaluation(entryID);
            //            break;
            //    }
            //}
            UpdateDetail();
        }

    }
}