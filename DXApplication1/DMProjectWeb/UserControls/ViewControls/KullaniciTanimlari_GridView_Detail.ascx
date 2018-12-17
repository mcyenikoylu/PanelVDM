<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KullaniciTanimlari_GridView_Detail.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.KullaniciTanimlari_GridView_Detail" %>
<div class="employeesDetailsMainContainer">
    <div class="employeesDetailsContainer">
        <table>
            <tr>
                <td>
                    <dx:ASPxHeadline ID="DetailsHeaderHeadLine" CssClass="employeesDetailsHeadline" runat="server" HeaderText="Employee's Name" ContentText="Position">
                        <HeaderStyle CssClass="header" />
                        <ContentStyle CssClass="content"></ContentStyle>
                        <RightPanelStyle CssClass="rightPanel"></RightPanelStyle>
                    </dx:ASPxHeadline>
                </td>
                <td class="employeeEditButtonCell">
                    <%--   <dx:ASPxImage ID="EditImage" runat="server" ImageUrl="~/Content/Images/Buttons/EditCustomerButton_Gray.png">
                        <ClientSideEvents Click="DevAV.Page.EmployeeEditButton_Click"/>
                    </dx:ASPxImage>--%>
                </td>
            </tr>
        </table>
        <table class="employeesDetailsInfo">
            <tr>
                <td>
                    <dx:ASPxImage ID="EmployeeImage" runat="server" Height="170" />
                </td>
                <td>
                    <h5>BAYİ KODU</h5>
                    <span runat="server" id="DetailsAddressText"></span>
                    <h5>TELEFON</h5>
                    <span runat="server" id="DetailsPhoneText"></span>
                    <h5>E-POSTA</h5>
                    <span runat="server" id="DetailsEmailText"></span>
                </td>
            </tr>
        </table>
    </div>
</div>