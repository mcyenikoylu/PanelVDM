<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RaporFatura_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.RaporFatura" %>
<dx:ASPxGridView ID="EmployeesGrid" ClientInstanceName="employeesGrid" runat="server" 
        AutoGenerateColumns="False" CssClass="gridView"
        KeyFieldName="CARI_HESAP_KODU" Width="100%" KeyboardSupport="true">
        <Styles Header-CssClass="gridViewHeader" Row-CssClass="gridViewRow" FocusedRow-CssClass="gridViewRowFocused"
            RowHotTrack-CssClass="gridViewRow" FilterRow-CssClass="gridViewFilterRow" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="CARI_HESAP_KODU" Caption="Cari Kodu" Width="6%" VisibleIndex="2" />
            <dx:GridViewDataTextColumn FieldName="CARI_HESAP_ADI" Caption="Cari Adı" Width="10%" VisibleIndex="1" />
            <dx:GridViewDataTextColumn FieldName="FATURA_NO" Caption="Fatura No" Width="10%" VisibleIndex="7" />
            <dx:GridViewDataTextColumn FieldName="BELGE_NO" Caption="Belge No" Width="5%" VisibleIndex="8" />
            <dx:GridViewDataTextColumn FieldName="FATURA_TARIHI" Caption="Fatura Tarihi" Width="7%" VisibleIndex="9" >
              <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy">
                </PropertiesTextEdit>    
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ODEME_TIPI" Caption="Ödeme Tipi" Width="6%"  VisibleIndex="10" />
            <dx:GridViewDataTextColumn FieldName="STOK_KODU" Caption="Stok Kodu" Width="10%"  VisibleIndex="12" />
            <dx:GridViewDataTextColumn FieldName="STOK_ADI" Caption="Stok Adı" Width="22%" VisibleIndex="13" >
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="SERI_NO" Caption="Seri No" Width="10%" VisibleIndex="15" />            
            <dx:GridViewDataTextColumn FieldName="ADET" Caption="Adet" Width="5%" VisibleIndex="15" />
            <dx:GridViewDataTextColumn FieldName="TOPLAM" Caption="Toplam" Width="6%" VisibleIndex="14">
                <PropertiesTextEdit DisplayFormatString="{0:n2} TL" /> 
            </dx:GridViewDataTextColumn>
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