<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AlSatKarlilik_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.AlSatKarlilik_GridView_Master" %>
<dx:ASPxGridView ID="EmployeesGrid" runat="server"
    ClientInstanceName="employeesGrid"
    AutoGenerateColumns="False"
    KeyFieldName="ID"
    Width="100%"
    KeyboardSupport="true"
    EnableRowsCache="false"
    CssClass="employeesGridView">
    <Columns>
        <dx:GridViewDataTextColumn FieldName="ID" Caption="ID" Width="3%" VisibleIndex="0" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="BayiID" Caption="Bayi ID" Width="3%" VisibleIndex="1" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="BayiKodu" Caption="Bayi Kodu" Width="5%" VisibleIndex="2" />
        <dx:GridViewDataTextColumn FieldName="BayiAdi" Caption="Bayi Adı" Width="20%" VisibleIndex="3" />
        <dx:GridViewDataTextColumn FieldName="GSM" Caption="GSM" Width="7%" VisibleIndex="4" />
        <dx:GridViewDataTextColumn FieldName="IMEI" Caption="IMEI No" Width="7%" VisibleIndex="5" />
        <dx:GridViewDataTextColumn FieldName="Tarih" Caption="Tarih" Width="7%" Visible="true" VisibleIndex="6">
            <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy">
            </PropertiesTextEdit>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="BayiKazanci" Caption="Temlik Tutari" Width="7%" Visible="true" VisibleIndex="7">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Ay" Caption="Ay" Width="7%" VisibleIndex="8" />
        <dx:GridViewDataTextColumn FieldName="Yil" Caption="Yil" Width="7%" VisibleIndex="9" />
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
    <Settings ShowGroupPanel="False" GridLines="None" ShowFilterRow="true" ShowFilterRowMenu="true" VerticalScrollBarMode="Visible" />
    <SettingsSearchPanel CustomEditorID="SearchBox" HighlightResults="True" ColumnNames="UserName; Email"></SettingsSearchPanel>
    <SettingsPopup>
        <CustomizationWindow HorizontalAlign="LeftSides" VerticalAlign="Below" Width="220px" Height="300px" />
    </SettingsPopup>
    <ClientSideEvents CustomizationWindowCloseUp="DevAV.GridCustomizationWindow_CloseUp" />
    <Styles>
        <Table CssClass="dataTable"></Table>
        <Header CssClass="header"></Header>
        <FocusedRow CssClass="focusRow"></FocusedRow>
        <GroupPanel CssClass="groupPanel" />
    </Styles>
</dx:ASPxGridView>
