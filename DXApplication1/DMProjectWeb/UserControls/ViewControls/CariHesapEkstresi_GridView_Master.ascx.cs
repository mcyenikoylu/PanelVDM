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
    public partial class CariHesapEkstresi_GridView_Master : MasterUserControl
    {
        DMPortalEntities db = new DMPortalEntities();
        TIGER2Entities tiger2db = new TIGER2Entities();

        private DateTime _BaslangicTarihi = new DateTime();
        private DateTime _BitisTarihi = new DateTime();
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
            //EmployeesGrid.DataSource = DataProvider.Employees.ToList();
            //EmployeesGrid.FilterExpression = OwnerPage.FilterBag.GetExpression(false);
            //EmployeesGrid.DataBind();

            _BaslangicTarihi = OwnerPage.BaslangicTarihi;
            _BitisTarihi = OwnerPage.BitisTarihi;
            ProfileBase curProfile = ProfileBase.Create(Membership.GetUser().UserName);
            string BayiKodu = curProfile.GetPropertyValue("BayiKodu").ToString();
            if (Roles.GetRolesForUser(Membership.GetUser().UserName)[0].ToString() == "PersonelYonetici" ||
                Roles.GetRolesForUser(Membership.GetUser().UserName)[0].ToString() == "PersonelTeknik" ||
                Roles.GetRolesForUser(Membership.GetUser().UserName)[0].ToString() == "TemsilciYonetici" ||
                Roles.GetRolesForUser(Membership.GetUser().UserName)[0].ToString() == "DeveloperUser" ||
                Roles.GetRolesForUser(Membership.GetUser().UserName)[0].ToString() == "Muhasebe")
            {
                if (BayiKodu == null || BayiKodu == "") //if ile yönetici yetkisi roles dan kontrol edip -1 göndermek lazım.
                    BayiKodu = "-1";
            }
            var list = tiger2db.OD_SP_006_01_CARI_EKSTRE(BayiKodu).ToList();
            //var list = db.OD_SP_006_01_CARI_EKSTRE(BayiKodu).ToList();
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
            //SON SAYFADAKİ SON SATIRI SEÇTİRMEK İÇİN YAPMIŞTIM, ŞİMDİLİK GEREK KALMADI.
            //int a = EmployeesGrid.PageCount;
            //EmployeesGrid.PageIndex = a;
            //EmployeesGrid.FocusedRowIndex = EmployeesGrid.VisibleRowCount;
        }
        protected void EmployeesGrid_CustomUnboundColumnData(object sender, DevExpress.Web.ASPxGridViewColumnDataEventArgs e)
        {
            try
            {
                if (e.Column.FieldName == "Total")
                {
                    if (e.IsGetData)
                    {
                        int visibleIndex = EmployeesGrid.FindVisibleIndexByKeyValue(e.GetListSourceFieldValue("FISNO"));
                        e.Value = (visibleIndex != 0) ?
                            Convert.ToDecimal(EmployeesGrid.GetRowValues(visibleIndex, "BORC")) + Convert.ToDecimal(EmployeesGrid.GetRowValues(visibleIndex, "ALACAK")) + Convert.ToDecimal(EmployeesGrid.GetRowValues(visibleIndex - 1, "Total")) :
                            Convert.ToDecimal(EmployeesGrid.GetRowValues(visibleIndex, "BORC")) - Convert.ToDecimal(EmployeesGrid.GetRowValues(visibleIndex - 1, "Total"));
                    }
                }
            }
            catch (Exception hata)
            {
                return;
            }
        }
        //protected object GetSummaryValue(string fieldName)
        //{
        //    ASPxSummaryItem summaryItem = EmployeesGrid.TotalSummary.First(i => i.Tag == fieldName + "_Sum");
        //    return EmployeesGrid.GetTotalSummaryValue(summaryItem);
        //}
    }
}
