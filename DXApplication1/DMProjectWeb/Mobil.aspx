<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Mobil.aspx.cs" Inherits="DMProjectWeb.Mobil" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    
    <meta name="viewport" content="width=device-width, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0" />
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-9"/>
    <title>Pamuk - Vodafone Dağıtım Merkezi</title>
    <style type="text/css">
        .formLayout {
            max-width: 1300px;
            margin: auto;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <dx:ASPxFormLayout runat="server" ID="formLayout" CssClass="formLayout">
            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="800" />
            <Items>
                <dx:LayoutGroup Caption="Pamuk VDM" ColCount="2" GroupBoxDecoration="HeadingLine" UseDefaultPaddings="false" Paddings-PaddingTop="10">
                    <GroupBoxStyle>
                        <Caption Font-Bold="true" Font-Size="16" />
                    </GroupBoxStyle>
                    <Items>
                        <dx:LayoutItem Caption="Bilgi Mesajı">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                    <p>
                                        Mobil site üzerinden devam etmek için lütfen <a href="http://mobil.pamukbayi.net/">tıklayınız</a>.
                                    </p>
                                    <%--<div style="width:100%; text-align:center;">
                                        <img src="Content/Images/badges.png" style="text-align:center;">
                                    </div>--%>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                    </Items>
                </dx:LayoutGroup>
            </Items>
        </dx:ASPxFormLayout>
    </form>
</body>
</html>
