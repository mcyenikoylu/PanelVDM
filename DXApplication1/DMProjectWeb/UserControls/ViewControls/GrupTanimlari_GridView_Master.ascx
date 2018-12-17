<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GrupTanimlari_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.GrupTanimlari_GridView_Master" %>
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
        <dx:GridViewDataTextColumn FieldName="ID" Caption="ID" Width="2%" VisibleIndex="3" />
        <dx:GridViewDataTextColumn FieldName="Adi" Caption="Adı" Width="2%" VisibleIndex="3" />
    </Columns>
        <Templates>
        <EditForm>
            <table style="padding:15px; margin:15px;">
                <tr>
                    <td>
                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Adı Soyadı"></dx:ASPxLabel>
                        <dx:ASPxGridViewTemplateReplacement ID="TxtAdiSoyadi" runat="server" 
                            ReplacementType="EditFormCellEditor" ColumnID="Adi" Width="200px">

                        </dx:ASPxGridViewTemplateReplacement>
                    </td>
                  
                </tr>
            </table>
            <br />
            <table style="margin:15px;">
                <tr>
                    <td>
                        <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement1" runat="server" ReplacementType="EditFormUpdateButton"></dx:ASPxGridViewTemplateReplacement>
                    </td>
                    <td style="padding-left: 15px;">
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
