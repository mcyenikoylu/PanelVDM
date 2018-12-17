<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KullaniciTanimlari_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.KullaniciTanimlari_GridView_Master" %>
<dx:ASPxGridView ID="EmployeesGrid" runat="server"
        ClientInstanceName="employeesGrid"  
        AutoGenerateColumns="False" 
        KeyFieldName="UserName" 
        Width="100%" 
        KeyboardSupport="true"
        EnableRowsCache="false"
        CssClass="employeesGridView">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="UserName" Caption="Kullanıcı Adı" Width="15%" VisibleIndex="1" />
            <dx:GridViewDataTextColumn FieldName="Email" Caption="E-Posta" Width="15%" VisibleIndex="2" />
            <dx:GridViewDataTextColumn FieldName="CreationDate" Caption="Oluşturma Tarihi" Width="10%" VisibleIndex="3" Visible="false">
                <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy hh:mm">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LastLoginDate" Caption="Son Giriş Tarihi" Width="10%" VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy hh:mm">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LastActivityDate" Caption="Son Aktivite Tarihi" Width="10%" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy hh:mm">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LastPasswordChangedDate" Caption="Son Parola Değişiklik Tarihi" Width="10%" VisibleIndex="6" Visible="false">
                <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy hh:mm">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="IsApproved" Caption="Onay" Width="3%" Visible="true" VisibleIndex="7" />
            <dx:GridViewDataTextColumn FieldName="IsOnline" Caption="Giriş" Width="3%" Visible="true" VisibleIndex="8" />
            <dx:GridViewDataTextColumn FieldName="ProviderUserKey" Caption="Key" Width="15%" Visible="false" VisibleIndex="9" />
            <dx:GridViewDataTextColumn FieldName="Comment" Caption="Notlar" Width="35%" Visible="true" VisibleIndex="10" />

            <dx:GridViewDataTextColumn FieldName="LastLockoutDate" Caption="Kitlendiği Tarih" Width="35%" Visible="false" VisibleIndex="12" />
            <dx:GridViewDataTextColumn FieldName="IsLockedOut" Caption="Kilit" Width="3%" Visible="false" VisibleIndex="11" />

            <dx:GridViewDataTextColumn FieldName="ProviderUserKey" Caption="Guid" Width="15%" VisibleIndex="12" />
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
    
<%--        <SettingsBehavior AllowFocusedRow="True" EnableCustomizationWindow="true" AllowClientEventsOnLoad="false" />
        <SettingsPager PageSize="50">
            <NextPageButton Visible="true">
            </NextPageButton>
            <PrevPageButton Visible="true">
            </PrevPageButton>
            <Summary Visible="true" />
            <PageSizeItemSettings Visible="true">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowGroupPanel="False" GridLines="None" ShowFilterRow="true" ShowFilterRowMenu="true" VerticalScrollBarMode="Visible" />
        <SettingsSearchPanel CustomEditorID="SearchBox" HighlightResults="True" ColumnNames="UserName; Email"></SettingsSearchPanel>
        <SettingsPopup>
            <CustomizationWindow HorizontalAlign="LeftSides" VerticalAlign="Below" Width="220px" Height="300px" />
        </SettingsPopup>--%>
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