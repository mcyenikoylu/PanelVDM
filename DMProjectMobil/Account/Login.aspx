<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Light.master" CodeBehind="Login.aspx.cs" Inherits="DMProjectMobil.Login" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="accountHeader">
    <h2>
        Oturum aç</h2>
    <p>
        Lütfen Kullanýcý adýnýz ve parola bilgileriniz ile sisteme giriþ yapýnýz.</p>
</div>
<dx:ASPxLabel ID="lblUserName" runat="server" AssociatedControlID="tbUserName" Text="Kullanýcý Adý:" />
<div class="form-field">
    <dx:ASPxTextBox ID="tbUserName" runat="server" Width="200px">
        <ValidationSettings ValidationGroup="LoginUserValidationGroup">
            <RequiredField ErrorText="User Name is required." IsRequired="true" />
        </ValidationSettings>
    </dx:ASPxTextBox>
</div>
<dx:ASPxLabel ID="lblPassword" runat="server" AssociatedControlID="tbPassword" Text="Parola:" />
<div class="form-field">
    <dx:ASPxTextBox ID="tbPassword" runat="server" Password="true" Width="200px">
        <ValidationSettings ValidationGroup="LoginUserValidationGroup">
            <RequiredField ErrorText="Password is required." IsRequired="true" />
        </ValidationSettings>
    </dx:ASPxTextBox>
</div>
<dx:ASPxButton ID="btnLogin" runat="server" Text="Giriþ" ValidationGroup="LoginUserValidationGroup"
    OnClick="btnLogin_Click">
</dx:ASPxButton>
</asp:Content>