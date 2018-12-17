<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Main.master" CodeBehind="Default.aspx.cs" Inherits="DMProjectWeb._Default" %>

<%@ Register Src="~/Widgets/DateTimeWidget.ascx" TagName="DateTime" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/WeatherWidget/WeatherWidget.ascx" TagName="Weather" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/MailWidget.ascx" TagName="Mail" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/CalendarWidget.ascx" TagName="Calendar" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/TradingWidget/TradingWidget.ascx" TagName="Trading" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/NewsWidget.ascx" TagName="News" TagPrefix="widget" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    
    <div id="DockPage" runat="server">
        <dx:ASPxDockManager runat="server" ID="ASPxDockManager" ClientInstanceName="dockManager">
            <ClientSideEvents PanelShown="function(s, e) { SetWidgetButtonVisible(e.panel.panelUID, false) }"
                PanelCloseUp="function(s, e) { SetWidgetButtonVisible(e.panel.panelUID, true) }" />
        </dx:ASPxDockManager>

        <dx:ASPxDockPanel runat="server" ID="DateTimePanel" PanelUID="DateTime" HeaderText="Tarih & Saat"
            OwnerZoneUID="Sutun1" VisibleIndex="0" ClientInstanceName="dateTimePanel" Height="130px">
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <widget:DateTime ID="DateTimeWidget" runat="server" />
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxDockPanel>

        <dx:ASPxDockPanel runat="server" ID="CalendarPanel" PanelUID="Calendar" HeaderText="Takvim"
            OwnerZoneUID="Sutun1" VisibleIndex="1" ClientInstanceName="calendarPanel">
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <widget:Calendar runat="server" ID="CalendarWidget" />
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxDockPanel>

        <dx:ASPxDockPanel runat="server" ID="MailPanel" PanelUID="Mail" HeaderText="E-Posta"
            OwnerZoneUID="Sutun1" VisibleIndex="2" ClientInstanceName="mailPanel" >
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <widget:Mail runat="server" ID="MailWidget" />
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxDockPanel>

        <dx:ASPxDockPanel runat="server" ID="WeatherPanel" PanelUID="Weather" HeaderText="Hava Durumu"
            Width="275px" Height="200px" OwnerZoneUID="Sutun4" VisibleIndex="0" ClientInstanceName="weatherPanel"
         >
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <widget:Weather runat="server" ID="WeatherWidget" />
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxDockPanel>

        <dx:ASPxDockPanel runat="server" ID="TradingPanel" PanelUID="Trading" HeaderText="Finans"
            Width="400px" Height="150px" AllowResize="true" OwnerZoneUID="Sutun3" ClientInstanceName="tradingPanel" VisibleIndex="0"
         >
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <widget:Trading runat="server" ID="TradingWidget" />
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxDockPanel>

        <dx:ASPxDockPanel runat="server" ID="NewsPanel" PanelUID="News" HeaderText="Duyuru"
            Width="400px" AllowResize="true" OwnerZoneUID="Sutun2" VisibleIndex="0" ClientInstanceName="newsPanel"
         >
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <widget:News runat="server" ID="NewsWidget" />
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxDockPanel>

        <div class="widgetPanel">
            <asp:Repeater runat="server" ID="repeater">
                <ItemTemplate>
                    <dx:ASPxImage runat="server" ImageUrl='<%# string.Format("~/Content/Images/Widgets/{0}.png", Container.DataItem) %>'
                        Cursor="pointer" ClientInstanceName='<%# "widgetButton_" + Container.DataItem %>'
                        ToolTip='<%# "Show " + Container.DataItem %>' ClientSideEvents-Click='<%# GetClientButtonClickHandler(Container) %>'>
                    </dx:ASPxImage>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <dx:ASPxDockZone runat="server" ID="ASPxDockZone1" ZoneUID="Sutun1" CssClass="leftZone"
            Width="400px" PanelSpacing="3">
        </dx:ASPxDockZone>
        <dx:ASPxDockZone runat="server" ID="ASPxDockZone2" ZoneUID="Sutun2" CssClass="rightZone"
            Width="400px" PanelSpacing="3">
        </dx:ASPxDockZone>
        <dx:ASPxDockZone runat="server" ID="ASPxDockZone3" ZoneUID="Sutun3" CssClass="leftZone"
            Width="400px" PanelSpacing="3">
        </dx:ASPxDockZone>
        <dx:ASPxDockZone runat="server" ID="ASPxDockZone4" ZoneUID="Sutun4" CssClass="rightZone"
            Width="400px" PanelSpacing="3">
        </dx:ASPxDockZone>
    </div>

    
</asp:Content>