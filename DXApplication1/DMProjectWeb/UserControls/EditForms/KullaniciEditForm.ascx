<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KullaniciEditForm.ascx.cs" Inherits="DMProjectWeb.UserControls.EditForms.KullaniciEditForm" %>
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

            //location.reload();
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
<dx:ASPxPopupControl ID="KullaniciEditPopup" ClientInstanceName="kullaniciEditPopup" runat="server" PopupHorizontalAlign="WindowCenter" ShowCloseButton="false" CloseOnEscape="true"
    PopupVerticalAlign="WindowCenter" CloseAction="None"
    OnWindowCallback="KullaniciEditPopup_WindowCallback" Modal="true" PopupAnimationType="Fade" CssClass="emplEditFormPopup">
    <ClientSideEvents EndCallback="DevAV.EmployeeEditPopup_EndCallback" />
    <ContentCollection>
        <dx:PopupControlContentControl runat="server">
            <dx:ASPxFormLayout ID="EmployeeEditFormLayout" runat="server" AlignItemCaptionsInAllGroups="True">
                <Styles>
                    <LayoutGroup CssClass="group"></LayoutGroup>
                </Styles>
                <Items>
                    <dx:LayoutGroup ColCount="2" GroupBoxDecoration="None">
                        <Items>
                            <dx:LayoutItem Caption="İsim">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="FirstNameTextBox" ClientInstanceName="firstNameTextBox" runat="server" Width="250px" MaxLength="30">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="İsim girin." />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Soyisim">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="LastNameTextBox" runat="server" Width="250px" MaxLength="30">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="Soyisim girin." />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Önek">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxComboBox ID="PrefixComboBox" runat="server" Width="250px">
                                            <Items>
                                                <dx:ListEditItem Text="Bay" Value="1" />
                                                <dx:ListEditItem Text="Bayan" Value="2" />
                                            </Items>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Doğum Tarihi">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxDateEdit ID="HireDateEdit" runat="server" Width="250px">
                                        </dx:ASPxDateEdit>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Yetki Grubu">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxComboBox ID="cmbRole" runat="server" Width="250px">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="Yetki seçin." />
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Ünvanı">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="TitleTextBox" runat="server" Width="250px" MaxLength="30">
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Resim">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="uploadControl" Width="250px" MaxLength="30"
                                            NullText="Dosya seçmek için buraya tıklayın..." UploadMode="Advanced" AutoStartUpload="true"
                                            OnFilesUploadComplete="UploadControl_FilesUploadComplete">
                                            <AdvancedModeSettings EnableMultiSelect="false" EnableDragAndDrop="True" />
                                            <ValidationSettings MaxFileSize="10000000" MaxFileSizeErrorText="10mb üzerinde dosya yükleyemezsiniz." MaxFileCount="1"
                                                MaxFileCountErrorText="Sadece tek bir dosya yükleyebilirsiniz." ShowErrors="true" AllowedFileExtensions=".jpg">
                                            </ValidationSettings>
                                            <ClientSideEvents
                                                FilesUploadStart="function(s, e) { UploadControl_OnFileUploadStart(); }"
                                                FilesUploadComplete="function(s, e) { UploadControl_OnFilesUploadComplete(e); }"
                                                UploadingProgressChanged="function(s, e) { UploadControl_OnUploadingProgressChanged(e); }" />
                                        </dx:ASPxUploadControl>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                    <dx:LayoutGroup ColCount="2" GroupBoxDecoration="None" ShowCaption="False">
                        <Items>
                            <dx:LayoutItem Caption="Kullanıcı Adı">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="UserNameTextBox" ClientInstanceName="userNameTextBox" runat="server" Width="250px" MaxLength="30">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="İsim giriniz." />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Name="ParolaAlani" Caption="Parola">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="tbPassword" ClientInstanceName="tbPasswordTextBox" runat="server" Password="True" Width="250px" MaxLength="30">
                                            <ClientSideEvents Validation="function(s, e) {e.isValid = (s.GetText().length&gt;5)}" />
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField ErrorText="Parola gereklidir." IsRequired="True" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                        <dx:ASPxHyperLink ID="ParolayiDegistir" ClientInstanceName="parolayiDegistir" runat="server" Text="Parolayı Değiştir" Width="250px" MaxLength="30">
                                            <ClientSideEvents Click="function(s, e){ popup.Show(); } " />
                                        </dx:ASPxHyperLink>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Email Adresi">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="EmailTextBox" runat="server" Width="250px" MaxLength="30">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="Mail adresi giriniz." />
                                                <RegularExpression ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.[a-zA-Z]+([-.][a-zA-Z]+)*" ErrorText="Invalid email, format example: info@devexpress.com" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Cep Telefonu">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="MobileNumberTextBox" runat="server" Width="250px">
                                            <MaskSettings Mask="(999) 000-0000" />
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="Mask'a uygun giriniz" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                    <dx:LayoutGroup ColCount="2" GroupBoxDecoration="None" ShowCaption="False">
                        <Items>
                            <dx:LayoutItem Caption="Bayi Kodu">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxComboBox ID="BayiKoduComboBox" runat="server" Width="250px">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="Bayi seçiniz." />
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Departman">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxComboBox ID="DeptComboBox" runat="server" Width="250px">
                                            <Items>
                                                <dx:ListEditItem Text="Reyon" Value="Reyon" />
                                                <dx:ListEditItem Text="Muhasebe" Value="Muhasebe" />
                                                <dx:ListEditItem Text="Saha" Value="Saha" />
                                                <dx:ListEditItem Text="Temsilci" Value="Temsilci" />
                                                <dx:ListEditItem Text="Bölge Sorumlusu" Value="Bölge Sorumlusu" />
                                                <dx:ListEditItem Text="Teknik" Value="Teknik" />
                                                <dx:ListEditItem Text="Depo" Value="Depo" />
                                                <dx:ListEditItem Text="Sevkiyat" Value="Sevkiyat" />
                                                <dx:ListEditItem Text="Yönetim" Value="Yönetim" />
                                                <dx:ListEditItem Text="Takım Lideri" Value="Takım Lideri" />
                                                <dx:ListEditItem Text="Müşteri Temsilcisi" Value="MusteriTemsilcisi" />
                                            </Items>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer11" runat="server">
                                        <dx:ASPxCheckBox ID="PurchaseAuthorityCheckBox" runat="server" Text="Hesabın Onay Durumu (Aktif/Pasif)">
                                        </dx:ASPxCheckBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                        <dx:ASPxCheckBox ID="chkHesapKiliti" runat="server" Text="Hesabın Kilit Durumu (Kilitli/Açık)">
                                        </dx:ASPxCheckBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                        </Items>
                    </dx:LayoutGroup>
                </Items>
            </dx:ASPxFormLayout>
            <div class="buttonsContainer">
                <dx:ASPxButton ID="EmployeeSaveButton" runat="server" AutoPostBack="false" Text="Kaydet" Width="100px">
                    <ClientSideEvents Click="DevAV.KullaniciSaveButton_Click" />
                </dx:ASPxButton>
                <dx:ASPxButton ID="EmployeeCancelButton" runat="server" AutoPostBack="False" UseSubmitBehavior="False" Text="Vazgeç" Width="100px">
                    <ClientSideEvents Click="DevAV.KullaniciCancelButton_Click" />
                </dx:ASPxButton>
            </div>
            <div style="clear: both">
            </div>
        </dx:PopupControlContentControl>
    </ContentCollection>

