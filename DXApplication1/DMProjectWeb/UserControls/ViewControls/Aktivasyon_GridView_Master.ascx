<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Aktivasyon_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.Aktivasyon_GridView_Master" %>
<dx:ASPxGridView ID="EmployeesGrid" runat="server"
    ClientInstanceName="employeesGrid"
    Width="100%"
    AutoGenerateColumns="false"
    KeyFieldName="ID"
    KeyboardSupport="true"
    EnableRowsCache="false"
    CssClass="employeesGridView">
    <Columns>
        <dx:GridViewDataTextColumn FieldName="ID" Caption="ID" VisibleIndex="0" Visible="false" Width="5%"/>
        <dx:GridViewDataTextColumn FieldName="SistemKayitTarihSaati" Caption="Tarih" VisibleIndex="0" Width="6%">
            <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy">
            </PropertiesTextEdit>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Adi" Caption="Adı" VisibleIndex="0" Width="10%"/>
        <dx:GridViewDataTextColumn FieldName="Soyadi" Caption="Soyadı" VisibleIndex="0" Width="15%"/>
        <dx:GridViewDataTextColumn FieldName="TCKN" Caption="TCKN" VisibleIndex="0" Width="5%" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="AnneKizlikSoyadi" Caption="Anne Kizlik Soyadi" VisibleIndex="0" Width="5%" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="Adres" Caption="Adres" VisibleIndex="0" Width="5%" Visible="false"/>
        <dx:GridViewDataTextColumn FieldName="SehirAdi" Caption="Sehir" VisibleIndex="0" Width="10%"/>
        <dx:GridViewDataTextColumn FieldName="IlceAdi" Caption="İlçe" VisibleIndex="0" Width="10%"/>
        <dx:GridViewDataTextColumn FieldName="PostaKodu" Caption="Posta Kodu" VisibleIndex="0" Width="5%" Visible="false"/>
        <dx:GridViewDataTextColumn FieldName="EMailAdres" Caption="EMail Adres" VisibleIndex="0" Width="5%" Visible="false"/>
        <dx:GridViewDataTextColumn FieldName="HatTelNumarasi" Caption="Tel Numarası" VisibleIndex="0" Width="10%"/>
        <dx:GridViewDataTextColumn FieldName="IletisimTelefonu" Caption="İletişim Tel Numarası" VisibleIndex="0" Width="10%"/>
        <dx:GridViewDataTextColumn FieldName="Aciklama" Caption="Açıklama" VisibleIndex="0" Width="5%" Visible="false"/>
        <dx:GridViewDataCheckColumn FieldName="Mnp" Caption="Mnp" VisibleIndex="0" Width="5%"/>
        <dx:GridViewDataTextColumn FieldName="SimkartTipi" Caption="Simkart Tipi" VisibleIndex="0" Width="8%"/>
        <dx:GridViewDataTextColumn FieldName="SimkartSeriNo" Caption="Simkart Seri No" VisibleIndex="0" Width="8%"/>
        <dx:GridViewDataTextColumn FieldName="TarifeTipi" Caption="Tarife Tipi" VisibleIndex="0" Width="8%"/>
        <dx:GridViewDataTextColumn FieldName="TarifeAdi" Caption="Tarife Adı" VisibleIndex="0" Width="5%" Visible="false"/>
    </Columns>
    <SettingsBehavior AllowFocusedRow="true" EnableCustomizationWindow="true" AllowClientEventsOnLoad="false" ColumnResizeMode="Control" />
    <SettingsPager AlwaysShowPager="true" ShowEmptyDataRows="true" PageSize="20" />
    <Settings VerticalScrollBarMode="Auto" VerticalScrollableHeight="400" HorizontalScrollBarMode="Visible" />
    <SettingsContextMenu Enabled="true">
        <ColumnMenuItemVisibility ShowFooter="false" ShowFilterRow="false" GroupByColumn="false" ShowGroupPanel="false" />
    </SettingsContextMenu>
    <SettingsPopup>
        <CustomizationWindow HorizontalAlign="LeftSides" VerticalAlign="Below" Width="220px" Height="300px" />
    </SettingsPopup>
    <SettingsSearchPanel CustomEditorID="SearchBox" HighlightResults="True" ColumnNames="Adi; Soyadi"></SettingsSearchPanel>
    <ClientSideEvents
        Init="DevAV.Page.EmployeesGrid_Init" 
        FocusedRowChanged="DevAV.Page.EmployeesGrid_FocusedRowChanged" 
        EndCallback="DevAV.Page.EmployeesGrid_EndCallback" 
        ContextMenuItemClick="DevAV.Page.EmployeesGrid_ContextMenuItemClick"
        CustomizationWindowCloseUp="DevAV.GridCustomizationWindow_CloseUp" />
    <Styles Header-Wrap="True">
        <Table CssClass="dataTable"></Table>
        <Header CssClass="header"></Header>
        <FocusedRow CssClass="focusRow"></FocusedRow>
        <GroupPanel CssClass="groupPanel" />
    </Styles>
</dx:ASPxGridView>
