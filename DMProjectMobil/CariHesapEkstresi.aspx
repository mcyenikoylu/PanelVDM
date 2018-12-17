<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="CariHesapEkstresi.aspx.cs" Inherits="DMProjectMobil.CariHesapEkstresi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxGridView ID="EmployeesGrid" runat="server" 
    ClientInstanceName="employeesGrid" 
    Width="100%" 
    AutoGenerateColumns="false" 
    KeyFieldName="FISNO" 
    KeyboardSupport="true" 
    EnableRowsCache="false"
    OnCustomUnboundColumnData="EmployeesGrid_CustomUnboundColumnData" >
    <Columns>
        <dx:GridViewDataTextColumn FieldName="TARIH" Caption="Tarih" Visible="true" VisibleIndex="1" >
            <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy">
            </PropertiesTextEdit>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="CARI_KODU" Caption="Cari Kod"  Visible="true" VisibleIndex="2" />
        <dx:GridViewDataTextColumn FieldName="ISLEM_TURU" Caption="İşlem"  Visible="true" VisibleIndex="2" />
        <dx:GridViewDataTextColumn FieldName="BORC" Caption="Borç" Visible="true" VisibleIndex="3" >
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="ALACAK" Caption="Alacak"  Visible="true" VisibleIndex="4" >
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Total" Caption="Bakiye" UnboundType="Decimal" ReadOnly="true"  VisibleIndex="5">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="FISNO" Caption="İşlem No" Visible="true" VisibleIndex="6" />
    </Columns>
    <SettingsPager AlwaysShowPager="true" ShowEmptyDataRows="true" PageSize="15" ShowNumericButtons="true" PageSizeItemSettings-Visible="true" />
    <Settings ShowFilterRow="true" ShowHeaderFilterButton="true" />
    <BorderBottom BorderWidth="1px" />
    <Paddings Padding="0px" />
    <Border BorderWidth="0px" />
    <SettingsLoadingPanel Text="Yükleniyor..." />
</dx:ASPxGridView>
</asp:Content>
