<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="Dashboards.aspx.cs" Inherits="DMProjectWeb.Dashboards" %>

<%@ Register Assembly="DevExpress.XtraCharts.v18.2.Web, Version=18.2.18.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register Assembly="DevExpress.XtraCharts.v18.2, Version=18.2.18.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts" TagPrefix="cc1" %>
<%@ Register Assembly="DevExpress.Dashboard.v18.2.Web.WebForms, Version=18.2.18.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.DashboardWeb" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.XtraCharts.v18.2.Web, Version=18.2.18.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register Assembly="DevExpress.XtraCharts.v18.2.Web, Version=18.2.18.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register Assembly="DevExpress.XtraCharts.v18.2.Web, Version=18.2.18.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register Assembly="DevExpress.XtraCharts.v18.2.Web, Version=18.2.18.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder_ToolbarMenu" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <div style="float: left; width: 100%; position: relative; text-align: left; padding: 10px;">
        <div style="float: left; width: 610px; height: 410px; margin: 2px;">
            <dxchartsui:WebChartControl ID="WebChartControl1" runat="server" CrosshairEnabled="True" Height="400px" Width="600px" Theme="Mulberry" PaletteName="Blue Green" AppearanceNameSerializable="Pastel Kit">
                <DiagramSerializable>
                    <cc1:XYDiagram>
                        <AxisX VisibleInPanesSerializable="-1">
                        </AxisX>
                        <AxisY VisibleInPanesSerializable="-1">
                        </AxisY>
                    </cc1:XYDiagram>
                </DiagramSerializable>
                <SeriesSerializable>
                    <cc1:Series Name="Avrupa VDM">
                        <Points>
                            <cc1:SeriesPoint ArgumentSerializable="Avcılar" Values="21">
                            </cc1:SeriesPoint>
                            <cc1:SeriesPoint ArgumentSerializable="Beylikdüzü" Values="53">
                            </cc1:SeriesPoint>
                            <cc1:SeriesPoint ArgumentSerializable="Fatih" Values="65">
                            </cc1:SeriesPoint>
                        </Points>
                        <ViewSerializable>
                            <cc1:StackedBarSeriesView>
                            </cc1:StackedBarSeriesView>
                        </ViewSerializable>
                    </cc1:Series>
                    <cc1:Series Name="Trakya VDM">
                        <Points>
                            <cc1:SeriesPoint ArgumentSerializable="Edirne" Values="45">
                            </cc1:SeriesPoint>
                            <cc1:SeriesPoint ArgumentSerializable="Silivri" Values="75">
                            </cc1:SeriesPoint>
                        </Points>
                        <ViewSerializable>
                            <cc1:StackedBarSeriesView>
                            </cc1:StackedBarSeriesView>
                        </ViewSerializable>
                    </cc1:Series>
                    <cc1:Series Name="Mardin VDM">
                        <Points>
                            <cc1:SeriesPoint ArgumentSerializable="İstasyon" Values="12">
                            </cc1:SeriesPoint>
                            <cc1:SeriesPoint ArgumentSerializable="Kabala" Values="45">
                            </cc1:SeriesPoint>
                            <cc1:SeriesPoint ArgumentSerializable="Merkez" Values="78">
                            </cc1:SeriesPoint>
                        </Points>
                        <ViewSerializable>
                            <cc1:StackedBarSeriesView>
                            </cc1:StackedBarSeriesView>
                        </ViewSerializable>
                    </cc1:Series>
                </SeriesSerializable>
                <SeriesTemplate>
                    <ViewSerializable>
                        <cc1:StackedBarSeriesView>
                        </cc1:StackedBarSeriesView>
                    </ViewSerializable>
                </SeriesTemplate>
                <Titles>
                    <cc1:ChartTitle Text="Şehir Dağılımı" />
                </Titles>
                <BorderOptions Visibility="False" />
            </dxchartsui:WebChartControl>
        </div>

        <div style="float: left; width: 810px; height: 410px; margin: 2px;">
            <dxchartsui:WebChartControl ID="WebChartControl2" runat="server" CrosshairEnabled="True" Height="400px" Width="800px" Theme="Mulberry" PaletteName="Blue Green" AppearanceNameSerializable="Pastel Kit">
                <SeriesSerializable>
                    <cc1:Series LabelsVisibility="True" Name="Temlik" LegendTextPattern="{V} {A}" ToolTipEnabled="True" ToolTipPointPattern="{V} {A}">
                        <ViewSerializable>
                            <cc1:PieSeriesView ExplodeMode="UsePoints" ExplodedPointIdsSerializable="0"></cc1:PieSeriesView>
                        </ViewSerializable>
                        <Points>
                            <cc1:SeriesPoint ArgumentSerializable="Telefon" SeriesPointID="0" Values="37">
                            </cc1:SeriesPoint>
                            <cc1:SeriesPoint ArgumentSerializable="Tablet" SeriesPointID="1" Values="35">
                            </cc1:SeriesPoint>
                            <cc1:SeriesPoint ArgumentSerializable="Vodem" SeriesPointID="2" Values="28">
                            </cc1:SeriesPoint>
                        </Points>

                    </cc1:Series>
                    <cc1:Series Name="Teminat">
                        <Points>
                            <cc1:SeriesPoint Values="78" ArgumentSerializable="Kullanılan" SeriesPointID="0"></cc1:SeriesPoint>
                            <cc1:SeriesPoint Values="12" ArgumentSerializable="Kalan" SeriesPointID="2"></cc1:SeriesPoint>
                        </Points>
                        <ViewSerializable>
                            <cc1:DoughnutSeriesView>
                                <Titles>
                                    <cc1:SeriesTitle />
                                </Titles>
                            </cc1:DoughnutSeriesView>
                        </ViewSerializable>
                    </cc1:Series>
                </SeriesSerializable>
                <Titles>
                    <cc1:ChartTitle Text="Temlik, Teminat Dağılımı" />
                </Titles>
                <BorderOptions Visibility="False" />
            </dxchartsui:WebChartControl>
        </div>

        <div style="float: left; width: 1010px; height: 410px; margin: 2px;">
            <dxchartsui:WebChartControl ID="WebChartControl3" runat="server" 
                CrosshairEnabled="True" 
                Height="430px" 
                Width="1420px" 
                Theme="Mulberry" 
                PaletteName="Blue Green"
                AppearanceNameSerializable="Pastel Kit">
                <Titles>
                    <cc1:ChartTitle Text="En İyi 20 Bayi Satışı"></cc1:ChartTitle>
                </Titles>
                <SeriesTemplate />
                <BorderOptions Visibility="False" />
            </dxchartsui:WebChartControl>
        </div>
    </div>
</asp:Content>
