<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="AktivasyonSebekeIciGecis.aspx.cs" Inherits="DMProjectWeb.SebekeIciGecis" %>
<%@ Register Src="~/UserControls/EditForms/AktivasyonSebekeIciGecisEditForm.ascx" TagPrefix="uc1" TagName="AktivasyonSebekeIciGecisEditForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_ToolbarMenu" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
        <div id="MasterContainer" runat="server"></div>
    <dx:ASPxCallbackPanel ID="DetailsCallbackPanel" runat="server" ClientInstanceName="detailsCallbackPanel" CssClass="emplGridViewDetailsPanel" Width="100%"
        Collapsible="true" OnCallback="DetailsCallbackPanel_Callback">
        <SettingsAdaptivity CollapseAtWindowInnerHeight="580" />
        <SettingsCollapsing ExpandEffect="PopupToTop" ExpandButton-Position="Far" AnimationType="Slide" />
        <Styles>
            <ExpandBar Width="100%"></ExpandBar>
            <ExpandedPanel CssClass="expanded"></ExpandedPanel>
        </Styles>
    </dx:ASPxCallbackPanel>
    <div id="EditFormsContainer">
        <uc1:AktivasyonSebekeIciGecisEditForm runat="server" ID="AktivasyonSebekeIciGecisEditForm" />
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
