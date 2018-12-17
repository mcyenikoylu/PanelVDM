<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Dokumanlar_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.Dokumanlar_GridView_Master" %>
<dx:ASPxGridView ID="EmployeesGrid" runat="server"
    ClientInstanceName="employeesGrid"
    AutoGenerateColumns="False"
    KeyFieldName="ID"
    Width="100%"
    KeyboardSupport="true"
    EnableRowsCache="false"
    CssClass="employeesGridView"
    OnDataBinding="EmployeesGrid_DataBinding">
    <Columns>
        <dx:GridViewDataTextColumn FieldName="ID" Caption="ID" Width="3%" VisibleIndex="0" Visible="false" />
        <dx:GridViewDataDateColumn FieldName="Tarih" Caption="Tarih" Width="15" Visible="true" VisibleIndex="1" >
            <EditFormSettings Visible="False" />
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataTextColumn FieldName="DokumanAdi" Caption="Doküman Adı" Width="3%" VisibleIndex="2" Visible="true" />
        <dx:GridViewDataColumn Width="25" VisibleIndex="3">
            <DataItemTemplate>
                <dx:ASPxButton ID="downloadButton" runat="server" Text="Dokümanı İndir" OnClick="downloadButton_Click" />
            </DataItemTemplate>
        </dx:GridViewDataColumn>
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
    <Settings ShowGroupPanel="False" GridLines="None" ShowFilterRow="false" ShowFilterRowMenu="false" VerticalScrollBarMode="Visible" />
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
    <SettingsEditing Mode="EditForm"></SettingsEditing>
</dx:ASPxGridView>