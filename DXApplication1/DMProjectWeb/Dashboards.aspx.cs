using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb
{
    public partial class Dashboards : MasterDetailPage
    {
        MasterUserControl masterUC;
        DetailUserControl detailUC;

        public override string PageName { get { return "Dashboards"; } }

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

                var list = db.R_AktivasyonAraRaporu().ToList();
                if (list.Count > 0)
                {
                    DevExpress.XtraCharts.Series series = new DevExpress.XtraCharts.Series();
                    string seriAdi = "";
                    foreach (var item in list)
                    {
                        if(seriAdi != item.BayiAdi)
                        {
                            seriAdi = item.BayiAdi;
                            series = new DevExpress.XtraCharts.Series(item.BayiAdi, DevExpress.XtraCharts.ViewType.Line);
                            series.DataSource = list.Where(c => c.BayiAdi == item.BayiAdi);
                            series.ArgumentDataMember = "AktivasyonTarihi";
                            series.ValueDataMembers.AddRange(new string[] { "Adet" });
                            WebChartControl3.Series.Add(series);
                        }
                     
                    }
                    
                    WebChartControl3.DataBind();


                }
            }
        }
    }
}