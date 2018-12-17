<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DuyuruTanimlari_GridView_Master.ascx.cs" Inherits="DMProjectWeb.UserControls.ViewControls.DuyuruTanimlari_GridView_Master" %>
 <script type="text/javascript">
        var fileNumber = 0;
        var fileName = "";
        var startDate = null;
        function UploadControl_OnFileUploadStart() {
            startDate = new Date();
            ClearProgressInfo();
            pcProgress.Show();
        }
        function UploadControl_OnFilesUploadComplete(e) {
            pcProgress.Hide();
            if (e.errorText)
                ShowMessage(e.errorText);
            else if (e.callbackData == "success")
                ShowMessage("Dosya yüklemesi başarıyla tamamlandı.");

            location.reload();
        }
        function ShowMessage(message) {
            window.setTimeout(function () { window.alert(message); }, 0);
        }
        // Progress Dialog
        function UploadControl_OnUploadingProgressChanged(args) {
            if (!pcProgress.IsVisible())
                return;
            if (args.currentFileName != fileName) {
                fileName = args.currentFileName;
                fileNumber++;
            }
            SetCurrentFileUploadingProgress(args.currentFileName, args.currentFileUploadedContentLength, args.currentFileContentLength);
            progress1.SetPosition(args.currentFileProgress);
            SetTotalUploadingProgress(fileNumber, args.fileCount, args.uploadedContentLength, args.totalContentLength);
            progress2.SetPosition(args.progress);
            UpdateProgressStatus(args.uploadedContentLength, args.totalContentLength);
        }
        function SetCurrentFileUploadingProgress(fileName, uploadedLength, fileLength) {
            lblFileName.SetText("Mevcut Dosya İlerlemesi: " + fileName);
            lblFileName.GetMainElement().title = fileName;
            lblCurrentUploadedFileLength.SetText(GetContentLengthString(uploadedLength) + " / " + GetContentLengthString(fileLength));
        }
        function SetTotalUploadingProgress(number, count, uploadedLength, totalLength) {
            lblUploadedFiles.SetText("Toplam İlerleme: " + number + ' den ' + count + " dosya(lar)");
            lblUploadedFileLength.SetText(GetContentLengthString(uploadedLength) + " / " + GetContentLengthString(totalLength));
        }
        function ClearProgressInfo() {
            SetCurrentFileUploadingProgress("", 0, 0);
            progress1.SetPosition(0);
            SetTotalUploadingProgress(0, 0, 0, 0);
            progress2.SetPosition(0);
            lblProgressStatus.SetText('Elapsed time: 00:00:00 &ensp; Estimated time: 00:00:00 &ensp; Speed: ' + GetContentLengthString(0) + '/s');
            fileNumber = 0;
            fileName = "";
        }
        function UpdateProgressStatus(uploadedLength, totalLength) {
            var currentDate = new Date();
            var elapsedDateMilliseconds = currentDate - startDate;
            var speed = uploadedLength / (elapsedDateMilliseconds / 1000);
            var elapsedDate = new Date(elapsedDateMilliseconds);
            var elapsedTime = GetTimeString(elapsedDate);
            var estimatedMilliseconds = Math.floor((totalLength - uploadedLength) / speed) * 1000;
            var estimatedDate = new Date(estimatedMilliseconds);
            var estimatedTime = GetTimeString(estimatedDate);
            var speed = uploadedLength / (elapsedDateMilliseconds / 1000);
            lblProgressStatus.SetText('Geçen zaman: ' + elapsedTime + ' &ensp; Tahmini süre: ' + estimatedTime + ' &ensp; Hız: ' + GetContentLengthString(speed) + '/s');
        }
        function GetContentLengthString(contentLength) {
            var sizeDimensions = ['bytes', 'KB', 'MB', 'GB', 'TB'];
            var index = 0;
            var length = contentLength;
            var postfix = sizeDimensions[index];
            while (length > 1024) {
                length = length / 1024;
                postfix = sizeDimensions[++index];
            }
            var numberRegExpPattern = /[-+]?[0-9]*(?:\.|\,)[0-9]{0,2}|[0-9]{0,2}/;
            var results = numberRegExpPattern.exec(length);
            length = results ? results[0] : Math.floor(length);
            return length.toString() + ' ' + postfix;
        }
        function GetTimeString(date) {
            var timeRegExpPattern = /\d{1,2}:\d{1,2}:\d{1,2}/;
            var results = timeRegExpPattern.exec(date.toUTCString());
            return results ? results[0] : "00:00:00";
        }
    </script>
