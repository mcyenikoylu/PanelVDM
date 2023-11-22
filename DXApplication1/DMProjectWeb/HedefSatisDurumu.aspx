<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="HedefSatisDurumu.aspx.cs" Inherits="DMProjectWeb.HedefSatisDurumu" %>

<%@ Register Assembly="DevExpress.XtraCharts.v18.2.Web, Version=18.2.18.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>

<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.18.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
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
    <%--OnCallback="DetailsCallbackPanel_Callback" --%>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_ToolbarMenu" runat="server">
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
</div>
</asp:Content>