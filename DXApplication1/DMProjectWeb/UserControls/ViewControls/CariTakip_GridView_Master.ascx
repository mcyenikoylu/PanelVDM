<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CariTakip_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.CariTakip_GridView_Master" %>

<dx:ASPxGridView ID="EmployeesGrid" runat="server" 
    ClientInstanceName="employeesGrid" 
    Width="100%" 
    AutoGenerateColumns="false" 
    KeyFieldName="BayiKodu" 
    KeyboardSupport="true" 
    EnableRowsCache="false"
    CssClass="employeesGridView" >
    <Columns>

        <dx:GridViewDataTextColumn FieldName="BayiKodu" Caption="Bayi Kodu" Width="85%" Visible="true" VisibleIndex="0" />
        <dx:GridViewDataTextColumn FieldName="BayiAdi" Caption="Bayi Adı" Width="85%" Visible="true" VisibleIndex="1" />
        
        <dx:GridViewDataTextColumn FieldName="Bakiye" Caption="Bakiye" UnboundType="Decimal" ReadOnly="true" Width="30%" VisibleIndex="2">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />  
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Teminat" Caption="Toplam Teminat" Width="30%" Visible="true" VisibleIndex="3" >
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>

    </Columns>
    <SettingsBehavior AllowFocusedRow="true" EnableCustomizationWindow="true" AllowClientEventsOnLoad="false" ColumnResizeMode="Control"  />
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
        <FocusedRow CssClass="focusRow"></FocusedRow>
        <GroupPanel CssClass="groupPanel" />
    </Styles>
</dx:ASPxGridView>