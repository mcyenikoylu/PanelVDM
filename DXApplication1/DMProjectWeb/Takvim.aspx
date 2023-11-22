<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="Takvim.aspx.cs" Inherits="DMProjectWeb.Takvim" %>

<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v18.2, Version=18.2.18.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
        <script>
        window.onload = function () {
            var divElement = document.getElementById("TakvimContainer");
            divElement.style.height = document.documentElement.clientHeight - divElement.offsetHeight - 52 + "px";
        }

    </script>
                        <div id="TakvimContainer" style="position: relative; height:100px; width: 100%; overflow: auto;">
                            <asp:Table ID="table" runat="server" Height="100%" Width="100%">
                                <asp:TableRow>
                                    <asp:TableCell Width="85%">

                                        <dxwschs:ASPxScheduler ID="ASPxScheduler1" runat="server">
                                            <Views>
                                                <WeekView Enabled="false"></WeekView>
                                                <FullWeekView Enabled="true">
                                                </FullWeekView>
                                            </Views>

                                        </dxwschs:ASPxScheduler>

                                    </asp:TableCell>
                                    <asp:TableCell Width="15%" VerticalAlign="Top">
                                        <dxwschs:ASPxDateNavigator ID="ASPxDateNavigator1" runat="server" MasterControlID="ASPxScheduler1" Properties-Rows="3">
                                            <Properties>
                                                <Style BackgroundImage-VerticalPosition="top" />
                                            </Properties>
                                        </dxwschs:ASPxDateNavigator>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>

</asp:Content>
