<%@ Control Language="C#" ClassName="NewsWidget" %>
<script runat="server">
    protected void Page_Init(object sender, EventArgs e) {
        ASPxNewsControl.ItemSettings.DateVerticalPosition = DateVerticalPosition.BelowHeader;
        ASPxNewsControl.ItemSettings.DateHorizontalPosition = DateHorizontalPosition.Right;
        ASPxNewsControl.Paddings.Padding = 10;
        ASPxNewsControl.ContentStyle.Paddings.Padding = 0;
    }
</script>
<dx:ASPxNewsControl ID="ASPxNewsControl" runat="server" NavigateUrlFormatString="javascript:void('{0}');"
    Width="100%">
    <Border BorderStyle="None"/>
    <ItemSettings ImagePosition="Left" MaxLength="120" TailText="detaylar..">
    </ItemSettings>
    <Items>
        <dx:NewsItem Date="09.08.2017" 
            HeaderText="Red Pass Hedef- Satış Durumu Hk."
            Text="Red Pass satış durumları Portalda EKSTRA 1 satış durumu , EKSTRA 2 hedef , Ekstra 3 gerçekleştirilen olarak paylaşılacaktır. Bilgilerinize..">
        </dx:NewsItem>
        <dx:NewsItem Date="07.08.2017" 
            HeaderText="AKSESUAR TATİL KAMPANYASI HAKKINDA"
            Text="Aksesuar tatil kampanyası detayları portala yüklenmiştir. Dökümanlar bölümünden takip edebilirsiniz. Detaylarını Satış Temsilcinizden öğrenebilirsiniz.">
        </dx:NewsItem>
        <dx:NewsItem Date="03.08.2017" 
            HeaderText="Temmuz 2017 Temlikleri Portala Yüklenmiştir"
            Text="23 Haziran-22 Temmuz DÖNEMİNE AİT CİHAZ TEMLİK ÖDEMELERİNİZİ ''CİHAZ TEMLİK'' EKRANINDAN ÖĞRENEBİLİRSİNİZ">
        </dx:NewsItem>
    </Items>
</dx:ASPxNewsControl>
