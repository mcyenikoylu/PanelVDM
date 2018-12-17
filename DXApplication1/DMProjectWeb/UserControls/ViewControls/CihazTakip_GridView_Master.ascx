<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CihazTakip_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.CihazTakip_GridView_Master" %>
<dx:ASPxGridView ID="EmployeesGrid" runat="server" 
    ClientInstanceName="employeesGrid" 
    Width="100%" 
    AutoGenerateColumns="false" 
    KeyFieldName="BayiKodu" 
    KeyboardSupport="true" 
    EnableRowsCache="false"
    CssClass="employeesGridView" SettingsText-EmptyDataRow="Arama yapınız." OnHtmlRowPrepared="EmployeesGrid_HtmlRowPrepared">
    <Columns>
        <dx:GridViewDataTextColumn FieldName="BayiAdi" Caption="Bayi Adı" Width="25%" Visible="true" VisibleIndex="0" />
        <dx:GridViewDataTextColumn FieldName="BayiKodu" Caption="Bayi Kodu" Width="5%" Visible="true" VisibleIndex="1" />
        <dx:GridViewDataTextColumn FieldName="CihazKodu" Caption="Cihaz Kodu" Width="10%" Visible="true" VisibleIndex="2" />
        <dx:GridViewDataTextColumn FieldName="CihazAdi" Caption="Cihaz Adı" Width="25%" Visible="true" VisibleIndex="3" />
        <dx:GridViewDataTextColumn FieldName="IMEI" Caption="IMEI" Width="10%" Visible="false" VisibleIndex="4" />
        <dx:GridViewDataTextColumn FieldName="FaturaTarihi" Caption="Fatura Tarihi" Width="10%" Visible="true" VisibleIndex="5">
            <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy">
            </PropertiesTextEdit>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="FaturaTutari" Caption="Fatura Tutarı" UnboundType="Decimal" ReadOnly="true" Width="10%" VisibleIndex="6">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />  
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="BayiSatisTarihi" Caption="Bayi Satış Tarihi" Width="10%" Visible="true" VisibleIndex="7">
            <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy">
            </PropertiesTextEdit>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Gun" Caption="Gün" Width="5%" Visible="true" VisibleIndex="8" />
    </Columns>
    <SettingsBehavior  EnableCustomizationWindow="true" AllowClientEventsOnLoad="false" ColumnResizeMode="Control"  />
    <SettingsPager AlwaysShowPager="true" ShowEmptyDataRows="true" PageSize="25" />
    <Settings VerticalScrollBarMode="Auto" VerticalScrollableHeight="400" HorizontalScrollBarMode="Visible" />
    <SettingsContextMenu Enabled="true">
        <ColumnMenuItemVisibility ShowFooter="false" ShowFilterRow="false" GroupByColumn="false" ShowGroupPanel="false" />
    </SettingsContextMenu>
    <SettingsPopup>
        <CustomizationWindow HorizontalAlign="LeftSides" VerticalAlign="Below" Width="220px" Height="300px" />
    </SettingsPopup>
    <SettingsSearchPanel CustomEditorID="SearchBox" HighlightResults="True" ColumnNames="BayiKodu"></SettingsSearchPanel>
    <ClientSideEvents 
        CustomizationWindowCloseUp="DevAV.GridCustomizationWindow_CloseUp" />
    <Styles Header-Wrap="True">
        <Table CssClass="dataTable"></Table>
        <Header CssClass="header"></Header>
        <GroupPanel CssClass="groupPanel" />
    </Styles>
</dx:ASPxGridView>