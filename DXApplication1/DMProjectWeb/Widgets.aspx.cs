using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb
{
    public partial class Widgets : MasterDetailPage
    {
        MasterUserControl masterUC;
        DetailUserControl detailUC;
        public override string PageName { get { return "Widgets"; } }
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
            //"DateTime", "Mail", "News", "Trading", "Weather", "Calendar", 
            //string[] widgetNames = { "Slider" };
            //repeater.DataSource = widgetNames;
            //repeater.DataBind();

            //DockPage.Visible = true;
            var popupduyururesmi = db.S_DuyurularPopup((Guid)Membership.GetUser().ProviderUserKey).ToList();
            if(popupduyururesmi.Count>0)
            {
                if("" == popupduyururesmi.First().ResimAdi)
                    AcilisMesajiPopup.Visible = false;
                else
                    acilisDuyurusu.Src = "Images/UploadImagePopupDuyuru/" + popupduyururesmi.FirstOrDefault().ResimAdi;

            }

            // //duyuru okunmuş mu okunmamış mı?
        }
        protected string GetClientButtonClickHandler(RepeaterItem container)
        {
            return string.Format("function(s, e) {{ ShowWidgetPanel('{0}') }}", container.DataItem);
        }

        protected void AcilisDuyurusuOkundu_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            //duyuruyu okudu
            string qwe = acilisDuyurusu.Src.ToString().Replace("Images/UploadImagePopupDuyuru/", "").Split('.')[0].ToString();
            db.I_DuyurularPopupLog((Guid)Membership.GetUser().ProviderUserKey, acilisDuyurusu.Src.ToString().Replace("Images/UploadImagePopupDuyuru/", ""));
        }
    }
}