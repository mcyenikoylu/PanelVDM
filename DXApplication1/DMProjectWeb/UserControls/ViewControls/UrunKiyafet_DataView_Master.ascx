<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UrunKiyafet_DataView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.UrunKiyafet_DataView_Master" %>
   <dx:ASPxDataView ID="ASPxDataView1" runat="server" SettingsTableLayout-RowsPerPage="4" Width="660px" PagerAlign="Justify" ItemSpacing="25px">
        <ItemTemplate>
            <table style="margin: 0 auto;">
                <tr>
                    <td colspan="2">
                        <dx:ASPxImage ID="imgCover" runat="server" ImageUrl='<%# Eval("Resim") %>' Width="150px" Height="150px" ShowLoadingImage="true" /> 
                    </td>
                </tr>
                 <tr>
                    <td><b>Ürün Adı:</b></td>
                    <td><dx:ASPxLabel ID="lblName" runat="server" Text='<%# Eval("UrunAdi") %>' /></td>
                </tr>
                 <tr>
                    <td><b>Marka:</b></td>
                    <td><dx:ASPxLabel ID="lblAddress" runat="server" Text='<%# Eval("Marka") %>' /></td>
                </tr>
                 <tr>
                    <td><b>Model:</b></td>
                    <td><dx:ASPxLabel ID="lblPrice" runat="server" Text='<%# Eval("Model") %>' /></td>
                </tr>
                <tr>
                    <td><b>Fiyat:</b></td>
                    <td><dx:ASPxLabel ID="ASPxLabel1" runat="server" Text='<%# Eval("Fiyat") %>' /></td>
                </tr>
            </table>
        </ItemTemplate>
        <PagerSettings ShowNumericButtons="true" Position="Bottom">
            <AllButton Visible="False" />
            <Summary Visible="false" />
            <PageSizeItemSettings Visible="true" ShowAllItem="true" />
        </PagerSettings>
    </dx:ASPxDataView>