using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectMobil
{
    public partial class CariHesapEkstresi : System.Web.UI.Page
    {
        DMPortalEntities db = new DMPortalEntities();
        TIGER2Entities tiger2db = new TIGER2Entities();
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
            var list = tiger2db.OD_SP_006_01_CARI_EKSTRE("").ToList();
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

        protected void EmployeesGrid_CustomUnboundColumnData(object sender, DevExpress.Web.ASPxGridViewColumnDataEventArgs e)
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
    }
}