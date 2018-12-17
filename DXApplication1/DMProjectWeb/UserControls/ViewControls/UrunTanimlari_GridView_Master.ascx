<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UrunTanimlari_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.UrunTanimlari_GridView_Master" %>
<dx:ASPxGridView ID="EmployeesGrid" ClientInstanceName="employeesGrid" runat="server"
    AutoGenerateColumns="False" CssClass="gridView"
    KeyFieldName="ID" Width="100%" KeyboardSupport="true" 
    OnRowInserting="EmployeesGrid_RowInserting" 
    OnRowUpdating="EmployeesGrid_RowUpdating" 
    OnRowDeleting="EmployeesGrid_RowDeleting"
    OnDataBinding="EmployeesGrid_DataBinding"
    OnCellEditorInitialize="EmployeesGrid_CellEditorInitialize">

    <Styles Header-CssClass="gridViewHeader" 
        Row-CssClass="gridViewRow" 
        FocusedRow-CssClass="gridViewRowFocused"
        RowHotTrack-CssClass="gridViewRow" 
        FilterRow-CssClass="gridViewFilterRow" />

    <Columns>
        <dx:GridViewCommandColumn ShowEditButton="true" ShowNewButtonInHeader="true" ShowDeleteButton="true" VisibleIndex="0" Width="2%">
            <HeaderTemplate>
                <dx:ASPxButton runat="server" Text="Yeni Ekle" RenderMode="Link" AutoPostBack="false">
                    <ClientSideEvents Click="function(s, e){ employeesGrid.AddNewRow(); }" />
                </dx:ASPxButton>
            </HeaderTemplate>
        </dx:GridViewCommandColumn>
        <dx:GridViewDataTextColumn FieldName="UrunKodu" Caption="UrunKodu" Width="2%" VisibleIndex="3" />
        <dx:GridViewDataTextColumn FieldName="UrunAdi" Caption="UrunAdi" Width="2%" VisibleIndex="3" />
        <dx:GridViewDataComboBoxColumn FieldName="KategoriID_TipID4" Caption="Ürün Kategorisi" Width="3%" VisibleIndex="4">
            <PropertiesComboBox
                ValueField="ID"
                ValueType="System.Int32"
                TextField="TipAdi"
                EnableSynchronization="False"
                IncrementalFilteringMode="StartsWith">
                <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>
        <dx:GridViewDataTextColumn FieldName="Marka" Caption="Marka" Width="2%" VisibleIndex="3" />
        <dx:GridViewDataTextColumn FieldName="Model" Caption="Model" Width="2%" VisibleIndex="3" />
        <dx:GridViewDataSpinEditColumn FieldName="Fiyat" Caption="Fiyat" Width="2%" VisibleIndex="3" PropertiesSpinEdit-DisplayFormatString="n2" />
        <dx:GridViewDataImageColumn FieldName="Resim" VisibleIndex="6" Caption="Ürün Resimi"  Width="3%">
            <PropertiesImage ImageUrlFormatString="{0}" ImageWidth="150">
            </PropertiesImage>
        </dx:GridViewDataImageColumn>
    </Columns>
        <Templates>
        <EditForm>
            <table style="padding:15px; margin:15px;">

                <tr>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Urun Kodu"></dx:ASPxLabel>
                        <dx:ASPxGridViewTemplateReplacement ID="tbUrunKodu" runat="server" ReplacementType="EditFormCellEditor" ColumnID="UrunKodu" Width="200px"></dx:ASPxGridViewTemplateReplacement>
                    </td>
                    <td style="padding-left: 15px;">
                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Resim Yükle"></dx:ASPxLabel>
                        <dx:ASPxUploadControl ID="ucDoc" runat="server" ClientInstanceName="uploadControl" AutoStartUpload="true" ShowUploadButton="False"
                            ShowProgressPanel="true" UploadMode="Advanced"
                            OnFileUploadComplete="ucDoc_FileUploadComplete">
                            <AdvancedModeSettings EnableDragAndDrop="true" EnableMultiSelect="false"></AdvancedModeSettings>
                            <ValidationSettings AllowedFileExtensions=".jpg" MaxFileSize="4194304">
                            </ValidationSettings>
                        </dx:ASPxUploadControl>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="UrunAdi"></dx:ASPxLabel>
                        <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement3"
                            runat="server" ReplacementType="EditFormCellEditor" ColumnID="UrunAdi"></dx:ASPxGridViewTemplateReplacement>
                    </td>
                    <td style="padding-left: 15px;">
                        <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Ürün Kategorisi"></dx:ASPxLabel>
                        <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement5"
                            runat="server" ReplacementType="EditFormCellEditor" ColumnID="KategoriID_TipID4"></dx:ASPxGridViewTemplateReplacement>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Marka"></dx:ASPxLabel>
                        <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement4"
                            runat="server" ReplacementType="EditFormCellEditor" ColumnID="Marka"></dx:ASPxGridViewTemplateReplacement>
                    </td>
                    <td style="padding-left: 15px;">
                        <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Model"></dx:ASPxLabel>
                        <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement6"
                            runat="server" ReplacementType="EditFormCellEditor" ColumnID="Model"></dx:ASPxGridViewTemplateReplacement>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Fiyat"></dx:ASPxLabel>
                        <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement7"
                            runat="server" ReplacementType="EditFormCellEditor" ColumnID="Fiyat"></dx:ASPxGridViewTemplateReplacement>
                    </td>
                    <td>
                     
                    </td>
                </tr>
            </table>
            <br />
            <table style="margin:15px;">
                <tr>
                    <td>
                        <%--<dx:ASPxButton ID="btnUpdate" runat="server" Text="Kaydet" AutoPostBack="False">
                            <ClientSideEvents Click="function(s, e) { uploadControl.Upload(); employeesGrid.BeginUpdate(); }" />
                        </dx:ASPxButton>--%>
                        <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement1" runat="server" ReplacementType="EditFormUpdateButton"></dx:ASPxGridViewTemplateReplacement>
                    </td>
                    <td style="padding-left: 15px;">
                        <%--<dx:ASPxButton ID="btnCancel" runat="server" Text="Vazgeç" AutoPostBack="False">
                            <ClientSideEvents Click="function(s, e) { employeesGrid.CancelEdit();}" />
                        </dx:ASPxButton>--%>
                        <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement2" runat="server" ReplacementType="EditFormCancelButton"></dx:ASPxGridViewTemplateReplacement>
                    </td>
                </tr>
            </table>
        </EditForm>
    </Templates>
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
    <SettingsEditing Mode="PopupEditForm"></SettingsEditing>
    <SettingsPopup>
        <EditForm HorizontalAlign="Center" VerticalAlign="WindowCenter" />
    </SettingsPopup>
</dx:ASPxGridView>
