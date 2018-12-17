<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PrimHakedis_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.PrimHakedis_GridView_Master" %>
<dx:ASPxGridView ID="EmployeesGrid" runat="server"
    ClientInstanceName="employeesGrid"
    AutoGenerateColumns="False"
    KeyFieldName="ID"
    Width="100%"
    KeyboardSupport="true"
    EnableRowsCache="false"
    CssClass="employeesGridView">
    <Columns>
        <dx:GridViewDataTextColumn FieldName="ID" Caption="ID" Width="3%" VisibleIndex="0" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="BayiID" Caption="Bayi ID" Width="3%" VisibleIndex="1" Visible="false" />
        <dx:GridViewDataTextColumn FieldName="BayiKodu" Caption="Bayi Kodu" Width="5%" VisibleIndex="2" />
        <dx:GridViewDataTextColumn FieldName="BayiAdi" Caption="Bayi Adı" Width="20%" VisibleIndex="3" />
        <dx:GridViewDataTextColumn FieldName="SistemTarihSaati" Caption="Tarih" Width="7%" Visible="true" VisibleIndex="4">
            <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy">
            </PropertiesTextEdit>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="PrePaidPrimiKDVHaric" Caption="PrePaid Primi KDV Haric" Width="7%" Visible="true" VisibleIndex="5">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="PostPaidPrimiKDVHaric" Caption="PostPaid Primi KDV Haric" Width="7%" Visible="true" VisibleIndex="6">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="WowPrimiKDVHaric" Caption="Wow Primi KDV Haric" Width="7%" Visible="true" VisibleIndex="7">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Extra1" Caption="Extra 1" Width="7%" Visible="true" VisibleIndex="8">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Extra2" Caption="Extra 2" Width="7%" Visible="true" VisibleIndex="9">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Extra3" Caption="Extra 3" Width="7%" Visible="false" VisibleIndex="10">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Extra4" Caption="Extra 4" Width="7%" Visible="false" VisibleIndex="11">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Extra5" Caption="Extra 5" Width="7%" Visible="false" VisibleIndex="12">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Extra6" Caption="Extra 6" Width="7%" Visible="false" VisibleIndex="13">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="ToplamKDVHaric" Caption="Toplam KDV Haric" Width="7%" Visible="true" VisibleIndex="14">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="KDV" Caption="KDV" Width="7%" Visible="true" VisibleIndex="15">
            <PropertiesTextEdit DisplayFormatString="p2" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="ToplamKDVDahil" Caption="Toplam KDV Dahil" Width="7%" Visible="true" VisibleIndex="16">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="CezaSairIslem" Caption="Ceza Sair İŞlem" Width="7%" Visible="true" VisibleIndex="17">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="MahsupSonrasiKalanTutarKDVDahil" Caption="Mahsup Sonrasi Kalan Tutar KDV Dahil" Width="7%" Visible="true" VisibleIndex="18">
            <PropertiesTextEdit DisplayFormatString="{0:n2} TL" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Ay" Caption="Ay" Width="7%" VisibleIndex="19" />
        <dx:GridViewDataTextColumn FieldName="Yil" Caption="Yil" Width="7%" VisibleIndex="20" />
    </Columns>
    <SettingsBehavior AllowFocusedRow="True" EnableCustomizationWindow="true" AllowClientEventsOnLoad="false" ColumnResizeMode="Control" />
    <SettingsPager PageSize="50">
        <NextPageButton Visible="true">
        </NextPageButton>
        <PrevPageButton Visible="true">
        </PrevPageButton>
        <Summary Visible="true" />
        <PageSizeItemSettings Visible="true">
        </PageSizeItemSettings>
    </SettingsPager>
    <Settings ShowGroupPanel="true" GridLines="None" ShowFilterRow="true" ShowFilterRowMenu="true" VerticalScrollBarMode="Visible" />
    <SettingsSearchPanel CustomEditorID="SearchBox" HighlightResults="True" ColumnNames="UserName; Email"></SettingsSearchPanel>
    <SettingsPopup>
        <CustomizationWindow HorizontalAlign="LeftSides" VerticalAlign="Below" Width="220px" Height="300px" />
    </SettingsPopup>
    <ClientSideEvents CustomizationWindowCloseUp="DevAV.GridCustomizationWindow_CloseUp" />
    <Styles>
        <Table CssClass="dataTable"></Table>
        <Header CssClass="header"></Header>
        <FocusedRow CssClass="focusRow"></FocusedRow>
        <GroupPanel CssClass="groupPanel" />
    </Styles>
</dx:ASPxGridView>
