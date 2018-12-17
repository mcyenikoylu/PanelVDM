<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RaporEnvanter_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.RaporEnvanter_GridView_Master" %>
<dx:ASPxGridView ID="EmployeesGrid" ClientInstanceName="employeesGrid" runat="server" 
        AutoGenerateColumns="False" CssClass="gridView"
        KeyFieldName="STOKKODU" Width="100%" KeyboardSupport="true">
        <Styles Header-CssClass="gridViewHeader" Row-CssClass="gridViewRow" FocusedRow-CssClass="gridViewRowFocused"
            RowHotTrack-CssClass="gridViewRow" FilterRow-CssClass="gridViewFilterRow" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="MAGAZA" Caption="Mağaza" Width="10%" VisibleIndex="2" />
            <dx:GridViewDataTextColumn FieldName="STOKKODU" Caption="Stok Kodu" Width="10%" VisibleIndex="1" />
            <dx:GridViewDataTextColumn FieldName="STOKACIKLAMASI" Caption="Stok Açıklaması" Width="30%" VisibleIndex="7" />
            <dx:GridViewDataTextColumn FieldName="OZELKOD1" Caption="Özel Kod 1" Width="5%" VisibleIndex="8" />
            <dx:GridViewDataTextColumn FieldName="OZELKOD2" Caption="Özel Kod 2" Width="5%" VisibleIndex="9" />
            <dx:GridViewDataTextColumn FieldName="OZELKOD3" Caption="Özel Kod 3" Width="5%"  VisibleIndex="10" />
            <dx:GridViewDataTextColumn FieldName="OZELKOD4" Caption="Özel Kod 4" Width="5%"  VisibleIndex="12" />
            <dx:GridViewDataTextColumn FieldName="ORTALAMAMALIYET" Caption="Ortalama Maliyet" Width="10%" VisibleIndex="13" >
                <PropertiesTextEdit DisplayFormatString="{0:n2} TL" /> 
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ORTALAMAURUNDEGERI" Caption="Ortalama Değer" Width="10%" VisibleIndex="14">
                <PropertiesTextEdit DisplayFormatString="{0:n2} TL" /> 
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="STOKMIKTARI" Caption="Stok Miktarı" Width="10%" VisibleIndex="15" />
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" EnableCustomizationWindow="true" AllowClientEventsOnLoad="false" />
        <SettingsPager PageSize="50">
            <NextPageButton Visible="true">
            </NextPageButton>
            <PrevPageButton Visible="true">
            </PrevPageButton>
            <Summary Visible="true" />
            <PageSizeItemSettings Visible="true">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowGroupPanel="False" GridLines="None" VerticalScrollBarMode="Visible" />
        <SettingsSearchPanel CustomEditorID="SearchBox" HighlightResults="True" ColumnNames="UserName; Email"></SettingsSearchPanel>
        <SettingsPopup>
            <CustomizationWindow HorizontalAlign="LeftSides" VerticalAlign="Below" Width="220px" Height="300px" />
        </SettingsPopup>
        <ClientSideEvents CustomizationWindowCloseUp="DevAV.GridCustomizationWindow_CloseUp" />
    </dx:ASPxGridView>