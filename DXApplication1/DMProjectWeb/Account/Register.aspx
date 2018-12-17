<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Light.master" CodeBehind="Register.aspx.cs" Inherits="DMProjectWeb.Register" %>

<asp:Content ID="ClientArea" ContentPlaceHolderID="MainContent" runat="server">
    <div class="accountHeader">
        <h2>Create a New Account</h2>
        <p>Use the form below to create a new account.</p>
        <p>Passwords are required to be a minimum of <%= Membership.MinRequiredPasswordLength %> characters in length.</p>
    </div>
    <dx:ASPxLabel ID="lblUserName" runat="server" AssociatedControlID="tbUserName" Text="User Name:" />
    <div class="form-field">
        <dx:ASPxTextBox ID="tbUserName" runat="server" Width="200px">
            <ValidationSettings ValidationGroup="RegisterUserValidationGroup">
                <RequiredField ErrorText="Kullanýcý Adý gerekiyor." IsRequired="true" />
            </ValidationSettings>
        </dx:ASPxTextBox>
    </div>
    <dx:ASPxLabel ID="lblEmail" runat="server" AssociatedControlID="tbEmail" Text="E-mail:" />
    <div class="form-field">
        <dx:ASPxTextBox ID="tbEmail" runat="server" Width="200px">
            <ValidationSettings ValidationGroup="RegisterUserValidationGroup">
                <RequiredField ErrorText="E-mail is required." IsRequired="true" />
                <RegularExpression ErrorText="E-posta doðrulamasý baþarýsýz oldu." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
            </ValidationSettings>
        </dx:ASPxTextBox>
    </div>
    <dx:ASPxLabel ID="lblPassword" runat="server" AssociatedControlID="tbPassword" Text="Password:" />
    <div class="form-field">

        <dx:ASPxTextBox ID="tbPassword" ClientInstanceName="Password" Password="true" runat="server"
            Width="200px">
            <ValidationSettings ValidationGroup="RegisterUserValidationGroup">
                <RequiredField ErrorText="Parola gereklidir." IsRequired="true" />
            </ValidationSettings>
        </dx:ASPxTextBox>

    </div>
    <dx:ASPxLabel ID="lblConfirmPassword" runat="server" AssociatedControlID="tbConfirmPassword"
        Text="Confirm password:" />
    <div class="form-field">
        
        <dx:ASPxTextBox ID="tbConfirmPassword" Password="true" runat="server" Width="200px">
            <ValidationSettings ValidationGroup="RegisterUserValidationGroup">
                <RequiredField ErrorText="Confirm Password is required." IsRequired="true" />
            </ValidationSettings>
            <ClientSideEvents Validation="function(s, e) {
                var originalPasswd = Password.GetText();
                var currentPasswd = s.GetText();
                e.isValid = (originalPasswd  == currentPasswd );
                e.errorText = 'The Password and Confirmation Password must match.';
            }" />
        </dx:ASPxTextBox>
    
    </div>
    <div class="form-field">
        <dx:ASPxComboBox ID="cmbRole" runat="server" ValueType="System.String">
            <Items>
                <dx:ListEditItem Text="Personel" Value="422C17A4-2608-4FEE-B0CD-104443AB23E5" />
                <dx:ListEditItem Text="PersonelYonetici" Value="31ABEAA9-770B-4856-9517-8D494DDDC9B5" />
                <dx:ListEditItem Text="AltBayi" Value="A1A08DCC-2882-4206-8646-83DFC8B14E99" />
                <dx:ListEditItem Text="SilverBayi" Value="9EE02807-FA76-427B-BFDC-8884B9E5448F" />
                <dx:ListEditItem Text="ShopBayi" Value="E9A62C88-AD13-4329-972E-BEEBCB2E60B8" />
            </Items>
            <ValidationSettings ValidationGroup="RegisterUserValidationGroup">
                <RequiredField ErrorText="Bayi alanýný doldurunuz." IsRequired="true" />
            </ValidationSettings>
        </dx:ASPxComboBox>
    </div>
    <dx:ASPxButton ID="btnCreateUser" runat="server" Text="Create User" ValidationGroup="RegisterUserValidationGroup"
        OnClick="btnCreateUser_Click">
    </dx:ASPxButton>
</asp:Content>
