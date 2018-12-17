<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="CihazTakip.aspx.cs" Inherits="DMProjectWeb.CihazTakip" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_ToolbarMenu" runat="server">
    <div style="float: left; margin-left: 10px; width: auto;">
        <div style="float: left; margin-top: 7px; padding-right: 5px;">
            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Fatura No / IMEI / Bayi Cari Kodu / Bayi İsmi:"></dx:ASPxLabel>
        </div>
        <div style="float: left; margin-top: 3px;">
            <dx:ASPxTextBox ID="TxtArama" ClientInstanceName="txtArama" runat="server" AutoPostBack="false" Width="250"></dx:ASPxTextBox>
        </div>
        <div style="float: left; margin-left: 5px; margin-top: 5px;">
            <asp:Button ID="btnGetir" runat="server" Text="Getir" CssClass="dxm-item dxm-noSubMenu" Height="27px" Width="70px" OnClick="btnGetir_Click" />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <div id="MasterContainer" runat="server"></div>
    <dx:ASPxCallbackPanel ID="DetailsCallbackPanel" runat="server" ClientInstanceName="detailsCallbackPanel" CssClass="emplGridViewDetailsPanel" Width="100%"
        Collapsible="true">
        <SettingsAdaptivity CollapseAtWindowInnerHeight="580" />
        <SettingsCollapsing ExpandEffect="PopupToTop" ExpandButton-Position="Far" AnimationType="Slide" />
        <Styles>
            <ExpandBar Width="100%"></ExpandBar>
            <ExpandedPanel CssClass="expanded"></ExpandedPanel>
        </Styles>
    </dx:ASPxCallbackPanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
