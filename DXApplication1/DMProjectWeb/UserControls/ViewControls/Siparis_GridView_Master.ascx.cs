using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.ViewControls
{
    public partial class Siparis_GirdView_Master : MasterUserControl
    {
        DMPortalEntities db = new DMPortalEntities();

        protected void Page_Load(object sender, EventArgs e)
        {
            Update();
        }

        public override void Update()
        {
            BindGrid();
            UpdateDetail();
        }

        protected void BindGrid()
        {
            var urun = db.S_Urunler().ToList();
            if(urun.Count>0)
            {
                GridViewDataComboBoxColumn combo = EmployeesGrid.Columns["UrunID"] as GridViewDataComboBoxColumn;
                combo.PropertiesComboBox.ValueType = typeof(int);
                combo.PropertiesComboBox.DataSource = urun;
            }
            var tip = db.S_Tip(6).ToList();
            if (tip.Count > 0)
            {
                GridViewDataComboBoxColumn combo = EmployeesGrid.Columns["Onay"] as GridViewDataComboBoxColumn;
                combo.PropertiesComboBox.ValueType = typeof(int);
                combo.PropertiesComboBox.DataSource = tip;
            }
            ProfileBase curProfile = ProfileBase.Create(Membership.GetUser().UserName);
            string bayiid = curProfile.GetPropertyValue("BayiID").ToString();
            var list = db.S_Siparislerim(Convert.ToInt32(bayiid)).ToList();
            if(list.Count>0)
            {
                EmployeesGrid.DataSource = list;
                EmployeesGrid.DataBind();
            }
        }

        protected void EmployeesGrid_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            string adet = e.NewValues["Adet"].ToString();
            string urunid = e.NewValues["UrunID"].ToString();
            ProfileBase curProfile = ProfileBase.Create(Membership.GetUser().UserName);
            string bayiid = curProfile.GetPropertyValue("BayiID").ToString();
            db.I_Siparislerim(Convert.ToInt32(bayiid), Convert.ToInt32(urunid), Convert.ToInt32(adet));
            e.Cancel = true;
            EmployeesGrid.CancelEdit();
            Update();
        }
    }
}