<script type="text/javascript">
    function onApplicationAttachmentUploadComplete(s, e) {
        var data = e.callbackData.split('|');
        document.getElementById("someImageID").src = data[3];
    }
    //function OnCustomButtonClick(s, e) {
    //    if (e.buttonID == 'btnUrunResmiYukle') {
    //        s.GetRowValues(e.visibleIndex, "ID;", OnGetRowValues);
    //    }
    //    function OnGetRowValues(Value) {
    //        UrunResmiYukle.PerformCallback(Value[0]);
    //        ASPxPopupControl2.Show();
    //    }
    //}
    function OnCheckedValue(s, e) {
        slideResmiAktif.PerformCallback(s, e);
    }
</script>
<div style="float: left; width: 100%; margin-left: 3px;">
    <dx:ASPxPageControl ID="carTabPage" runat="server" ActiveTabIndex="0" EnableHierarchyRecreation="True">
        <TabPages>
            <dx:TabPage Text="Duyurular">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl1" runat="server">

                        <dx:ASPxGridView ID="EmployeesGrid" runat="server"
                            ClientInstanceName="employeesGrid"
                            AutoGenerateColumns="False"
                            KeyFieldName="ID"
                            Width="100%"
                            KeyboardSupport="true"
                            EnableRowsCache="false"
                            CssClass="employeesGridView"
                            OnRowInserting="EmployeesGrid_RowInserting"
                            OnRowUpdating="EmployeesGrid_RowUpdating"
                            OnRowDeleting="EmployeesGrid_RowDeleting">
                            <Columns>
                                <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="true" ShowDeleteButton="true" VisibleIndex="0" Width="5%">
                                    <HeaderTemplate>
                                        <dx:ASPxButton runat="server" Text="Yeni Ekle" RenderMode="Link" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s,e){employeesGrid.AddNewRow();}" />
                                        </dx:ASPxButton>
                                    </HeaderTemplate>
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="0" Visible="false" />
                                <dx:GridViewDataDateColumn FieldName="DuyuruTarihi" Caption="Duyuru Tarihi" Width="10%" VisibleIndex="1">
                                    <PropertiesDateEdit AllowUserInput="false" AllowNull="true">
                                    </PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn FieldName="SistemKayitTarihi" Caption="Sistem Kayıt Tarihi" Width="10%" VisibleIndex="2" Visible="false">
                                    <PropertiesTextEdit DisplayFormatString="dd-MM-yyyy hh:mm">
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Baslik" Caption="Başlık" Width="30%" Visible="true" VisibleIndex="3" />
                                <dx:GridViewDataTextColumn FieldName="Aciklama" Caption="Açıklama" Width="40%" Visible="true" VisibleIndex="4" />
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
                            <Settings ShowGroupPanel="False" GridLines="None" ShowFilterRow="false" ShowFilterRowMenu="true" VerticalScrollBarMode="Visible" />
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

                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Duyurular (Slider)">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl2" runat="server">

                        <dx:ASPxCallback ID="SlideResmiAktif"
                            ClientInstanceName="slideResmiAktif"
                            OnCallback="SlideResmiAktif_Callback"
                            ClientSideEvents-CallbackComplete="function(s, e) {
                                var c = e.result.toString();
                                if(e.result === 'False')
                                    ASPxGridViewTemplateReplacement6.SetChecked(false);
                                else
                                    ASPxGridViewTemplateReplacement6.SetChecked(true);             
                            }"
                            runat="server">
                        </dx:ASPxCallback>
                        <asp:HiddenField ID="HiddenField1" runat="server" />

                        <dx:ASPxGridView ID="DuyurularSliderGrid" runat="server"
                            AutoGenerateColumns="False"
                            KeyFieldName="ID"
                            ClientInstanceName="duyurularSliderGrid"
                            Width="100%"
                            OnRowInserting="DuyurularSliderGrid_RowInserting"
                            OnRowUpdating="DuyurularSliderGrid_RowUpdating"
                            OnRowDeleting="DuyurularSliderGrid_RowDeleting">
                            <ClientSideEvents EndCallback="OnCheckedValue" />
                            <Columns>
                                <dx:GridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="true" ShowDeleteButton="true" VisibleIndex="0" Width="6%">
                                    <HeaderTemplate>
                                        <dx:ASPxButton runat="server" Text="Yeni Ekle" RenderMode="Link" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s,e){duyurularSliderGrid.AddNewRow();}" />
                                        </dx:ASPxButton>
                                    </HeaderTemplate>
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataColumn FieldName="ID" Visible="false" VisibleIndex="1" />
                                <dx:GridViewDataTextColumn FieldName="SlideAdi" Caption="SlideAdi" VisibleIndex="2" Width="70%">
                                    <PropertiesTextEdit Width="350">
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataMemoColumn FieldName="SiraNo" Caption="SiraNo" VisibleIndex="3" PropertiesMemoEdit-Rows="6" Width="5%">
                                    <PropertiesMemoEdit Width="450" Height="150">
                                    </PropertiesMemoEdit>
                                </dx:GridViewDataMemoColumn>
                                <dx:GridViewDataCheckColumn FieldName="Aktif" Caption="Aktif" VisibleIndex="5" Width="5%">
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataImageColumn FieldName="ResimAdi" VisibleIndex="6" Caption="Resim" Width="14%">
                                    <PropertiesImage ImageUrlFormatString="{0}" ImageHeight="120">
                                    </PropertiesImage>
                                </dx:GridViewDataImageColumn>
                            </Columns>
                            <EditFormLayoutProperties>
                                <Items>
                                    <dx:GridViewColumnLayoutItem>
                                        <Template>
                                            <img id="someImageID" height="150" width="150" />
                                            <dx:ASPxUploadControl ID="MyUploadControl" runat="server" ShowProgressPanel="True" ShowUploadButton="False" AutoStartUpload="true"
                                                UploadMode="Auto" Width="280px" OnFileUploadComplete="MyUploadControl_FileUploadComplete">
                                                <AdvancedModeSettings EnableDragAndDrop="False" EnableFileList="True" EnableMultiSelect="False">
                                                </AdvancedModeSettings>
                                                <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".jpg,.jpeg,.gif,.png" />
                                                <ClientSideEvents FileUploadComplete="onApplicationAttachmentUploadComplete" />
                                            </dx:ASPxUploadControl>
                                            <dx:ASPxLabel Text="Slide Adi:" runat="server"></dx:ASPxLabel>
                                            <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement4"
                                                runat="server" ReplacementType="EditFormCellEditor" ColumnID="SlideAdi"></dx:ASPxGridViewTemplateReplacement>
                                            <dx:ASPxLabel Text="Sira No:" runat="server"></dx:ASPxLabel>
                                            <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement3"
                                                runat="server" ReplacementType="EditFormCellEditor" ColumnID="SiraNo"></dx:ASPxGridViewTemplateReplacement>
                                            <dx:ASPxCheckBox ID="ASPxGridViewTemplateReplacement6" ClientInstanceName="ASPxGridViewTemplateReplacement6"
                                                runat="server" ColumnID="Aktif" ReplacementType="EditFormCellEditor">
                                            </dx:ASPxCheckBox>
                                            <dx:ASPxLabel Text="Yayınlansın." runat="server"></dx:ASPxLabel>
                                            <br />
                                            <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement1"
                                                runat="server" ReplacementType="EditFormUpdateButton"></dx:ASPxGridViewTemplateReplacement>
                                            <dx:ASPxGridViewTemplateReplacement ID="ASPxGridViewTemplateReplacement2"
                                                runat="server" ReplacementType="EditFormCancelButton"></dx:ASPxGridViewTemplateReplacement>
                                        </Template>
                                    </dx:GridViewColumnLayoutItem>
                                </Items>
                            </EditFormLayoutProperties>
                            <SettingsEditing Mode="EditForm" />
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
                            <Settings ShowGroupPanel="False" GridLines="None" ShowFilterRow="false" ShowFilterRowMenu="true" VerticalScrollBarMode="Visible" />
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

                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Duyurular (Popup)">
                <ContentCollection>
                    <dx:ContentControl ID="ContentControl3" runat="server" Width="100%">
                        <div style="float: left; width=100%;">
                            <div style="float: left; padding: 15px; width=100%;">
                                <dx:ASPxTextBox runat="server" Caption="Duyuru Adı:" Width="320"></dx:ASPxTextBox>
                                <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="uploadControl" Width="320"
                                    NullText="resimleri seçiniz." UploadMode="Advanced" 
                                    ShowUploadButton="False" ShowProgressPanel="False" AutoStartUpload="true"
                                    OnFileUploadComplete="UploadControl_FileUploadComplete">
                                    <AdvancedModeSettings EnableMultiSelect="false" EnableDragAndDrop="True" EnableFileList="false" />
                                    <ValidationSettings MaxFileSize="6194304" AllowedFileExtensions=".jpg">
                                    </ValidationSettings>
                                    <ClientSideEvents FilesUploadStart="function(s, e) { UploadControl_OnFileUploadStart(); }"
                                        FilesUploadComplete="function(s, e) { UploadControl_OnFilesUploadComplete(e); }"
                                        UploadingProgressChanged="function(s, e) { UploadControl_OnUploadingProgressChanged(e); }" />
                                </dx:ASPxUploadControl>
                            </div>
                            <div style="float: left; padding: 15px; width:100%;">
                                <img src='<%=popupresimyolu %>' width="400" height="260" />
                            </div>
                        </div>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
      <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" ClientInstanceName="pcProgress" Modal="True" HeaderText="Dosya Aktarımı"
        PopupAnimationType="None" CloseAction="None" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="460px"
        AllowDragging="true" ShowPageScrollbarWhenModal="True" ShowCloseButton="False" ShowFooter="True">
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server" SupportsDisabledAttribute="True">
                <table style="width: 100%;">
                    <tr>
                        <td style="width: 100%;">
                            <div style="overflow: hidden; width: 280px;">
                                <dx:ASPxLabel ID="lblFileName" runat="server" ClientInstanceName="lblFileName" Text=""
                                    Wrap="False">
                                </dx:ASPxLabel>
                            </div>
                        </td>
                        <td class="NoWrap" style="text-align: right">
                            <dx:ASPxLabel ID="lblCurrentUploadedFileLength" runat="server" ClientInstanceName="lblCurrentUploadedFileLength"
                                Text="" Wrap="False">
                            </dx:ASPxLabel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="TopPadding">
                            <dx:ASPxProgressBar ID="ASPxProgressBar1" runat="server" Height="21px" Width="100%"
                                ClientInstanceName="progress1">
                            </dx:ASPxProgressBar>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="Spacer" style="height: 12px;"></div>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%;">
                            <dx:ASPxLabel ID="lblUploadedFiles" runat="server" ClientInstanceName="lblUploadedFiles" Text=""
                                Wrap="False">
                            </dx:ASPxLabel>
                        </td>
                        <td class="NoWrap" style="text-align: right">
                            <dx:ASPxLabel ID="lblUploadedFileLength" runat="server" ClientInstanceName="lblUploadedFileLength"
                                Text="" Wrap="False">
                            </dx:ASPxLabel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="TopPadding">
                            <dx:ASPxProgressBar ID="ASPxProgressBar2" runat="server" CssClass="BottomMargin" Height="21px" Width="100%"
                                ClientInstanceName="progress2">
                            </dx:ASPxProgressBar>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="Spacer" style="height: 12px;"></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <dx:ASPxLabel ID="lblProgressStatus" runat="server" ClientInstanceName="lblProgressStatus" Text=""
                                Wrap="False">
                            </dx:ASPxLabel>
                        </td>
                    </tr>
                </table>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <FooterTemplate>
            <div style="overflow: hidden;">
                <dx:ASPxButton ID="btnCancel" runat="server" AutoPostBack="False" Text="İptal" ClientInstanceName="btnCancel" Width="100px" Style="float: right">
                    <ClientSideEvents Click="function(s, e) { UploadControl.Cancel(); }" />
                </dx:ASPxButton>
            </div>
        </FooterTemplate>
        <FooterStyle>
            <Paddings Padding="5px" PaddingRight="10px" />
        </FooterStyle>
    </dx:ASPxPopupControl>
</div>



