<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HedefSatisDurumu_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.HedefSatisDurumu_GridView_Master" %>

<dx:ASPxGridView ID="EmployeesGrid" runat="server" 
    ClientInstanceName="employeesGrid" 
    Width="100%" 
    AutoGenerateColumns="false" 
    KeyFieldName="ID" 
    KeyboardSupport="true" 
    EnableRowsCache="false"
    CssClass="employeesGridView">
    <Columns>
  <dx:GridViewDataTextColumn FieldName="ID" Caption="ID" Width="150" VisibleIndex="0" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="BayiKodu" Caption="Bayi Kodu" Width="150" VisibleIndex="0" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="BayiAdi" Caption="Bayi Adı" Width="150" VisibleIndex="0" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="SistemKayitTarihi" Caption="Sistem Kayıt Tarihi" Width="150" VisibleIndex="1" Visible="false">
            <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy">
            </PropertiesTextEdit>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="KayitOlusturanUserKey" Caption="Kayıt Olusturan UserKey" Width="150" VisibleIndex="2" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="Ay" Caption="Ay" Width="50" Visible="true" VisibleIndex="3" />
        <dx:GridViewDataTextColumn FieldName="Yil" Caption="Yıl" Width="50" Visible="true" VisibleIndex="4" />
        <dx:GridViewDataTextColumn FieldName="BayiID" Caption="Bayi ID" Width="150" Visible="false" VisibleIndex="5" />
        <dx:GridViewDataTextColumn FieldName="PrePaidToplamGross" Caption="PrePaid Toplam Gross" Width="150" Visible="true" VisibleIndex="6" />
        <dx:GridViewDataTextColumn FieldName="PrePaidSesToplamNet" Caption="PrePaid Ses Toplam Net" Width="150" Visible="true" VisibleIndex="7" />
        <dx:GridViewDataTextColumn FieldName="PrePaidSesToplamHedef" Caption="PrePaid Ses Toplam Hedef" Width="150" Visible="true" VisibleIndex="8" />
        <dx:GridViewDataTextColumn FieldName="PrePaidToplamNetHedefYuzdesi" Caption="PrePaid Toplam Net Hedef Yuzdesi" Width="150" Visible="true" VisibleIndex="9">
            <PropertiesTextEdit DisplayFormatString="p2" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="BireyselPostpaidToplamGross" Caption="Bireysel Postpaid Toplam Gross" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="BireyselPostpaidSesGross" Caption="Bireysel Postpaid Ses Gross" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="BireyselPostpaidSesNet" Caption="Bireysel Postpaid Ses Net" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="BireyselPostpaidSesHedef" Caption="Bireysel Postpaid Ses Hedef" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="BireyselPostpaidSesHedefYuzdesi" Caption="Bireysel Postpaid Ses Hedef Yuzdesi" Width="150" Visible="true" >
            <PropertiesTextEdit DisplayFormatString="p2" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="BireyselPostpaidDataGross" Caption="Bireysel Postpaid Data Gross" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="BireyselPostpaidDataNet" Caption="Bireysel Postpaid Data Net" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="BireyselPostpaidDataHedef" Caption="Bireysel Postpaid Data Hedef" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="BireyselPostpaidDataHedefYuzdesi" Caption="Bireysel Postpaid Data Hedef Yuzdesi" Width="150" Visible="true" >
            <PropertiesTextEdit DisplayFormatString="p2" />
            </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="REDBireyselAdet" Caption="RED Bireysel Adet" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="REDBireyselNet" Caption="RED Bireysel Net" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="REDBireyselHedef" Caption="RED Bireysel Hedef" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="REDBireyselHedefYuzdesi" Caption="RED Bireysel Hedef Yuzdesi" Width="150" Visible="true" >
            <PropertiesTextEdit DisplayFormatString="p2" />
            </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="KurumsalPostpaidToplam" Caption="Kurumsal Postpaid Toplam" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="KurumsalPostpaidSesGross" Caption="Kurumsal Postpaid Ses Gross" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="KurumsalPostpaidSesNet" Caption="Kurumsal Postpaid Ses Net" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="KurumsalPostpaidSesHedef" Caption="Kurumsal Postpaid Ses Hedef" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="KurumsalPostpaidSesHedefYuzdesi" Caption="Kurumsal Postpaid Ses Hedef Yuzdesi" Width="150" Visible="true" >
            <PropertiesTextEdit DisplayFormatString="p2" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="PreToPost" Caption="Pre To Post" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="PreToPostNet" Caption="Pre To Post Net" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="PreToPostHedef" Caption="Pre To Post Hedef" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="PreToPostNetYuzdesi" Caption="Pre To Post Net Yuzdesi" Width="150" Visible="true" >
            <PropertiesTextEdit DisplayFormatString="p2" />
            </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Genclik" Caption="Gençlik" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="GenclikNet" Caption="Gençlik Net" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="GenclikHedef" Caption="Gençlik Hedef" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="GenclikNetYuzdesi" Caption="Gençlik Net Yuzdesi" Width="150" Visible="true" >
            <PropertiesTextEdit DisplayFormatString="p2" />
            </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="REDUpSell" Caption="RED Up Sell" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="REDUpSellNet" Caption="RED Up Sell Net" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="REDUpSellHedef" Caption="RED Up Sell Hedef" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="REDUpSellNetYuzdesi" Caption="RED Up Sell Net Yuzdesi" Width="150" Visible="true" >
            <PropertiesTextEdit DisplayFormatString="p2" />
            </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="ToplamPrePaidBekleyen" Caption="Toplam PrePaid Bekleyen" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="ToplamPostPaidBekleyen" Caption="Toplam PostPaid Bekleyen" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="HvcAdet" Caption="Hvc Adet" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="HvcHedef" Caption="Hvc Hedef" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="MassAdet" Caption="Mass Adet" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="MassHedef" Caption="Mass Hedef" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="FirsatAdet" Caption="Firsat Adet" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="FirsatHedef" Caption="Firsat Hedef" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="TabletAdet" Caption="Tablet Adet" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="TabletHedef" Caption="Tablet Hedef" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="ToplamCihazAdet" Caption="Toplam Cihaz Adet" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="ToplamCihazHedef" Caption="Toplam Cihaz Hedef" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="ToplamCihazGerceklesmeYuzdesi" Caption="Toplam Cihaz Gerceklesme Yuzdesi" Width="150" Visible="true" >
            <PropertiesTextEdit DisplayFormatString="p2" />
            </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="VodemToplamAktivasyon" Caption="Vodem Toplam Aktivasyon" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="AdslOrder" Caption="Adsl Order" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="AdslAktif" Caption="Adsl Aktif" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="AdslHedef" Caption="Adsl Hedef" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="AdslGerceklesmeYuzdesi" Caption="Adsl Gerceklesme Yuzdesi" Width="150" Visible="true" >
            <PropertiesTextEdit DisplayFormatString="p2" />
            </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="VodafonePassADET" Caption="Vodafone Pass ADET" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="VodafonePassHedef" Caption="Vodafone Pass Hedef" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="VodafonePassYuzdesi" Caption="Vodafone Pass Yuzdesi" Width="150" Visible="true" >
            <PropertiesTextEdit DisplayFormatString="p2" />
            </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Extra4" Caption="Extra4" Width="150" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="FILTRE1VDMKODU" Caption="Filtre 1 VDM Kodu" Width="150" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="FILTRE2BOLGEYONETICI" Caption="Filtre 2 Bölge Yönetici" Width="150" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="FILTRE3SATISTEMSILCI" Caption="Filtre 3 Satış Temsilci" Width="150" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="FILTRE4ILCE" Caption="Filtre 4 İlçe" Width="150" Visible="false" />
    </Columns>
    <SettingsBehavior AllowFocusedRow="true" EnableCustomizationWindow="true" AllowClientEventsOnLoad="false" ColumnResizeMode="Control"  />
    <SettingsPager AlwaysShowPager="true" ShowEmptyDataRows="true" PageSize="15" />
    <Settings VerticalScrollBarMode="Auto" VerticalScrollableHeight="400" HorizontalScrollBarMode="Visible" />
    <SettingsContextMenu Enabled="true">
        <ColumnMenuItemVisibility ShowFooter="false" ShowFilterRow="false" GroupByColumn="false" ShowGroupPanel="false" />
    </SettingsContextMenu>
    <SettingsPopup>
        <CustomizationWindow HorizontalAlign="LeftSides" VerticalAlign="Below" Width="220px" Height="300px" />
    </SettingsPopup>
    <SettingsSearchPanel CustomEditorID="SearchBox" HighlightResults="True" ColumnNames="FirstName; LastName"></SettingsSearchPanel>
    <ClientSideEvents 
        CustomizationWindowCloseUp="DevAV.GridCustomizationWindow_CloseUp" />
    <Styles Header-Wrap="True">
        <Table CssClass="dataTable"></Table>
        <Header CssClass="header"></Header>
        <FocusedRow CssClass="focusRow"></FocusedRow>
        <GroupPanel CssClass="groupPanel" />
    </Styles>
</dx:ASPxGridView>
