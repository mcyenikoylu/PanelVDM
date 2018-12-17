using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.ViewControls
{
    public partial class CariTakip_GridView_Master : MasterUserControl
    {
        DMPortalEntities db = new DMPortalEntities();
        TIGER2Entities tiger2db = new TIGER2Entities();
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

            var listBakiye = tiger2db.OD_SP_BayiBakiye(null).ToList();
            var listTeminat = db.S_BayiTeminat().ToList();

            List<BayiBakiyeTeminat> list = new List<BayiBakiyeTeminat>();

            foreach (var item in listBakiye)
            {
                if (listTeminat.Count > 0)
                {
                    foreach (var item2 in listTeminat)
                    {
                        if (item.CODE == item2.BayiKodu)
                        {
                            var c = new BayiBakiyeTeminat
                            {
                                BayiKodu = item.CODE,
                                BayiAdi = item.BayiAdi,
                                Bakiye = (decimal)item.Bakiye,
                                Teminat = (decimal)item2.Teminat
                            };
                            list.Add(c);
                        }
                    }
                }
                else
                {
                    var c = new BayiBakiyeTeminat
                    {
                        BayiKodu = item.CODE,
                        BayiAdi = item.BayiAdi,
                        Bakiye = (decimal)item.Bakiye,
                        Teminat = (decimal)0
                    };
                    list.Add(c);
                }
            }

            if (list.Count > 0)
            {
                EmployeesGrid.DataSource = list;
                EmployeesGrid.DataBind();
            }
            else
            {
                EmployeesGrid.DataSource = null;
                EmployeesGrid.DataBind();
            }

        }
    }
    public class BayiBakiyeTeminat
    {
        public string BayiKodu { get; set; }
        public string BayiAdi { get; set; }
        public decimal Bakiye { get; set; }
        public decimal Teminat { get; set; }
    }
}