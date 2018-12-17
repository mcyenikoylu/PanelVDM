<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Dokuman_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.Dokuman_GridView_Master" %>
<script>
    function OnCheckedValue(s, e) {
        ASPxCallback1.PerformCallback(s, e);
    }
</script>
<dx:ASPxCallback ID="ASPxCallback1"
    ClientInstanceName="ASPxCallback1"
    OnCallback="ASPxCallback1_Callback" ClientSideEvents-CallbackComplete="function(s, e) {
            var c = e.result.toString();
            if(e.result === 'False')
                ASPxGridViewTemplateReplacement6.SetChecked(false);
            else
                ASPxGridViewTemplateReplacement6.SetChecked(true);             
        }"
    runat="server">
</dx:ASPxCallback>
<style>
    .AktifCheck {
        margin-top: 17px;
        margin-left: 10px;
    }
</style>
<dx:ASPxGridView ID="EmployeesGrid" runat="server"
    ClientInstanceName="employeesGrid"
    AutoGenerateColumns="False"
    KeyFieldName="ID"
    Width="100%"
    KeyboardSupport="true"
    EnableRowsCache="false"
    CssClass="employeesGridView"
    OnRowInserting="EmployeesGrid_RowInserting"
    OnRowDeleting="EmployeesGrid_RowDeleting"
    OnDataBinding="EmployeesGrid_DataBinding"
    OnCellEditorInitialize="EmployeesGrid_CellEditorInitialize">
    <Columns>
        <dx:GridViewCommandColumn ShowEditButton="false" ShowNewButtonInHeader="true" ShowDeleteButton="true" VisibleIndex="0" Width="15">
            <HeaderTemplate>
                <dx:ASPxButton runat="server" Text="Yeni Ekle" RenderMode="Link" AutoPostBack="false">
                    <ClientSideEvents Click="function(s, e){ employeesGrid.AddNewRow(); }" />
                </dx:ASPxButton>
            </HeaderTemplate>
        </dx:GridViewCommandColumn>
        <dx:GridViewDataTextColumn FieldName="ID" Caption="ID" Width="3%" VisibleIndex="0" Visible="false" />
        <dx:GridViewDataColumn Caption="Ön İzleme" Width="15" VisibleIndex="1" Settings-AllowHeaderFilter="False" Visible="false">
            <DataItemTemplate>
                <div id='<%# Eval("ID") %>' onclick="DevAV.GridEditButton_Click(event)" class="gridEditButton" title="Dokümanı görüntülemek için tıklayın"></div>
            </DataItemTemplate>
            <HeaderStyle HorizontalAlign="Center" />
            <EditFormSettings Visible="False" />
        </dx:GridViewDataColumn>
        <dx:GridViewDataDateColumn FieldName="Tarih" Caption="Tarih" Width="15" Visible="true" VisibleIndex="2" PropertiesDateEdit-DisplayFormatInEditMode="false">
            <EditFormSettings Visible="False" />
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataTextColumn FieldName="DokumanAdi" Caption="Doküman Adı" Width="3%" VisibleIndex="3" Visible="true" />
        <dx:GridViewDataTextColumn FieldName="DosyaAdi" Caption="Dosya Adı" Width="3%" VisibleIndex="4" Visible="true">
            <EditFormSettings Visible="False" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataCheckColumn FieldName="Aktif" Caption="Aktif" Width="10" VisibleIndex="5" Visible="true" />
        <dx:GridViewDataComboBoxColumn FieldName="DokumanTipi_TipID5" Caption="Doküman Tipi" Width="3%" VisibleIndex="6" Settings-AllowHeaderFilter="True">
            <PropertiesComboBox
                ValueField="ID"
                ValueType="System.Int32"
                TextField="TipAdi"
                EnableSynchronization="False"
                IncrementalFilteringMode="StartsWith">
                <ValidationSettings RequiredField-IsRequired="true" Display="Dynamic" />
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>
        <dx:GridViewDataColumn Width="25">
            <DataItemTemplate>
                <dx:ASPxButton ID="downloadButton" runat="server" Text="Dokümanı İndir" OnClick="downloadButton_Click" />
            </DataItemTemplate>
        </dx:GridViewDataColumn>
    </Columns>
    <Templates>
        <EditForm>
            <table>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Doküman Adı"></dx:ASPxLabel>
                        <dx:ASPxGridViewTemplateReplacement ID="tbDokumanAdi" runat="server" ReplacementType="EditFormCellEditor" ColumnID="DokumanAdi" Width="200px"></dx:ASPxGridViewTemplateReplacement>
                    </td>
                    <td style="padding-left: 15px;">
                        <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Doküman Yükle"></dx:ASPxLabel>
                        <dx:ASPxUploadControl ID="ucDoc" runat="server" ClientInstanceName="uploadControl" AutoStartUpload="true" ShowUploadButton="False"
                            ShowProgressPanel="true" UploadMode="Advanced"
                            OnFileUploadComplete="ucDoc_FileUploadComplete">
                            <AdvancedModeSettings EnableDragAndDrop="true" EnableMultiSelect="false"></AdvancedModeSettings>
                            <ValidationSettings AllowedFileExtensions=".pdf" MaxFileSize="4194304">
                            </ValidationSettings>
                        </dx:ASPxUploadControl>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Doküman Tipi"></dx:ASPxLabel>
                        <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement4"
                            runat="server" ReplacementType="EditFormCellEditor" ColumnID="DokumanTipi_TipID5"></dx:ASPxGridViewTemplateReplacement>
                    </td>
                    <td>
                        <dx:ASPxCheckBox ID="ASPxGridViewTemplateReplacement6" ClientInstanceName="ASPxGridViewTemplateReplacement6"
                            runat="server" ColumnID="Aktif" ReplacementType="EditFormCellEditor" CssClass="AktifCheck">
                        </dx:ASPxCheckBox>
                        <dx:ASPxLabel Text="Yayınlanma Durumu: Aktif/Pasif" runat="server"></dx:ASPxLabel>
                    </td>

                </tr>
            </table>
            <br />
            <table>
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
    <Settings ShowGroupPanel="False" GridLines="None" ShowFilterRow="false" ShowFilterRowMenu="false" VerticalScrollBarMode="Visible" />
    <SettingsSearchPanel CustomEditorID="SearchBox" HighlightResults="True" ColumnNames="UserName; Email"></SettingsSearchPanel>
    <SettingsPopup>
        <CustomizationWindow HorizontalAlign="LeftSides" VerticalAlign="Below" Width="220px" Height="300px" />
    </SettingsPopup>
    <ClientSideEvents CustomizationWindowCloseUp="DevAV.GridCustomizationWindow_CloseUp" EndCallback="OnCheckedValue" />
    <Styles>
        <Table CssClass="dataTable"></Table>
        <Header CssClass="header"></Header>
        <FocusedRow CssClass="focusRow"></FocusedRow>
        <GroupPanel CssClass="groupPanel" />
    </Styles>
    <SettingsEditing Mode="EditForm"></SettingsEditing>
</dx:ASPxGridView>
