<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="Duyurularim.aspx.cs" Inherits="DMProjectWeb.Duyurularim" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <script>
        window.onload = function () {
            var topContainer = document.getElementById('DuyuruGridContainer');
            var height = Math.max(0, document.documentElement.clientHeight - topContainer.offsetHeight + 130);
            duyurularimGrid.SetHeight(height);
        }

    </script>
<div id="DuyuruGridContainer">
    <dx:ASPxGridView ID="DuyurularimGrid" runat="server" CssClass="employeesGridView"
        AutoGenerateColumns="False" ClientInstanceName="duyurularimGrid"
        KeyFieldName="ID" PreviewFieldName="Aciklama" Width="100%" KeyboardSupport="true" >
        <%--<Styles Header-CssClass="gridViewHeader" Row-CssClass="gridViewRow" FocusedRow-CssClass="gridViewRowFocused"
            RowHotTrack-CssClass="gridViewRow" FilterRow-CssClass="gridViewFilterRow" />--%>
        <Columns>
            <dx:GridViewDataColumn FieldName="ID" VisibleIndex="0" Width="10%" Visible="false" />
            <dx:GridViewDataColumn FieldName="DuyuruTarihi" VisibleIndex="1" Width="10%" />
            <dx:GridViewDataColumn FieldName="Baslik" VisibleIndex="2" Width="60%" />
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" EnableCustomizationWindow="true" AllowClientEventsOnLoad="false" />
        <SettingsPager PageSize="20">
            <NextPageButton Visible="true">
            </NextPageButton>
            <PrevPageButton Visible="true">
            </PrevPageButton>
            <Summary Visible="true" />
            <PageSizeItemSettings Visible="true">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowPreview="True" ShowGroupPanel="False" GridLines="None" ShowFilterRow="false" ShowFilterRowMenu="false"
            VerticalScrollBarMode="Visible" />
        <SettingsSearchPanel CustomEditorID="SearchBox" HighlightResults="True" ColumnNames="UserName; Email"></SettingsSearchPanel>
        <SettingsPopup>
            <CustomizationWindow HorizontalAlign="LeftSides" VerticalAlign="Below" Width="220px" Height="300px" />
        </SettingsPopup>
        <ClientSideEvents CustomizationWindowCloseUp="DevAV.gridCustomizationWindow_CloseUp" />
    </dx:ASPxGridView>
</div>
</asp:Content>
