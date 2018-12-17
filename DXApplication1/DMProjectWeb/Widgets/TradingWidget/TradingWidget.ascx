<%@ Control Language="C#" ClassName="Trading" %>
<%@ Register Src="~/Widgets/TradingWidget/MarketLeadersTableRow.ascx" TagName="MarketLeadersTableRow" TagPrefix="uc" %>
<%@ Register Src="~/Widgets/TradingWidget/CurrencyRatesTableRow.ascx" TagName="CurrencyRatesTableRow" TagPrefix="uc" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        DMProjectWeb.TIGER2Entities tiger2db = new DMProjectWeb.TIGER2Entities();
        DMProjectWeb.DMPortalEntities db = new DMProjectWeb.DMPortalEntities();
        ProfileBase curProfile = ProfileBase.Create(Membership.GetUser().UserName);
        string bayikodu = curProfile.GetPropertyValue("BayiKodu").ToString();
        string BayiID = curProfile.GetPropertyValue("BayiID").ToString();
        if (bayikodu != "")
        {
            List<BayiFinansOzeti> finansList = new List<BayiFinansOzeti>();
            var bakiyeList = tiger2db.OD_SP_BayiBakiye(bayikodu).ToList();
            if (bakiyeList.Count > 0)
            {
                var r = new BayiFinansOzeti
                {
                    baslik = "Cari Bakiye",
                    deger = bakiyeList.First().Bakiye.ToString()
                };
                finansList.Add(r);
                var q = new BayiFinansOzeti
                {
                    baslik = "Borç",
                    deger = bakiyeList.First().Borc.ToString()
                };
                finansList.Add(q);
                var w = new BayiFinansOzeti
                {
                    baslik = "Alacak",
                    deger = bakiyeList.First().Alacak.ToString()
                };
                finansList.Add(w);

                var ekstreList = tiger2db.OD_SP_006_01_CARI_EKSTRE(bayikodu).ToList();
                if (ekstreList.Count > 0)
                {
                    foreach (var item in ekstreList)
                        if (item.ALACAK < 0)
                        {
                            var x = new BayiFinansOzeti
                            {
                                baslik = "Son Temlik",
                                deger = item.ALACAK.ToString()
                            };
                            finansList.Add(x);
                            goto _break;
                        }
                }
                else
                {
                    var x = new BayiFinansOzeti
                    {
                        baslik = "Son Temlik",
                        deger = "-"
                    };
                    finansList.Add(x);
                }
                _break:;

                var primList = db.S_PrimHakedisRaporu(Convert.ToInt32(BayiID)).ToList();
                var z = new BayiFinansOzeti
                {
                    baslik = "Son Prim Hakedişi",
                    deger = primList.First().MahsupSonrasiKalanTutarKDVDahil.ToString()
                };
                finansList.Add(z);
          
                Rpt.DataSource = finansList;
                Rpt.DataBind();
            }
        }
    }
    public class BayiFinansOzeti
    {
        public string baslik { get; set; }
        public string deger { get; set; }
    }
</script>

<dx:ASPxLabel runat="server" ID="ASPxLabel1" Text="Finans Özet Bilgilerim" Font-Bold="true">
</dx:ASPxLabel>

<table width="100%">
    <asp:Repeater ID="Rpt" runat="server">
        <ItemTemplate>
            <tr>
                <td style="width: 30%; text-align: left;">
                    <dx:ASPxHyperLink runat="server" ID="IndexHyperLink" NavigateUrl="javascript:void(0)" Text='<%# Eval("baslik") %>' />
                </td>
                <td style="width: 30%; text-align: center;">
                    <dx:ASPxLabel runat="server" ID="ValueLabel" Text='<%# Eval("deger") %>' />
                </td>
                <td style="width: 30%; text-align: center;">
                    <dx:ASPxLabel runat="server" ID="GrowthLabel" ForeColor="Green" Text='<%# Eval("deger") %>' />
                </td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>

</table>

<%--<dx:ASPxLabel runat="server" ID="ASPxLabel2" Text="Bireysel Postpaid Toplam (Ağustos)" Font-Bold="true">
</dx:ASPxLabel>
<table width="100%">
    <uc:MarketLeadersTableRow runat="server" Index="Ses Net Hedef" Value="22" Growth="85,71%"/>
    <uc:MarketLeadersTableRow runat="server" Index="Ses Net" Value="18" />
    <uc:MarketLeadersTableRow runat="server" Index="Ses Toplam Gross" Value="18" />
    <uc:MarketLeadersTableRow runat="server" Index="Data Net Hedef" Value="0" Growth="0,0%"/>
    <uc:MarketLeadersTableRow runat="server" Index="Data Net" Value="0" />
    <uc:MarketLeadersTableRow runat="server" Index="Data Toplam Gross" Value="0" />
</table>

<dx:ASPxLabel runat="server" ID="ASPxLabel3" Text="RED Bireysel (Ağustos)" Font-Bold="true">
</dx:ASPxLabel>
<table width="100%">
    <uc:MarketLeadersTableRow runat="server" Index="Hedef" Value="13" Growth="46,15%"/>
    <uc:MarketLeadersTableRow runat="server" Index="Net" Value="6" />
    <uc:MarketLeadersTableRow runat="server" Index="Adet" Value="6" />
</table>

<dx:ASPxLabel runat="server" ID="ASPxLabel4" Text="Kurumsal Postpaid Toplam (Ağustos)" Font-Bold="true">
</dx:ASPxLabel>
<table width="100%">
    <uc:MarketLeadersTableRow runat="server" Index="Ses Hedef" Value="2" Growth="0,0%"/>
    <uc:MarketLeadersTableRow runat="server" Index="Ses Net" Value="0" />
    <uc:MarketLeadersTableRow runat="server" Index="Ses Gross" Value="0" />
    <uc:MarketLeadersTableRow runat="server" Index="Ses Toplam" Value="0" />
</table>

<dx:ASPxLabel runat="server" ID="currencyLalbel" Text="Döviz kurları (Bugün)" Font-Bold="true">
</dx:ASPxLabel>
<table width="100%" style="text-align: center;">
    <uc:CurrencyRatesTableRow runat="server" Currency="USD" Value="1.3932" Growth="+0.0014" />
    <uc:CurrencyRatesTableRow runat="server" Currency="EUR" Value="0.0348" Growth="-0.0001" />
</table>--%>
