<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RaporKar_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.RaporKar" %>
<dx:ASPxGridView ID="EmployeesGrid" ClientInstanceName="employeesGrid" runat="server" 
        AutoGenerateColumns="False" CssClass="gridView"
        KeyFieldName="FIRMA" Width="100%" KeyboardSupport="true">
        <Styles Header-CssClass="gridViewHeader" Row-CssClass="gridViewRow" FocusedRow-CssClass="gridViewRowFocused"
            RowHotTrack-CssClass="gridViewRow" FilterRow-CssClass="gridViewFilterRow" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="FIRMA" Caption="Firma" Width="8%" VisibleIndex="2" />
            <dx:GridViewDataTextColumn FieldName="FISTARIHI" Caption="Fiş Tarihi" Width="8%" VisibleIndex="1" >
             <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy">
                </PropertiesTextEdit>       
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="STOKKODU" Caption="Stok Kodu" Width="8%" VisibleIndex="7" />
            <dx:GridViewDataTextColumn FieldName="STOKADI" Caption="Stok Adı" Width="20%" VisibleIndex="8" />
            <dx:GridViewDataTextColumn FieldName="OZELKOD1" Caption="Özel Kod 1" Width="5%" VisibleIndex="9" >
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="OZELKOD2" Caption="Özel Kod 2" Width="5%"  VisibleIndex="10" />
            <dx:GridViewDataTextColumn FieldName="OZELKOD3" Caption="Özel Kod 3" Width="5%"  VisibleIndex="12" />
            <dx:GridViewDataTextColumn FieldName="OZELKOD4" Caption="Özel Kod 4" Width="5%" VisibleIndex="13" >
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="SATIS_MIKTARI" Caption="Satış Miktarı" Width="8%" VisibleIndex="14" />
            <dx:GridViewDataTextColumn FieldName="SATISTUTARI" Caption="Satış Tutarı" Width="8%" VisibleIndex="15">
                <PropertiesTextEdit DisplayFormatString="{0:n2} TL" /> 
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MALIYET" Caption="Maliyet" Width="8%" VisibleIndex="16">
                <PropertiesTextEdit DisplayFormatString="{0:n2} TL" /> 
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="KAR" Caption="Kar" Width="8%" VisibleIndex="17">
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