<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Siparisler_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.Siparisler_GridView_Master" %>
<dx:ASPxGridView ID="EmployeesGrid" ClientInstanceName="employeesGrid" runat="server"
    AutoGenerateColumns="False" CssClass="gridView"
    KeyFieldName="ID" Width="100%" KeyboardSupport="true" OnRowInserting="EmployeesGrid_RowInserting" OnRowUpdating="EmployeesGrid_RowUpdating" OnRowDeleting="EmployeesGrid_RowDeleting">
    <Styles Header-CssClass="gridViewHeader" Row-CssClass="gridViewRow" FocusedRow-CssClass="gridViewRowFocused"
        RowHotTrack-CssClass="gridViewRow" FilterRow-CssClass="gridViewFilterRow" />
    <Columns>
        <dx:GridViewCommandColumn ShowEditButton="true" ShowNewButtonInHeader="true" ShowDeleteButton="true" VisibleIndex="0" Width="2%">
            <HeaderTemplate>
                <dx:ASPxButton runat="server" Text="Yeni Ekle" RenderMode="Link" AutoPostBack="false">
                    <ClientSideEvents Click="function(s, e){ employeesGrid.AddNewRow(); }" />
                </dx:ASPxButton>
            </HeaderTemplate>
        </dx:GridViewCommandColumn>
        <dx:GridViewDataTextColumn FieldName="ID" Caption="Sipariş ID" Width="2%" VisibleIndex="0" EditFormSettings-Visible="False" />
                <dx:GridViewDataComboBoxColumn FieldName="BayiID" Caption="Bayi" Width="3%" VisibleIndex="1">
            <PropertiesComboBox
                ValueField="ID"
                ValueType="System.Int32"
                TextField="BayiAdi"
                EnableSynchronization="False"
                IncrementalFilteringMode="StartsWith">
                <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>
        <dx:GridViewDataComboBoxColumn FieldName="UrunID" Caption="Ürün" Width="3%" VisibleIndex="2">
            <PropertiesComboBox
                ValueField="ID"
                ValueType="System.Int32"
                TextField="UrunAdi"
                EnableSynchronization="False"
                IncrementalFilteringMode="StartsWith">
                <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>
        <dx:GridViewDataTextColumn FieldName="Adet" Caption="Adet" Width="2%" VisibleIndex="3" />
        <dx:GridViewDataComboBoxColumn FieldName="Onay" Caption="Onay" Width="3%" VisibleIndex="4">
            <PropertiesComboBox
                ValueField="ID"
                ValueType="System.Int32"
                TextField="TipAdi"
                EnableSynchronization="False"
                IncrementalFilteringMode="StartsWith">
                <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>
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
    <SettingsEditing Mode="PopupEditForm"></SettingsEditing>
    <SettingsPopup>
            <EditForm HorizontalAlign="Center" VerticalAlign="WindowCenter" />
        </SettingsPopup>
</dx:ASPxGridView>
