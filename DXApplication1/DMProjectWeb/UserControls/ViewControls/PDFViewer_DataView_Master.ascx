<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PDFViewer_DataView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.PDFViewer_DataView_Master" %>
<dx:ASPxDataView ID="dvDocument" runat="server">
    <SettingsTableLayout ColumnCount="1" RowsPerPage="1" />
    <PagerSettings ShowNumericButtons="True">
        <AllButton Visible="True">
        </AllButton>
    </PagerSettings>
    <ItemTemplate>
        <dx:ASPxBinaryImage ID="bimPdfPage" runat="server" OnDataBinding="bimPdfPage_DataBinding">
        </dx:ASPxBinaryImage>
    </ItemTemplate>
    <ItemStyle>
        <Paddings Padding="0px" />
    </ItemStyle>
</dx:ASPxDataView>