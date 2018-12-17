using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.ViewControls
{
    public partial class CihazTakip_GridView_Master : MasterUserControl
    {
        DMPortalEntities db = new DMPortalEntities();
        TIGER2Entities tiger2db = new TIGER2Entities();
        private string _AramaKelimesi;
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
            _AramaKelimesi = "%"+OwnerPage.AramaKelimesi+"%";
            if (OwnerPage.AramaKelimesi == null || OwnerPage.AramaKelimesi == "")
                return;

            var listCihazTakip = tiger2db.OD_SP_CihazTakip(_AramaKelimesi).ToList();
            var listAraRapor = db.S_CihazTakipAraRapor().ToList();

            List<CihazTakip> list = new List<CihazTakip>();

            foreach (var item in listCihazTakip)
            {
                if(listAraRapor.Count>0)
                {
                    foreach (var item2 in listAraRapor)
                    {
                        if(item.IMEI == item2.IMEI.ToString())
                        {
                            //*******************
                            DateTime baslamaTarihi = (DateTime)item.FATURA_TAR;
                            DateTime bitisTarihi = (DateTime)item2.AktivasyonTarihi;
                            TimeSpan kalangun = bitisTarihi - baslamaTarihi;//Sonucu zaman olarak döndürür
                            int toplamGun = (int)kalangun.TotalDays;// kalanGun den TotalDays ile sadece toplam gun değerini çekiyoruz. 
                            //*******************
                            var c = new CihazTakip
                            {
                                BayiAdi = item.FIRMA_ISMI,
                                BayiKodu = item2.BayiKodu,
                                CihazAdi = item.STOK_ACIKLAMASI,
                                CihazKodu = item.STOK_KODU,
                                IMEI = item.IMEI,
                                FaturaTarihi = (DateTime)item.FATURA_TAR,
                                FaturaTutari = (decimal)item.FATURA_NET_TUTARI,
                                BayiSatisTarihi = (DateTime)item2.AktivasyonTarihi,
                                Gun = toplamGun
                            };
                            list.Add(c);
                        }
                    }
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

        protected void EmployeesGrid_HtmlRowPrepared(object sender, DevExpress.Web.ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType != GridViewRowType.Data) return;
            int price = Convert.ToInt32(e.GetValue("Gun"));
            if(price >= 15)
            {
                e.Row.BackColor = System.Drawing.Color.LightPink;
            }
            else
            {
                e.Row.BackColor = System.Drawing.Color.LightGreen;
            }
        }
    }
    public class CihazTakip
    {
        public string BayiAdi { get; set; }
        public string BayiKodu { get; set; }
        public string CihazKodu { get; set; }
        public string CihazAdi { get; set; }
        public string IMEI { get; set; }
        public DateTime FaturaTarihi { get; set; }
        public decimal FaturaTutari { get; set; }
        public DateTime BayiSatisTarihi { get; set; }
        public int Gun { get; set; }
    }
}