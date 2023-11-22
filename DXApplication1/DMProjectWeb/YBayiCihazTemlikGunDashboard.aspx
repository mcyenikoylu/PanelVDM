<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="YBayiCihazTemlikGunDashboard.aspx.cs" Inherits="DMProjectWeb.YBayiCihazTemlikGunDashboard" %>
<%@ Register Assembly="DevExpress.Dashboard.v18.2.Web.WebForms, Version=18.2.18.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.DashboardWeb" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_ToolbarMenu" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
            <style>
        .dash{
            position:relative;
            left:0;
            right:0;
            top:0;
            bottom:0;
            border:0;
        }
    </style>
    <div id="MasterContainer" runat="server" class="dash">
        <dx:ASPxDashboardViewer ID="ASPxDashboard1" runat="server" ClientInstanceName="aSPxDashboard1" DashboardSource="~/App_Data/Dashboards/dashboard2.xml" Width="100%" >
        </dx:ASPxDashboardViewer>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
