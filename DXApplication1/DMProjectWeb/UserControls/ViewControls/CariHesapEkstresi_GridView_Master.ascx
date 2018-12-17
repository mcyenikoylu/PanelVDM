<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CariHesapEkstresi_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.CariHesapEkstresi_GridView_Master" %>

<dx:ASPxGridView ID="EmployeesGrid" runat="server" 
    ClientInstanceName="employeesGrid" 
    Width="100%" 
    AutoGenerateColumns="false" 
    KeyFieldName="FISNO" 
    KeyboardSupport="true" 
    EnableRowsCache="false"
    CssClass="employeesGridView"
    OnCustomUnboundColumnData="EmployeesGrid_CustomUnboundColumnData"  >
    <Columns>
        <dx:GridViewDataTextColumn FieldName="TARIH" Caption="İşlem Tarihi" Width="30%" Visible="true" VisibleIndex="1" >
            <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy">
            </PropertiesTextEdit>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="ISLEM_TURU" Caption="İşlem Açıklaması" Width="85%" Visible="true" VisibleIndex="2" />
        <dx:GridViewDataTextColumn FieldName="BORC" Caption="Borç" Width="30%" Visible="true" VisibleIndex="3" >
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="ALACAK" Caption="Alacak" Width="30%" Visible="true" VisibleIndex="4" >
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Total" Caption="Bakiye" UnboundType="Decimal" ReadOnly="true" Width="30%" VisibleIndex="5">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />  
            <%--<FooterTemplate>
                <dx:ASPxLabel ID="ASPxLabel1" runat="server" ClientInstanceName="labelTotal" Text='<%# GetSummaryValue((Container.Column as GridViewDataColumn).FieldName) %>'></dx:ASPxLabel>
            </FooterTemplate>--%>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="FISNO" Caption="İşlem No" Width="30%" Visible="true" VisibleIndex="6" />
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
    <SettingsSearchPanel CustomEditorID="SearchBox" HighlightResults="True" ColumnNames="FISNO"></SettingsSearchPanel>
    <ClientSideEvents 
        CustomizationWindowCloseUp="DevAV.GridCustomizationWindow_CloseUp" />
    <Styles Header-Wrap="True">
        <Table CssClass="dataTable"></Table>
        <Header CssClass="header"></Header>
        <FocusedRow CssClass="focusRow"></FocusedRow>
        <GroupPanel CssClass="groupPanel" />
    </Styles>
</dx:ASPxGridView>
