<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BayiTanimlari_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.BayiTanimlari_GridView_Master" %>
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
        <dx:GridViewDataTextColumn FieldName="BayiKodu" Caption="Bayi Kodu" Width="8%" VisibleIndex="1" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="BayiAdi" Caption="Bayi Adı" Width="20%" VisibleIndex="2" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="SistemKayitTarihi" Caption="Sistem Kayıt Tarihi" Width="150" VisibleIndex="0" Visible="false">
            <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy">
            </PropertiesTextEdit>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="BayiCariAdi" Caption="Bayi Cari Adi" Width="150" VisibleIndex="0" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="YetkiliAdiSoyadi" Caption="Yetkili Adi Soyadi" Width="15%" VisibleIndex="3" Visible="true" />
        <dx:GridViewDataCheckColumn FieldName="Aktif" Caption="Aktif" Width="5%" VisibleIndex="4" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="Adres" Caption="Adres" Width="150" VisibleIndex="0" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="Telefon" Caption="Telefon" Width="10%" VisibleIndex="5" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="Faks" Caption="Faks" Width="150" VisibleIndex="0" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="Cep" Caption="Cep" Width="10%" VisibleIndex="6" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="Mail" Caption="Mail" Width="150" VisibleIndex="0" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="GrupAdi" Caption="Grup Adi" Width="10%" VisibleIndex="7" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="BolgeAdi" Caption="Bolge Adi" Width="10%" VisibleIndex="8" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="SehirAdi" Caption="Sehir Adi" Width="150" VisibleIndex="0" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="IlceAdi" Caption="Ilce Adi" Width="150" VisibleIndex="0" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="SemtAdi" Caption="Semt Adi" Width="150" VisibleIndex="0" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="MahalleAdi" Caption="Mahalle Adi" Width="150" VisibleIndex="0" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="AdiSoyadi" Caption="Müşteri Temsilcisi" Width="15%" VisibleIndex="9" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="BayiTipiAdi" Caption="Bayi Tipi Adi" Width="150" VisibleIndex="0" Visible="false" />
    </Columns>
    <SettingsBehavior AllowFocusedRow="true" EnableCustomizationWindow="true" AllowClientEventsOnLoad="false" ColumnResizeMode="Control" />
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
