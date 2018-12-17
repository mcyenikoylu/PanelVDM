<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="Widgets.aspx.cs" Inherits="DMProjectWeb.Widgets" %>

<%@ Register Src="~/Widgets/DateTimeWidget.ascx" TagName="DateTime" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/WeatherWidget/WeatherWidget.ascx" TagName="Weather" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/MailWidget.ascx" TagName="Mail" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/CalendarWidget.ascx" TagName="Calendar" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/TradingWidget/TradingWidget.ascx" TagName="Trading" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/NewsWidget.ascx" TagName="News" TagPrefix="widget" %>

<%@ Register Src="~/Widgets/SliderWidget.ascx" TagName="Slider" TagPrefix="widget" %>
<%@ Register Src="~/Widgets/UrunWidget.ascx" TagPrefix="widget" TagName="UrunWidget" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_ToolbarMenu" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <dx:ASPxSplitter ID="WidgetSplitter" ClientInstanceName="widgetSplitter" runat="server" Width="100%">
        <ClientSideEvents />
        <Panes>
            <dx:SplitterPane ScrollBars="Vertical" PaneStyle-Border-BorderWidth="0" PaneStyle-Border-BorderStyle="None">
                <ContentCollection>
                    <dx:SplitterContentControl ID="SplitterContentControl1" runat="server">
                        <div id="DockPage" runat="server">

                            <dx:ASPxDockManager runat="server" ID="ASPxDockManager" ClientInstanceName="dockManager">
                                <ClientSideEvents
                                    Init="DevAV.Page.DockManager_Init"
                                    StartPanelDragging="DevAV.Page.DockManager_StartPanelDragging"
                                    EndPanelDragging="DevAV.Page.DockManager_EndPanelDragging"
                                    AfterDock="DevAV.Page.DockManager_AfterDock"
                                    PanelCloseUp="DevAV.Page.DockManager_PanelCloseUp " />
                            </dx:ASPxDockManager>

                            <dx:ASPxDockPanel runat="server" ID="DateTimePanel" PanelUID="DateTime" HeaderText="Tarih & Saat" ShowOnPageLoad="false"
                                OwnerZoneUID="Sutun2" ZoneUID="Sutun2" VisibleIndex="0" ClientInstanceName="dateTimePanel" Height="130px"
                                ShowPinButton="true" ShowRefreshButton="true" ShowCollapseButton="true" ShowMaximizeButton="true" ShowCloseButton="true">
                                <ContentCollection>
                                    <dx:PopupControlContentControl>
                                        <widget:DateTime ID="DateTimeWidget" runat="server" />
                                    </dx:PopupControlContentControl>
                                </ContentCollection>
                                <ClientSideEvents CloseUp="DevAV.Page.DateTime_CloseUp" />
                            </dx:ASPxDockPanel>

                            <dx:ASPxDockPanel runat="server" ID="CalendarPanel" PanelUID="Calendar" HeaderText="Takvim" ShowOnPageLoad="false"
                                OwnerZoneUID="Sutun2" ZoneUID="Sutun2" VisibleIndex="1" ClientInstanceName="calendarPanel"
                                ShowPinButton="true" ShowRefreshButton="true" ShowCollapseButton="true" ShowMaximizeButton="true" ShowCloseButton="true">
                                <ContentCollection>
                                    <dx:PopupControlContentControl>
                                        <widget:Calendar runat="server" ID="CalendarWidget" />
                                    </dx:PopupControlContentControl>
                                </ContentCollection>
                                <ClientSideEvents CloseUp="DevAV.Page.Calendar_CloseUp" />
                            </dx:ASPxDockPanel>

                            <dx:ASPxDockPanel runat="server" ID="MailPanel" PanelUID="Mail" HeaderText="E-Posta" ShowOnPageLoad="false"
                                OwnerZoneUID="Sutun3" ZoneUID="Sutun3" VisibleIndex="2" ClientInstanceName="mailPanel"
                                ShowPinButton="true" ShowRefreshButton="true" ShowCollapseButton="true" ShowMaximizeButton="true" ShowCloseButton="true">
                                <ContentCollection>
                                    <dx:PopupControlContentControl>
                                        <widget:Mail runat="server" ID="MailWidget" />
                                    </dx:PopupControlContentControl>
                                </ContentCollection>
                                <ClientSideEvents CloseUp="DevAV.Page.Mail_CloseUp" />
                            </dx:ASPxDockPanel>

                            <dx:ASPxDockPanel runat="server" ID="WeatherPanel" PanelUID="Weather" HeaderText="Hava Durumu" ShowOnPageLoad="false"
                                Width="275px" Height="200px" OwnerZoneUID="Sutun4" ZoneUID="Sutun4" VisibleIndex="0" ClientInstanceName="weatherPanel"
                                ShowPinButton="true" ShowRefreshButton="true" ShowCollapseButton="true" ShowMaximizeButton="true" ShowCloseButton="true">
                                <ContentCollection>
                                    <dx:PopupControlContentControl>
                                        <widget:Weather runat="server" ID="WeatherWidget" />
                                    </dx:PopupControlContentControl>
                                </ContentCollection>
                                <ClientSideEvents CloseUp="DevAV.Page.Weather_CloseUp" />
                            </dx:ASPxDockPanel>

                            <dx:ASPxDockPanel runat="server" ID="TradingPanel" PanelUID="Trading" HeaderText="Finans"
                                Width="400px" Height="150px" AllowResize="true" OwnerZoneUID="Sutun3" ZoneUID="Sutun3" ClientInstanceName="tradingPanel" VisibleIndex="0"
                                ShowOnPageLoad="true"
                                ShowPinButton="true" ShowRefreshButton="true" ShowCollapseButton="true" ShowMaximizeButton="true" ShowCloseButton="true">
                                <ContentCollection>
                                    <dx:PopupControlContentControl>
                                        <widget:Trading runat="server" ID="TradingWidget" />
                                    </dx:PopupControlContentControl>
                                </ContentCollection>
                                <ClientSideEvents CloseUp="DevAV.Page.Trading_CloseUp" />
                            </dx:ASPxDockPanel>

                            <dx:ASPxDockPanel runat="server" ID="NewsPanel" PanelUID="News" HeaderText="Duyuru"
                                Width="400px" AllowResize="true" OwnerZoneUID="Sutun2" ZoneUID="Sutun2" VisibleIndex="0" ClientInstanceName="newsPanel"
                                ShowOnPageLoad="true"
                                ShowPinButton="true" ShowRefreshButton="true" ShowCollapseButton="true" ShowMaximizeButton="true" ShowCloseButton="true">
                                <ContentCollection>
                                    <dx:PopupControlContentControl>
                                        <widget:News runat="server" ID="NewsWidget" />
                                    </dx:PopupControlContentControl>
                                </ContentCollection>
                                <ClientSideEvents CloseUp="DevAV.Page.News_CloseUp" />
                            </dx:ASPxDockPanel>

                            <dx:ASPxDockPanel runat="server" ID="SliderPanel" PanelUID="Slider" HeaderText="Duyuru Slider" ShowOnPageLoad="true"
                                Width="700px" AllowResize="true" OwnerZoneUID="Sutun1" ZoneUID="Sutun1" VisibleIndex="0" ClientInstanceName="sliderPanel"
                                ShowPinButton="true" ShowRefreshButton="true" ShowCollapseButton="true" ShowMaximizeButton="true" ShowCloseButton="true">
                                <ContentCollection>
                                    <dx:PopupControlContentControl>
                                        <widget:Slider runat="server" ID="SliderWidget" />
                                    </dx:PopupControlContentControl>
                                </ContentCollection>
                                <ClientSideEvents CloseUp="DevAV.Page.SliderPanel_CloseUp" />
                            </dx:ASPxDockPanel>

                            <dx:ASPxDockPanel runat="server" ID="UrunPanel" PanelUID="Urun" ClientInstanceName="urunPanel" HeaderText="En Çok Satanlar" ShowOnPageLoad="false"
                                Width="700px" AllowResize="true" OwnerZoneUID="Sutun1" ZoneUID="Sutun1" VisibleIndex="0"
                                ShowPinButton="true" ShowRefreshButton="true" ShowCollapseButton="true" ShowMaximizeButton="true" ShowCloseButton="true">
                                <ContentCollection>
                                    <dx:PopupControlContentControl>
                                        <widget:UrunWidget runat="server" ID="UrunWidget" />
                                    </dx:PopupControlContentControl>
                                </ContentCollection>
                                <ClientSideEvents CloseUp="DevAV.Page.UrunPanel_CloseUp" />
                            </dx:ASPxDockPanel>



                            <dx:ASPxDockZone runat="server" ID="ASPxDockZone1" ZoneUID="Sutun1" CssClass="leftZone"
                                Width="700px" PanelSpacing="3">
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
                    </dx:SplitterContentControl>
                </ContentCollection>
            </dx:SplitterPane>
        </Panes>
    </dx:ASPxSplitter>
    <dx:ASPxCallback ID="AcilisDuyurusuOkundu" runat="server" ClientInstanceName="acilisDuyurusuOkundu" OnCallback="AcilisDuyurusuOkundu_Callback"></dx:ASPxCallback>
    <dx:ASPxPopupControl ID="AcilisMesajiPopup" PanelUID="AcilisMesaji" ClientInstanceName="acilisMesajiPopup" runat="server" Modal="true" ShowOnPageLoad="true"
        HeaderText="Önemli Duyuru" ShowCloseButton="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter">
        <ClientSideEvents CloseUp="DevAV.Page.AcilisMesajiPopup_CloseUp" />
        <ContentCollection>
            <dx:PopupControlContentControl>
                <div>
                    <img id="acilisDuyurusu" runat="server" height="450" />
                </div>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>

