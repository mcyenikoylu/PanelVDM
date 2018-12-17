<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TYHedefSatisDurumu.aspx.cs" Inherits="DMProjectWeb.TYHedefSatisDurumu" %>
<%@ Register Src="~/UserControls/EditForms/DosyaYuklemeForm_HedefSatisDurumu.ascx" TagPrefix="uc1" TagName="DosyaYuklemeForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_ToolbarMenu" runat="server">
<div style="float: left; margin-left: 10px; width: auto;">
    <div style="float: left; margin-top: 7px; padding-right: 5px;">
        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Tarih Aralığı:"></dx:ASPxLabel>
    </div>
    <div style="float: left; margin-top: 3px;">
        <dx:ASPxDateEdit ID="ASPxDateEdit1" ClientInstanceName="deStart" runat="server" AutoPostBack="false" Width="130"></dx:ASPxDateEdit>
    </div>
    <div style="float: left; margin-top: 3px;">
        <dx:ASPxDateEdit ID="ASPxDateEdit2" ClientInstanceName="deEnd" runat="server" AutoPostBack="false" Width="130">
            <DateRangeSettings StartDateEditID="ASPxDateEdit1"></DateRangeSettings>
        </dx:ASPxDateEdit>
    </div>
    <div style="float: left; margin-left: 5px; margin-top: 5px;">
        <asp:Button ID="btnGetir" runat="server" Text="Getir" CssClass="dxm-item dxm-noSubMenu" Height="27px" Width="70px" OnClick="btnGetir_Click" />
    </div>
        <div style="visibility:hidden;">
        <dx:ASPxButton ID="btnExcel" runat="server" OnClick="btnExcel_Click" ClientInstanceName="btnExcel" EnableTheming="false"></dx:ASPxButton>
        <dx:ASPxButton ID="btnPDF" runat="server" OnClick="btnPDF_Click" ClientInstanceName="btnPDF" EnableTheming="false"></dx:ASPxButton>
    </div>
</div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <div id="MasterContainer" runat="server"></div>
     <dx:ASPxCallbackPanel ID="DetailsCallbackPanel" runat="server" ClientInstanceName="detailsCallbackPanel" CssClass="emplGridViewDetailsPanel" Width="100%" Collapsible="true">
        <SettingsAdaptivity CollapseAtWindowInnerHeight="580" />
        <SettingsCollapsing ExpandEffect="PopupToTop" ExpandButton-Position="Far" AnimationType="Slide" />
        <Styles>
            <ExpandBar Width="100%"></ExpandBar>
            <ExpandedPanel CssClass="expanded"></ExpandedPanel>
        </Styles>
    </dx:ASPxCallbackPanel>
    <dx:ASPxGridViewExporter ID="export" runat="server"></dx:ASPxGridViewExporter>
    <div id="EditFormsContainer">   
        <uc1:DosyaYuklemeForm runat="server" id="DosyaYuklemeForm" />
    </div>
</asp:Content>
