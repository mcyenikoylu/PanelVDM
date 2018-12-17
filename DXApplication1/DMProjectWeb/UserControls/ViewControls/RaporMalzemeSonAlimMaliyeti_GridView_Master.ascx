<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RaporMalzemeSonAlimMaliyeti_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.RaporMalzemeSonAlimMaliyeti_GridView_Master" %>
<dx:ASPxGridView ID="EmployeesGrid" ClientInstanceName="employeesGrid" runat="server" 
        AutoGenerateColumns="False" CssClass="gridView"
        KeyFieldName="CODE" Width="100%" KeyboardSupport="true">
        <Styles Header-CssClass="gridViewHeader" Row-CssClass="gridViewRow" FocusedRow-CssClass="gridViewRowFocused"
            RowHotTrack-CssClass="gridViewRow" FilterRow-CssClass="gridViewFilterRow" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="CODE" Caption="Kod" Width="8%" VisibleIndex="1" />
            <dx:GridViewDataTextColumn FieldName="NAME" Caption="Adı" Width="22%" VisibleIndex="2" >
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ILK_GIRIS_TARIHI" Caption="İlk Giriş Tarihi" Width="8%" VisibleIndex="3" >
             <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy">
                </PropertiesTextEdit>       
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="SON_GIRIS_TARIHI" Caption="Son Giriş Tarihi" Width="8%" VisibleIndex="4" >
             <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy">
                </PropertiesTextEdit>       
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="SON_CIKIS_TARIHI" Caption="Son Çıkış Tarihi" Width="8%" VisibleIndex="5" >
             <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy">
                </PropertiesTextEdit>       
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ILK_GIRISDEN_GUN_SAYISI" Caption="İlk G. Sayısı" Width="5%" VisibleIndex="6" />
            <dx:GridViewDataTextColumn FieldName="SON_GIRISDEN_GUN_SAYISI" Caption="Son G. Sayısı" Width="6%" VisibleIndex="7" />
            <dx:GridViewDataTextColumn FieldName="SON_ALIM_TUTARI" Caption="Son Alım Tutarı" Width="8%" VisibleIndex="8">
                <PropertiesTextEdit DisplayFormatString="{0:n2} TL" /> 
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="GIRIS_MIKTARI" Caption="Giriş Miktarı" Width="5%"  VisibleIndex="9" />
            <dx:GridViewDataTextColumn FieldName="CIKIS_MIKTARI" Caption="Çıkış Miktarı" Width="5%"  VisibleIndex="10" />
            <dx:GridViewDataTextColumn FieldName="KALAN_MIKTAR" Caption="Kalan Miktar" Width="5%"  VisibleIndex="11" />
            <dx:GridViewDataTextColumn FieldName="SON_ALIM_KALAN_MALIYET" Caption="Son Alım Maliyeti" Width="8%"  VisibleIndex="12" />
        </Columns>
        <SettingsBehavior AllowFocusedRow="True" EnableCustomizationWindow="true" AllowClientEventsOnLoad="false" />
        <SettingsPager PageSize="50">
            <NextPageButton Visible="true">
            </NextPageButton>
            <PrevPageButton Visible="true">
            </PrevPageButton>
            <Summary Visible="true" />
            <PageSizeItemSettings Visible="true">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowGroupPanel="False" GridLines="None" VerticalScrollBarMode="Visible" />
        <SettingsSearchPanel CustomEditorID="SearchBox" HighlightResults="True" ColumnNames="UserName; Email"></SettingsSearchPanel>
        <SettingsPopup>
            <CustomizationWindow HorizontalAlign="LeftSides" VerticalAlign="Below" Width="220px" Height="300px" />
        </SettingsPopup>
        <ClientSideEvents CustomizationWindowCloseUp="DevAV.GridCustomizationWindow_CloseUp" />
    </dx:ASPxGridView>