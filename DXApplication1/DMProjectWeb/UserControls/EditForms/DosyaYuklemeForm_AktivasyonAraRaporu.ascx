<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DosyaYuklemeForm_AktivasyonAraRaporu.ascx.cs" Inherits="DMProjectWeb.UserControls.EditForms.DosyaYuklemeForm2" %>
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
<dx:ASPxPopupControl ID="DosyaYuklemePopup"
    ClientInstanceName="dosyaYuklemePopup"
    runat="server"
    PopupHorizontalAlign="WindowCenter"
    Modal="true"
    PopupAnimationType="Fade"
    CloseOnEscape="true"
    PopupVerticalAlign="WindowCenter"
    CloseAction="None"
    OnWindowCallback="DosyaYuklemePopup_WindowCallback"
    ShowCloseButton="false"
    CssClass="custEditFormPopup">
    <ClientSideEvents EndCallback="DevAV.CustomerEditPopup_EndCallback" />
    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
            <dx:ASPxFormLayout ID="EmployeeEditFormLayout" runat="server" AlignItemCaptionsInAllGroups="True">
                <Items>
                    <dx:LayoutItem Caption="Dosya Yolu" >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server" >
                                <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="uploadControl" Width="400px" MaxLength="30"
                                    NullText="Dosya seçmek için buraya tıklayın..." UploadMode="Advanced" AutoStartUpload="false" 
                                    OnFilesUploadComplete="UploadControl_FilesUploadComplete">
                                    <AdvancedModeSettings EnableMultiSelect="false" EnableDragAndDrop="True"  />
                                    <ValidationSettings MaxFileSize="10000000" MaxFileSizeErrorText="10mb üzerinde dosya yükleyemezsiniz." MaxFileCount="1" 
                                        MaxFileCountErrorText="Sadece tek bir dosya yükleyebilirsiniz." ShowErrors="true" AllowedFileExtensions=".xls,.xlsx,.csv" >
                                    </ValidationSettings>
                                    <ClientSideEvents 
                                        FilesUploadStart="function(s, e) { UploadControl_OnFileUploadStart(); }"
                                        FilesUploadComplete="function(s, e) { UploadControl_OnFilesUploadComplete(e); }"
                                        UploadingProgressChanged="function(s, e) { UploadControl_OnUploadingProgressChanged(e); }"
                                        />
                                </dx:ASPxUploadControl>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:ASPxFormLayout>
            <div class="buttonsContainer">
                <dx:ASPxButton ID="DosyaYuklemeKaydetButton" runat="server" AutoPostBack="false" Text="Yükle" Width="100px" >
                     <ClientSideEvents Click="function(s, e) { uploadControl.Upload(); }" />
                </dx:ASPxButton>
                <dx:ASPxButton ID="DosyaYuklemeVazgecButton" runat="server" AutoPostBack="False" UseSubmitBehavior="False" Text="Vazgeç" Width="100px">
                    <ClientSideEvents Click="DevAV.DosyaYuklemeVazgecButton_Click" />
                </dx:ASPxButton>
            </div>
            <div style="clear: both">
            </div>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>
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