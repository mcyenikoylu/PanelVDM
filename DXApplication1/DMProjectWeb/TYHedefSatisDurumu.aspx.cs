using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb
{
    public partial class TYHedefSatisDurumu : MasterDetailPage
    {
        MasterUserControl masterUC;
        DetailUserControl detailUC;
        //public override FilterBag FilterBag { get { return DemoUtils.EmployeeFilter; } }

        public override string PageName { get { return "TYHedefSatisDurumu"; } }

        DMPortalEntities db = new DMPortalEntities();

        public override MasterUserControl MasterUC { get { return masterUC; } }
        public override DetailUserControl DetailUC { get { return detailUC; } }
        
        protected void Page_Init(object sender, EventArgs e)
        {
            DateTime i = new DateTime();
            DateTime s = new DateTime();
            //i = DateTime.Now.AddMonths(-2);
            //s = DateTime.Now.Date;
            i = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            s = i.AddMonths(1).AddDays(-1);
            ASPxDateEdit1.Value = i;
            ASPxDateEdit2.Value = s;

            LoadUserControls();
        }
        
        protected void LoadUserControls()
        {
            var viewMode = "GridView";// DemoUtils.IsEmployeeGridViewMode ? "GridView" : "CardView";
            this.masterUC = LoadControl(string.Format("~/UserControls/ViewControls/HedefSatisDurumu_{0}_Master.ascx", viewMode)) as MasterUserControl;
            this.detailUC = LoadControl(string.Format("~/UserControls/ViewControls/HedefSatisDurumu_{0}_Detail.ascx", viewMode)) as DetailUserControl;

            MasterUC.BaslangicTarihi = Convert.ToDateTime(ASPxDateEdit1.Value);
            MasterUC.BitisTarihi = Convert.ToDateTime(ASPxDateEdit2.Value);

            MasterContainer.Controls.Add(MasterUC);
            DetailsCallbackPanel.Controls.Add(DetailUC);
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

        protected void btnGetir_Click(object sender, EventArgs e)
        {
            MasterUC.BaslangicTarihi = Convert.ToDateTime(ASPxDateEdit1.Value);
            MasterUC.BitisTarihi = Convert.ToDateTime(ASPxDateEdit2.Value);
            MasterUC.Update();
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            export.WriteXlsToResponse();

        }

        protected void btnPDF_Click(object sender, EventArgs e)
        {
            export.WritePdfToResponse();

        }
    }
}