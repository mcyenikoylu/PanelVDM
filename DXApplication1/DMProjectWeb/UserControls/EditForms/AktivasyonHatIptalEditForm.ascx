<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AktivasyonHatIptalEditForm.ascx.cs" Inherits="DMProjectWeb.UserControls.EditForms.AktivasyonHatIptalEditForm" %>
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

        var data = e.callbackData.split('|');

        if (e.errorText)
            ShowMessage(e.errorText);
        else if (data[0] == "success")
            ShowMessage("Dosya yüklemesi başarıyla tamamlandı.");

        //location.reload(); //sayfayı tekrar yüklüyor. yüklenen resim bilgileri kayboluyor. bu yüzden kapattım.

        document.getElementById("someImageID").src = data[1];
    }
    function UploadControl_OnFilesUploadComplete2(e) {
        pcProgress.Hide();

        var data = e.callbackData.split('|');

        if (e.errorText)
            ShowMessage(e.errorText);
        else if (data[0] == "success")
            ShowMessage("Dosya yüklemesi başarıyla tamamlandı.");

        document.getElementById("someImageID2").src = data[1];
    }
    function UploadControl_OnFilesUploadComplete3(e) {
        pcProgress.Hide();

        var data = e.callbackData.split('|');

        if (e.errorText)
            ShowMessage(e.errorText);
        else if (data[0] == "success")
            ShowMessage("Dosya yüklemesi başarıyla tamamlandı.");

        var imageData = data[1].toString().split('@');
        document.getElementById("someImageID3").src = imageData[0];
        document.getElementById("someImageID4").src = imageData[1];
        document.getElementById("someImageID5").src = imageData[2];
        document.getElementById("someImageID6").src = imageData[3];
        document.getElementById("someImageID7").src = imageData[4];
    }
    function UploadControl_OnFilesUploadComplete4(e) {
        pcProgress.Hide();

        var data = e.callbackData.split('|');

        if (e.errorText)
            ShowMessage(e.errorText);
        else if (data[0] == "success")
            ShowMessage("Dosya yüklemesi başarıyla tamamlandı.");

        document.getElementById("someImageID8").src = data[1];
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

<dx:ASPxPopupControl ID="PcAktFaturali" ClientInstanceName="pcAktFaturali" runat="server" HeaderText="Aktivasyon Şebeke İçi Geçiş"
    PopupHorizontalAlign="OutsideRight" PopupVerticalAlign="TopSides" EnableViewState="False" Modal="true" ShowFooter="true"
    CloseAction="CloseButton" ScrollBars="Vertical" 
    OnWindowCallback="PcAktFaturali_WindowCallback">
    <ClientSideEvents EndCallback="DevAV.AktivasyonSebekeIciGecisEditForm_EndCallback" />
    <ContentCollection>
        <dx:PopupControlContentControl runat="server" SupportsDisabledAttribute="True">
            Yeni hat sahibinin bilgileri aşağıdaki alanlara giriniz. Zorunlu (*) alanları doldurunuz. 
            Bilgileri doğruluğu konusunda lütfen özen gösteriniz ve kaydet butonuna basmadan önce bilgileri kontrol ediniz.
                    <dx:ASPxFormLayout ID="EmployeeEditFormLayout" runat="server" AlignItemCaptionsInAllGroups="True">
                        <Styles>
                            <LayoutGroup CssClass="group"></LayoutGroup>
                        </Styles>
                        <Items>
                           
                            <dx:LayoutGroup ColCount="2" GroupBoxDecoration="HeadingLine" Caption="KİMLİK BİLGİLERİ" ShowCaption="True">
                                <Items>
                                    <dx:LayoutItem Caption="Adı">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="TxtAdi" ClientInstanceName="txtAdi" runat="server"
                                                    Width="250px" MaxLength="30">
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                        <RequiredField IsRequired="True" ErrorText="Hat sahibi adını giriniz." />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Soyadı">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="TxtSoyadi" runat="server" Width="250px" MaxLength="30">
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                        <RequiredField IsRequired="True" ErrorText="Hat sahibi soyadını giriniz." />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="TC Kimlik Numarası">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="TxtTCKN" runat="server" Width="250px" MaxLength="11">
                                                    <MaskSettings Mask="00000000000" ErrorText="Invalid zipcode, format: ###########" />
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                        <RequiredField IsRequired="True" ErrorText="TCKN giriniz." />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                         
                                </Items>
                            </dx:LayoutGroup>
                         
                            <dx:LayoutGroup ColCount="2" GroupBoxDecoration="HeadingLine" ShowCaption="True" Caption="İLETİŞİM BİLGİLERİ">
                                <Items>
                                    
                                    <dx:LayoutItem Caption="İletişim Tel No">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="TxtSabitTelTextBox" runat="server" Width="250px">
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
                            <dx:LayoutGroup ColCount="2" GroupBoxDecoration="HeadingLine" ShowCaption="True" Caption="HAT BİLGİLERİ">
                                <Items>
                                    <dx:LayoutItem Caption="İptal Hat Numarası">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="TxtCepTelTextBox" runat="server" Width="250px">
                                                    <MaskSettings Mask="(999) 000-0000" />
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                        <RequiredField IsRequired="True" ErrorText="Mask'a uygun giriniz" />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                              
                                    <dx:LayoutItem Caption="Açıklama">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxTextBox ID="TxtAciklama" runat="server" Width="250px" MaxLength="30">
                                                    <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                        <RequiredField IsRequired="True" ErrorText="Anne kızlık soyadını giriniz." />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:LayoutGroup>
                            <dx:LayoutGroup ColCount="1" GroupBoxDecoration="HeadingLine" ShowCaption="True" Caption="EVRAKLAR">
                                <Items>
                                    <dx:LayoutItem Caption="İptal Talep Formu">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxUploadControl ID="UcHatSozlesmesi" runat="server" ClientInstanceName="ucHatSozlesmesi" Width="400px" MaxLength="30"
                                                    NullText="Evrak seçmek için buraya tıklayın..." UploadMode="Advanced" AutoStartUpload="true" ShowProgressPanel="true"
                                                    OnFilesUploadComplete="UcHatSozlesmesi_FilesUploadComplete">
                                                    <AdvancedModeSettings EnableMultiSelect="false" EnableDragAndDrop="True" EnableFileList="false" />
                                                    <ValidationSettings MaxFileSize="5000000" MaxFileSizeErrorText="5mb üzerinde dosya yükleyemezsiniz." MaxFileCount="1"
                                                        MaxFileCountErrorText="Sadece 1 adet dosya yükleyebilirsiniz." ShowErrors="true"
                                                        AllowedFileExtensions=".jpg,.png,.jpeg">
                                                    </ValidationSettings>
                                                    <ClientSideEvents
                                                        FilesUploadStart="function(s, e) { UploadControl_OnFileUploadStart(); }"
                                                        FilesUploadComplete="function(s, e) { UploadControl_OnFilesUploadComplete(e); }"
                                                        UploadingProgressChanged="function(s, e) { UploadControl_OnUploadingProgressChanged(e); }" />
                                                </dx:ASPxUploadControl>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="Kimlik Fotokobisi">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxUploadControl ID="UcKimlikFotokopisi" runat="server" ClientInstanceName="ucKimlikFotokopisi" Width="400px" MaxLength="30"
                                                    NullText="Evrak seçmek için buraya tıklayın..." UploadMode="Advanced" AutoStartUpload="true" ShowProgressPanel="true"
                                                    OnFilesUploadComplete="UcKimlikFotokopisi_FilesUploadComplete">
                                                    <AdvancedModeSettings EnableMultiSelect="false" EnableDragAndDrop="True" EnableFileList="false" />
                                                    <ValidationSettings MaxFileSize="5000000" MaxFileSizeErrorText="5mb üzerinde dosya yükleyemezsiniz." MaxFileCount="1"
                                                        MaxFileCountErrorText="Sadece 1 adet dosya yükleyebilirsiniz." ShowErrors="true"
                                                        AllowedFileExtensions=".jpg,.png,.jpeg">
                                                    </ValidationSettings>
                                                    <ClientSideEvents
                                                        FilesUploadStart="function(s, e) { UploadControl_OnFileUploadStart(); }"
                                                        FilesUploadComplete="function(s, e) { UploadControl_OnFilesUploadComplete2(e); }"
                                                        UploadingProgressChanged="function(s, e) { UploadControl_OnUploadingProgressChanged(e); }" />
                                                </dx:ASPxUploadControl>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                          
                                    <dx:LayoutItem Caption="Diğer Evraklar">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <dx:ASPxUploadControl ID="UcEvraklar" runat="server" ClientInstanceName="ucEvraklar" Width="400px" MaxLength="30"
                                                    NullText="Birden fazla evrak seçmek için buraya tıklayın..." UploadMode="Advanced" AutoStartUpload="true" ShowProgressPanel="true"
                                                    OnFilesUploadComplete="UcEvraklar_FilesUploadComplete">
                                                    <AdvancedModeSettings EnableMultiSelect="True" EnableDragAndDrop="True" EnableFileList="True" />
                                                    <ValidationSettings MaxFileSize="20000000" MaxFileSizeErrorText="20mb üzerinde dosya yükleyemezsiniz." MaxFileCount="5"
                                                        MaxFileCountErrorText="Sadece 5 adet dosya yükleyebilirsiniz." ShowErrors="true"
                                                        AllowedFileExtensions=".jpg,.png,.jpeg">
                                                    </ValidationSettings>
                                                    <ClientSideEvents
                                                        FilesUploadStart="function(s, e) { UploadControl_OnFileUploadStart(); }"
                                                        FilesUploadComplete="function(s, e) { UploadControl_OnFilesUploadComplete3(e); }"
                                                        UploadingProgressChanged="function(s, e) { UploadControl_OnUploadingProgressChanged(e); }" />
                                                </dx:ASPxUploadControl>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:LayoutGroup>
                            <dx:LayoutGroup ColCount="1" GroupBoxDecoration="HeadingLine" ShowCaption="True" Caption="İPTAL TALEP FORMU">
                                <Items>
                                    <dx:LayoutItem Caption="Evrak Resmi">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <img id="someImageID" width="650" height="850" />
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:LayoutGroup>
                            <dx:LayoutGroup ColCount="1" GroupBoxDecoration="HeadingLine" ShowCaption="True" Caption="KİMLİK FOTOKOPİSİ">
                                <Items>
                                    <dx:LayoutItem Caption="Evrak Resmi">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <img id="someImageID2" width="650" height="850" />
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:LayoutGroup>
                    
                            <dx:LayoutGroup ColCount="1" GroupBoxDecoration="HeadingLine" ShowCaption="True" Caption="DİĞER EVRAKLAR">
                                <Items>
                                    <dx:LayoutItem Caption="1. Evrak Resmi">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <img id="someImageID3" width="650" height="850" />
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="2. Evrak Resmi">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <img id="someImageID4" width="650" height="850" />
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="3. Evrak Resmi">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <img id="someImageID5" width="650" height="850" />
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="4. Evrak Resmi">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <img id="someImageID6" width="650" height="850" />
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:LayoutItem Caption="5. Evrak Resmi">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                <img id="someImageID7" width="650" height="850" />
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:LayoutGroup>
                        </Items>
                    </dx:ASPxFormLayout>
        </dx:PopupControlContentControl>
    </ContentCollection>
    <FooterContentTemplate>
        <table>
            <tr>
                <td style="width: 100%"></td>
                <td>
                    <dx:ASPxButton ID="btnOk" runat="server" AutoPostBack="false" Text="Kaydet" Width="50">
                        <ClientSideEvents Click="DevAV.AktivasyonSebekeIciGecisSaveButton_Click" />
                    </dx:ASPxButton>
                </td>
                <td style="width: 50px"></td>
                <td style="padding-left: 10px;">
                    <dx:ASPxButton ID="btnCansel" runat="server" AutoPostBack="false" Text="Vazgeç" Width="50">
                        <ClientSideEvents Click="DevAV.AktivasyonSebekeIciGecisCancelButton_Click" />
                    </dx:ASPxButton>
                </td>
            </tr>
        </table>
    </FooterContentTemplate>
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