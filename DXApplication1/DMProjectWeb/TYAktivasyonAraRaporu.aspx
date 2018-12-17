<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TYAktivasyonAraRaporu.aspx.cs" Inherits="DMProjectWeb.TYAktivasyonAraRaporu" %>
<%@ Register Src="~/UserControls/EditForms/DosyaYuklemeForm_AktivasyonAraRaporu.ascx" TagPrefix="uc1" TagName="DosyaYuklemeForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_ToolbarMenu" runat="server">
<div style="float: left; margin-left: 2px; width: auto;">
    <div style="visibility:hidden;">
        <dx:ASPxButton ID="btnExcel" runat="server" OnClick="btnExcel_Click" ClientInstanceName="btnExcel" EnableTheming="false"></dx:ASPxButton>
        <dx:ASPxButton ID="btnPDF" runat="server" OnClick="btnPDF_Click" ClientInstanceName="btnPDF" EnableTheming="false"></dx:ASPxButton>
    </div>
</div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <div id="MasterContainer" runat="server"></div>
    <dx:ASPxCallbackPanel ID="DetailsCallbackPanel" runat="server" ClientInstanceName="detailsCallbackPanel" CssClass="emplGridViewDetailsPanel" Width="100%"
         OnCallback="DetailsCallbackPanel_Callback" Collapsible="true">
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
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
