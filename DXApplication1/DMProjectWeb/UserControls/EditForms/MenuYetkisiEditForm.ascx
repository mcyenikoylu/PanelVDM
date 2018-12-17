<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MenuYetkisiEditForm.ascx.cs" Inherits="DMProjectWeb.UserControls.EditForms.MenuYetkisiEditForm" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v18.1, Version=18.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<script>
    function treeList_SelectionChanged(s, e) {
        window.setTimeout(function () { s.PerformCustomDataCallback(''); }, 0)
    }
    function ASPxTreeList1_SelectionChanged(s, e) {
        window.setTimeout(function () { s.PerformCustomDataCallback(''); }, 0)
    }
</script>
<dx:ASPxPopupControl ID="RoleEditPopup" ClientInstanceName="roleEditPopup" runat="server" PopupHorizontalAlign="WindowCenter"
    ShowCloseButton="false" CloseOnEscape="true"
    PopupVerticalAlign="WindowCenter" CloseAction="None"
    OnWindowCallback="BayiEditPopup_WindowCallback" Modal="true"
    PopupAnimationType="Fade" CssClass="emplEditFormPopup" 
    Width="600px" HeaderText="Menü Yetkileri">
    <ClientSideEvents EndCallback="DevAV.RoleEditPopup_EndCallback" />
    <ContentCollection>
        <dx:PopupControlContentControl runat="server">
            <dx:ASPxFormLayout ID="EmployeeEditFormLayout" runat="server" AlignItemCaptionsInAllGroups="True">
                <Styles>
                    <LayoutGroup CssClass="group"></LayoutGroup>
                </Styles>
                <Items>

                    <dx:LayoutGroup GroupBoxDecoration="None" ShowCaption="False" CssClass="addressGroup">
                        <Items>
                            <dx:LayoutItem ShowCaption="False" CssClass="fullWidthEditorContainer" RequiredMarkDisplayMode="Required">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">



                                        <dx:ASPxTreeList ID="ASPxTreeList1" runat="server" ClientInstanceName="aSPxTreeList1"
                                            Width="100%" KeyFieldName="ID" ParentFieldName="ParentID" SettingsLoadingPanel-Text="Yükleniyor.." 
                                            OnDataBinding="ASPxTreeList1_DataBinding">
                                            <Columns>
                                                <dx:TreeListDataColumn FieldName="ID" Caption="ID" VisibleIndex="0" Visible="false" />
                                                <dx:TreeListDataColumn FieldName="Text" Caption="Menü Adı" VisibleIndex="0" />
                                            </Columns>
                                            <Settings VerticalScrollBarMode="Visible" />
                                            <SettingsBehavior ExpandCollapseAction="NodeDblClick" />
                                            <SettingsSelection Enabled="True" Recursive="True" />
                                            <ClientSideEvents SelectionChanged="ASPxTreeList1_SelectionChanged" />
                                        </dx:ASPxTreeList>



                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                        </Items>
                    </dx:LayoutGroup>


                </Items>
            </dx:ASPxFormLayout>
            <div class="buttonsContainer">
                <dx:ASPxButton ID="EmployeeSaveButton" runat="server" AutoPostBack="false" Text="Kaydet" Width="100px">
                    <ClientSideEvents Click="DevAV.RoleSaveButton_Click" />
                </dx:ASPxButton>
                <dx:ASPxButton ID="EmployeeCancelButton" runat="server" AutoPostBack="False" UseSubmitBehavior="False" Text="Vazgeç" Width="100px">
                    <ClientSideEvents Click="DevAV.RoleCancelButton_Click" />
                </dx:ASPxButton>
            </div>
            <div style="clear: both">
            </div>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>
