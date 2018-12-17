<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KullaniciRoles_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.KullaniciRoles_GridView_Master" %>
<dx:ASPxGridView ID="EmployeesGrid" runat="server"
    ClientInstanceName="employeesGrid"
    AutoGenerateColumns="False"
    KeyFieldName="RoleId"
    Width="100%"
    KeyboardSupport="true"
    EnableRowsCache="false"
    CssClass="employeesGridView">
    <Columns>
        <dx:GridViewDataTextColumn FieldName="RoleId" Caption="Role Id" Width="33%" VisibleIndex="0" />
        <dx:GridViewDataTextColumn FieldName="RoleName" Caption="Yetki Grubu Adı" Width="33%" VisibleIndex="1" />
        <dx:GridViewDataTextColumn FieldName="BayiTipi" Caption="Bayi Tipi" Width="33%" VisibleIndex="2" />
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
    <SettingsSearchPanel CustomEditorID="SearchBox" HighlightResults="True" ColumnNames="RoleName"></SettingsSearchPanel>
    <ClientSideEvents
        Init="DevAV.Page.EmployeesGrid_Init"
        FocusedRowChanged="DevAV.Page.EmployeesGrid_FocusedRowChanged"
        EndCallback="DevAV.Page.EmployeesGrid_EndCallback"
        ContextMenuItemClick="DevAV.Page.EmployeesGrid_ContextMenuItemClick"
        CustomizationWindowCloseUp="DevAV.GridCustomizationWindow_CloseUp" />
    <Styles>
        <Table CssClass="dataTable"></Table>
        <Header CssClass="header"></Header>
        <FocusedRow CssClass="focusRow"></FocusedRow>
        <GroupPanel CssClass="groupPanel" />
    </Styles>
</dx:ASPxGridView>
