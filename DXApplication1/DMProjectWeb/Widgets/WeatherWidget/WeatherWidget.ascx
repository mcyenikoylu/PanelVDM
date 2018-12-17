<%@ Control Language="C#" ClassName="WeatherWidget" %>
<%@ Register Src="~/Widgets/WeatherWidget/DayUserControl.ascx" TagName="Day"
    TagPrefix="uc" %>
<script runat="server">
</script>
<table width="100%" style="text-align: center;">
    <tr>
        <td colspan="4" style="text-align: left;">
            <dx:ASPxHyperLink runat="server" ID="ASPxHyperLink1" Text="Bugün" Font-Size="Larger" NavigateUrl="javascript:void(0)">
            </dx:ASPxHyperLink>
        </td>
    </tr>
    <tr>
        <td>
            <dx:ASPxImage runat="server" ID="ASPxImage1" ImageUrl="~/Content/Images/Widgets/Weather/rain_thunderstorm.png"
                CssClass="todayImg">
            </dx:ASPxImage>
        </td>
        <td style="text-align: left;">
            <dx:ASPxLabel runat="server" ID="ASPxLabel1" Text="+4°C" Font-Bold="true" Font-Size="Medium">
            </dx:ASPxLabel>
        </td>
        <td colspan="2" style="text-align: left;">
            Mevcut: Yağmurlu
            <br />
            Rüzgar: N 26 km / s
            <br />
            Nem:% 81
        </td>
    </tr>
    <tr>
        <td>
            <uc:Day ID="Day1" runat="server" DayOfWeek="Pzt" Temperature="+2°|-1°" WeatherImageUrl="~/Content/Images/Widgets/Weather/rain_common.png" />
        </td>
        <td>
            <uc:Day ID="Day2" runat="server" DayOfWeek="Sal" Temperature="+4°| 0°" WeatherImageUrl="~/Content/Images/Widgets/Weather/cloudiness_hi.png" />
        </td>
        <td>
            <uc:Day ID="Day3" runat="server" DayOfWeek="Çar" Temperature="+5°|+1°" WeatherImageUrl="~/Content/Images/Widgets/Weather/cloudiness_partly.png" />
        </td>
        <td>
            <uc:Day ID="Day4" runat="server" DayOfWeek="Per" Temperature="+7°|+3°" WeatherImageUrl="~/Content/Images/Widgets/Weather/cloudiness_low.png" />
        </td>
    </tr>
</table>
