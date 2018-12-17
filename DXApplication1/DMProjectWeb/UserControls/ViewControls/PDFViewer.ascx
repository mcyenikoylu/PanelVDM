<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PDFViewer.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.PDFViewer" %>
<dx:ASPxPopupControl ID="PDFViewerPopup"
    ClientInstanceName="pdfViewerPopup"
    runat="server"
    PopupHorizontalAlign="WindowCenter"
    Modal="true"
    PopupAnimationType="Fade"
    CloseOnEscape="true"
    PopupVerticalAlign="WindowCenter"
    CloseAction="CloseButton"
    ShowCloseButton="true"
    CssClass="custEditFormPopup"
    OnWindowCallback="PDFViewerPopup_WindowCallback">
    <ClientSideEvents EndCallback="DevAV.CustomerEditPopup_EndCallback" />
    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
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
            <div style="clear: both">
            </div>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>
