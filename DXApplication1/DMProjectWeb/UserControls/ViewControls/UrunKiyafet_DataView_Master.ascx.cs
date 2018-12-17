using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.ViewControls
{
    public partial class UrunKiyafet_DataView_Master : MasterUserControl
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
            var list = db.S_Urunler().Where(c => c.KategoriID_TipID4 == 10).ToList();
            if (list.Count > 0)
            {
                ASPxDataView1.DataSource = list;
                ASPxDataView1.DataBind();
            }
        }

    }
}