</dx:ASPxPopupControl>
<dx:ASPxPopupControl ID="ASPxPopupControl2" runat="server" HeaderText="Parola Değiştir" Width="407px" ClientInstanceName="popup"
    PopupVerticalAlign="WindowCenter" PopupHorizontalAlign="WindowCenter" Modal="true" PopupAnimationType="Fade">
    <ContentCollection>
        <dx:PopupControlContentControl ID="Popupcontrolcontentcontrol1" runat="server">
            <table>
                <tr>
                    <td>Yeni Parola:</td>
                    <td style="padding-left: 20px;">
                        <dx:ASPxTextBox ID="npsw" runat="server" Password="True" ClientInstanceName="npsw">
                            <ClientSideEvents Validation="function(s, e) {e.isValid = (s.GetText().length&gt;0)}" />
                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" ErrorText="Şifre uzunluğu 6 sembolden fazla olmalı">
                            </ValidationSettings>
                        </dx:ASPxTextBox>
                    </td>
                </tr>
                <tr style="margin-top: 15px;">
                    <td>Yeni Parolayı Tekrarla:</td>
                    <td style="padding-left: 20px;">
                        <dx:ASPxTextBox ID="cnpsw" runat="server" Password="True" ClientInstanceName="cnpsw">
                            <ClientSideEvents Validation="function(s, e) {e.isValid = (s.GetText() == npsw.GetText());}" />
                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" ErrorText="Şifre yanlış">
                            </ValidationSettings>
                        </dx:ASPxTextBox>
                    </td>
                </tr>
            </table>
            <dx:ASPxButton ID="confirmButton" runat="server" Text="Güncelle" AutoPostBack="False" OnClick="confirmButton_Click">
            </dx:ASPxButton>
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