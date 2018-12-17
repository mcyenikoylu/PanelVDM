<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="AktivasyonTaahhutname.aspx.cs" Inherits="DMProjectWeb.AktivasyonTaahhutname" %>

<%@ Register Src="~/UserControls/EditForms/AktivasyonTaahhutnameEditForm.ascx" TagPrefix="uc1" TagName="AktivasyonTaahhutnameEditForm" %>

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
        <uc1:AktivasyonTaahhutnameEditForm runat="server" ID="AktivasyonTaahhutnameEditForm" />
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
