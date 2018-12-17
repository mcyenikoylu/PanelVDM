<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BayiEditForm.ascx.cs" Inherits="DMProjectWeb.UserControls.EditForms.BayiEditForm" %>
<dx:ASPxPopupControl ID="BayiEditPopup" ClientInstanceName="bayiEditPopup" runat="server" PopupHorizontalAlign="WindowCenter"
    ShowCloseButton="false" CloseOnEscape="true"
    PopupVerticalAlign="WindowCenter" CloseAction="None"
    OnWindowCallback="BayiEditPopup_WindowCallback" Modal="true" PopupAnimationType="Fade" CssClass="emplEditFormPopup">
    <ClientSideEvents EndCallback="DevAV.BayiEditPopup_EndCallback" />
    <ContentCollection>
        <dx:PopupControlContentControl runat="server">
            <dx:ASPxFormLayout ID="EmployeeEditFormLayout" runat="server" AlignItemCaptionsInAllGroups="True">
                <Styles>
                    <LayoutGroup CssClass="group"></LayoutGroup>
                </Styles>
                <Items>
                    <dx:LayoutGroup ColCount="2" GroupBoxDecoration="None">
                        <Items>
                            <dx:LayoutItem Caption="Bayi Kodu">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="BayiKoduTextBox" ClientInstanceName="bayiKoduTextBox" runat="server"
                                            Width="250px" MaxLength="50">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="Bayi kodu giriniz." />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Bayi Adı">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="BayiAdiTextBox" runat="server" Width="250px" MaxLength="150">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="Bayi adı giriniz." />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Cari Adı">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="BayiCariAdiTextBox" runat="server" Width="250px" MaxLength="150">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="Bayi cari adı giriniz." />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Yetkili Adı Soyadı">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="YetkiliAdiSoyadiTextBox" runat="server" Width="250px" MaxLength="150">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="Yetkili kişi adı giriniz." />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                    <dx:LayoutGroup GroupBoxDecoration="None" ShowCaption="False" CssClass="addressGroup">
                        <Items>
                            <dx:LayoutItem Caption="Adres" CssClass="fullWidthEditorContainer" RequiredMarkDisplayMode="Required">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="AdresTextBox" runat="server" NullText="Adres" Width="100%" MaxLength="150">
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption=" " RequiredMarkDisplayMode="Hidden">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <table class="fullWidthTable">
                                            <tr>
                                                <td>
                                                    <dx:ASPxComboBox ID="CmbSehir" runat="server" Width="200px" NullText="Şehir" ClientInstanceName="cmbSehir" >
                                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { OnCountryChanged(s); }" />
                                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                            <RequiredField IsRequired="True" ErrorText="Şehir seçiniz." />
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxComboBox ID="CmbIlce" runat="server" Width="200px" NullText="İlçe" ClientInstanceName="cmbIlce" OnCallback="CmbIlce_Callback">
                                                        <ClientSideEvents EndCallback="OnEndCallback" />
                                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                            <RequiredField IsRequired="True" ErrorText="İlçe seçiniz." />
                                                        </ValidationSettings>
                                                    </dx:ASPxComboBox>
                                                </td>
                                                <td class="fullWidthCell" style="margin: 0;">
                                                    <dx:ASPxTextBox ID="PostaKoduTextBox" runat="server" NullText="Posta Kodu" Width="100%" >
                                                        <MaskSettings Mask="00000" ErrorText="Invalid zipcode, format: #####" />
                                                        <ValidationSettings ErrorDisplayMode="ImageWithTooltip" />
                                                    </dx:ASPxTextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                    <dx:LayoutGroup ColCount="2" GroupBoxDecoration="None">
                        <Items>
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
                                        <dx:ASPxTextBox ID="CepTelTextBox" runat="server" Width="250px">
                                            <MaskSettings Mask="(999) 000-0000" />
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="Mask'a uygun giriniz" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Sabit Telefon">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="SabitTelTextBox" runat="server" Width="250px">
                                            <MaskSettings Mask="(999) 000-0000" />
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="Mask'a uygun giriniz" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Faks Telefonu">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="FaksTelTextBox" runat="server" Width="250px">
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
                            <dx:LayoutItem Caption="Müşteri Temsilcisi">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxComboBox ID="cmbMusteriTemsilcisi" runat="server" Width="250px" NullText="Seçiniz">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="Müşteri temsilcisi seçiniz." />
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Grup Adı">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxComboBox ID="cmbGrup" runat="server" Width="250px" NullText="Seçiniz">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="Grup seçiniz." />
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Bölge Adı">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxComboBox ID="cmbBolge" runat="server" Width="250px" NullText="Seçiniz">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="Bölge seçiniz." />
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Bayi Tipi">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxComboBox ID="cmbBayiTipi" runat="server" Width="250px" NullText="Seçiniz">
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip">
                                                <RequiredField IsRequired="True" ErrorText="Bayi tipi seçiniz." />
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer11" runat="server">
                                        <dx:ASPxCheckBox ID="BayiDurumCheckBox" runat="server" Text="Bayi Hesabının Durumu (Aktif/Pasif)">
                                        </dx:ASPxCheckBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                </Items>
            </dx:ASPxFormLayout>
            <div class="buttonsContainer">
                <dx:ASPxButton ID="KaydetVeKullaniciOlustur" runat="server" AutoPostBack="false" Text="Kaydet ve Kullanıcı Oluştur" Width="200px">
                    <ClientSideEvents Click="DevAV.KaydetVeKullaniciOlusturButton_Click" />
                </dx:ASPxButton>
                <dx:ASPxButton ID="EmployeeSaveButton" runat="server" AutoPostBack="false" Text="Kaydet" Width="100px">
                    <ClientSideEvents Click="DevAV.BayiSaveButton_Click" />
                </dx:ASPxButton>
                <dx:ASPxButton ID="EmployeeCancelButton" runat="server" AutoPostBack="False" UseSubmitBehavior="False" Text="Vazgeç" Width="100px">
                    <ClientSideEvents Click="DevAV.BayiCancelButton_Click" />
                </dx:ASPxButton>
            </div>
            <div style="clear: both">
            </div>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>
