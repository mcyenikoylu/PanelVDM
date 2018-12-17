using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace DMProjectWeb
{
    public partial class AktivasyonTaahhutname : MasterDetailPage
    {
        MasterUserControl masterUC;
        DetailUserControl detailUC;
        public override string PageName { get { return "AktivasyonTaahhutname"; } }
        DMPortalEntities db = new DMPortalEntities();

        public override MasterUserControl MasterUC { get { return masterUC; } }
        public override DetailUserControl DetailUC { get { return detailUC; } }
        protected void Page_Init(object sender, EventArgs e)
        {
            LoadUserControls();
        }

        protected void LoadUserControls()
        {
            var viewMode = "GridView";// DemoUtils.IsEmployeeGridViewMode ? "GridView" : "CardView";
            this.masterUC = LoadControl(string.Format("~/UserControls/ViewControls/AktivasyonTaahhutname_{0}_Master.ascx", viewMode)) as MasterUserControl;
            //this.detailUC = LoadControl(string.Format("~/UserControls/ViewControls/BayiTanimlari_{0}_Detail.ascx", viewMode)) as DetailUserControl;

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

        protected void DetailsCallbackPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            var args = DemoUtils.DeserializeCallbackArgs(e.Parameter);
            if (args.Count == 0)
                return;
            var callbackName = args[0];
            if (callbackName == "SaveEditForm")
                GetEditForm(args[1]).SaveChanges(args[2]);
            if (callbackName == "DeleteEntry")
            {
                long entryID = long.Parse(args[2]);
                if (entryID == DataProvider.emptyEntryID)
                    return;
                switch (args[1])
                {
                    //case "Task":
                    //    DataProvider.DeleteTask(entryID);
                    //    break;
                    //case "Evaluation":
                    //    DataProvider.DeleteEvaluation(entryID);
                    //    break;
                }
            }
            UpdateDetail();
        }
        EditFormUserControl GetEditForm(string name)
        {
            //if (name == "Task")
            //    return TaskEditForm;
            if (name == "Evaluation")
                return AktivasyonTaahhutnameEditForm;
            return null;
        }
        public override void SaveEditFormChanges(string parameters)
        {
            //GUid geri dönüşü için veri tipini değiştirdim.
            //MasterUC.SelectedItemID = KullaniciEditForm.SaveChanges(parameters); // TODO rename SaveChanges
            MasterUC.SelectedItemID = AktivasyonTaahhutnameEditForm.SaveChanges(parameters);
        }
        public override void DeleteEntry(string employeeID)
        {
            //DataProvider.DeleteEmployee(long.Parse(employeeID));
            string username = employeeID.ToString();
            //Membership.DeleteUser(username, true);
            MasterUC.Update();
        }

    }
}