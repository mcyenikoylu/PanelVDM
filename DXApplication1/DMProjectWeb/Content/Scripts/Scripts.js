window.DevAV = (function() {
    var updateTimerID = -1;
    var updateTimeout = 300;
    var searchBoxTimer = -1;
    var cardClassName = "dvCard";
    var cardViewFocusClassName = "focusCard";
    var pendingCallbacks = {};

    var callbackHelper = (function () {
        var callbackControlQueue = [],
            currentCallbackControl = null;

        function doCallback(callbackControl, args, sender) {
            if (!currentCallbackControl) {
                currentCallbackControl = callbackControl;
                if (typeof (detailsCallbackPanel) !== "undefined" && callbackControl === mainCallbackPanel)
                    detailsCallbackPanel.cpSkipUpdateDetails = true;
                callbackControl.EndCallback.RemoveHandler(onEndCallback);
                callbackControl.EndCallback.AddHandler(onEndCallback);
                callbackControl.PerformCallback(args);
            } else
                placeInQueue(callbackControl, args, getSenderId(sender));
        };
        function getSenderId(senderObject) {
            if (senderObject.constructor === String)
                return senderObject;
            return senderObject.name || senderObject.id;
        };
        function placeInQueue(callbackControl, args, sender) {
            var queue = callbackControlQueue;
            for (var i = 0; i < queue.length; i++) {
                if (queue[i].control === callbackControl && queue[i].sender === sender) {
                    queue[i].args = args;
                    return;
                }
            }
            queue.push({ control: callbackControl, args: args, sender: sender });
        };
        function onEndCallback(sender) {
            sender.EndCallback.RemoveHandler(onEndCallback);
            currentCallbackControl = null;
            var queuedPanel = callbackControlQueue.shift();
            if (queuedPanel)
                doCallback(queuedPanel.control, queuedPanel.args, queuedPanel.sender);
        }
        return {
            DoCallback: doCallback
        };
    })();
    function updateDetailInfo(sender) { // TODO use one method to create timer
        if(detailsCallbackPanel.cpSkipUpdateDetails) {
            detailsCallbackPanel.cpSkipUpdateDetails = false;
            return;
        }
        if(updateTimerID > -1)
            window.clearTimeout(updateTimerID);
        updateTimerID = window.setTimeout(function () {
            window.clearTimeout(updateTimerID);
            callbackHelper.DoCallback(detailsCallbackPanel, "", sender);
        }, updateTimeout);
    };
    //function addTask(employeeID, sender) {
    //    employeeID = employeeID ? employeeID.toString() : "";
    //    performTaskCommand("New", employeeID, sender);
    //}
    //function editTask(id, sender) {
    //    performTaskCommand("Edit", id, sender);
    //};
    function performTaskCommand(commandName, args, sender) {
        showClearedPopup(taskEditPopup);
        callbackHelper.DoCallback(taskEditPopup, commandName + "|" + args, sender);
    };
    function deleteTask(id, sender) {
        if (checkReadOnlyMode())
            return;
        if (confirm("Remove task?"))
            callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
    };
    function gridCustomizationWindow_CloseUp() {
        toolbarMenu.GetItemByName("ColumnsCustomization").SetChecked(false);
    };
    //function cardView_Init(s, e) {
    //    ASPxClientUtils.AttachEventToElement(s.GetMainElement(), "click", function (evt) {
    //        var cardID = getCardID(ASPxClientUtils.GetEventSource(evt));
    //        if (cardID)
    //            selectCard(cardID, s);
    //    });
    //    if (s.cpSelectedItemID)
    //        selectCard(s.cpSelectedItemID, s);

    //    setToolbarCWItemEnabled(false);
    //};
    //function cardView_EndCallback(s, e) {
    //    if (s.cpSelectedItemID)
    //        selectCard(s.cpSelectedItemID, s);
    //};

    //function selectCard(id, sender) {
    //    var card = document.getElementById(id);
    //    if (!card || card.className.indexOf(cardViewFocusClassName) > -1)
    //        return;

    //    var prevSelectedCard = document.getElementById(hiddenField.Get("ID"));
    //    if (prevSelectedCard)
    //        prevSelectedCard.className = ASPxClientUtils.Trim(prevSelectedCard.className.replace(cardViewFocusClassName, ""));

    //    card.className += " " + cardViewFocusClassName;
    //    hiddenField.Set("ID", id);

    //    var updateDetails = page === employeePage; //TODO add flag to the page 
    //    if (updateDetails)
    //        callbackHelper.DoCallback(detailsCallbackPanel, "", sender);
    //};
    //function getCardID(element) {
    //    while (element && element.tagName !== "BODY") {
    //        if (element.className && element.className.indexOf(cardClassName) > -1)
    //            return element.id;
    //        element = element.parentNode;
    //    }
    //    return null;
    //};
    function setToolbarCWItemEnabled(enabled) {
        var item = toolbarMenu.GetItemByName("ColumnsCustomization");
        if (!item)
            return;
        item.SetEnabled(enabled);
        item.SetChecked(false);
    }

    function kullaniciSaveButton_Click(s, e) { // MCY
        var commandName = kullaniciEditPopup.cpUserKey ? "Edit" : "New";
        saveEditForm(kullaniciEditPopup, serializeArgs([commandName, kullaniciEditPopup.cpUserKey]));
    };
    function kullaniciCancelButton_Click(s, e) { // MCY
        kullaniciEditPopup.Hide();
    };
    function bayiSaveButton_Click(s, e) { // MCY
        var commandName = bayiEditPopup.cpEmployeeID ? "Edit" : "New";
        saveEditForm(bayiEditPopup, serializeArgs([commandName, bayiEditPopup.cpEmployeeID]));
    };
    function kaydetVeKullaniciOlusturButton_Click(s, e) { // MCY
        var commandName = "NewVeKullanici";
        saveEditForm(bayiEditPopup, serializeArgs([commandName, bayiEditPopup.cpEmployeeID]));
    };
    function bayiCancelButton_Click(s, e) { // MCY
        bayiEditPopup.Hide();
    };
    function aktivasyonFaturaliSaveButton_Click(s, e) { // MCY
        var commandName = pcAktFaturali.cpEmployeeID ? "Edit" : "New";
        saveEditForm(pcAktFaturali, serializeArgs([commandName, pcAktFaturali.cpEmployeeID]));
    };
    function aktivasyonFaturaliCancelButton_Click(s, e) { // MCY
        pcAktFaturali.Hide();
    };
    function roleSaveButton_Click(s, e) { // MCY
        var commandName = roleEditPopup.cpEmployeeID ? "Edit" : "New";
        saveEditForm(roleEditPopup, serializeArgs([commandName, roleEditPopup.cpEmployeeID]));
    };
    function roleCancelButton_Click(s, e) { // MCY
        roleEditPopup.Hide();
    };
    function aktivasyonFaturasizSaveButton_Click(s, e) { // MCY
        var commandName = pcAktFaturali.cpEmployeeID ? "Edit" : "New";
        saveEditForm(pcAktFaturali, serializeArgs([commandName, pcAktFaturali.cpEmployeeID]));
    };
    function aktivasyonFaturasizCancelButton_Click(s, e) { // MCY
        pcAktFaturali.Hide();
    };
    //SebekeIciGecis
    function aktivasyonSebekeIciGecisSaveButton_Click(s, e) { // MCY
        var commandName = pcAktFaturali.cpEmployeeID ? "Edit" : "New";
        saveEditForm(pcAktFaturali, serializeArgs([commandName, pcAktFaturali.cpEmployeeID]));
    };
    function aktivasyonSebekeIciGecisCancelButton_Click(s, e) { // MCY
        pcAktFaturali.Hide();
    };
    //aktivasyonTaahhutname
    function aktivasyonTaahhutnameSaveButton_Click(s, e) { // MCY
        var commandName = pcAktFaturali.cpEmployeeID ? "Edit" : "New";
        saveEditForm(pcAktFaturali, serializeArgs([commandName, pcAktFaturali.cpEmployeeID]));
    };
    function aktivasyonTaahhutnameCancelButton_Click(s, e) { // MCY
        pcAktFaturali.Hide();
    };
    //AktivasyonHatIptal
    function aktivasyonHatIptalSaveButton_Click(s, e) { // MCY
        var commandName = pcAktFaturali.cpEmployeeID ? "Edit" : "New";
        saveEditForm(pcAktFaturali, serializeArgs([commandName, pcAktFaturali.cpEmployeeID]));
    };
    function aktivasyonHatIptalCancelButton_Click(s, e) { // MCY
        pcAktFaturali.Hide();
    };
    //AktivasyonVodafoneNet
    function aktivasyonVodafoneNetSaveButton_Click(s, e) { // MCY
        var commandName = pcAktFaturali.cpEmployeeID ? "Edit" : "New";
        saveEditForm(pcAktFaturali, serializeArgs([commandName, pcAktFaturali.cpEmployeeID]));
    };
    function aktivasyonVodafoneNetCancelButton_Click(s, e) { // MCY
        pcAktFaturali.Hide();
    };
    //AktivasyonEFatura
    function aktivasyonEFaturaSaveButton_Click(s, e) { // MCY
        var commandName = pcAktFaturali.cpEmployeeID ? "Edit" : "New";
        saveEditForm(pcAktFaturali, serializeArgs([commandName, pcAktFaturali.cpEmployeeID]));
    };
    function aktivasyonEFaturaCancelButton_Click(s, e) { // MCY
        pcAktFaturali.Hide();
    };
    //function employeeSaveButton_Click(s, e) {
    //    var commandName = kullaniciEditPopup.cpUserKey ? "Edit" : "New";
    //    saveEditForm(kullaniciEditPopup, serializeArgs([commandName, kullaniciEditPopup.cpUserKey]));
    //};
    //function employeeCancelButton_Click(s, e) {
    //    kullaniciEditPopup.Hide();
    //};

    //function evaluationSaveButton_Click(s, e) {
    //    saveEditForm(evaluationEditPopup, serializeArgs([evaluationEditPopup.cpEvaluationID]), true);
    //};
    //function evaluationCancelButton_Click(s, e) {
    //    evaluationEditPopup.Hide();
    //};
    //function taskSaveButton_Click(s, e) {
    //    var commandName = taskEditPopup.cpTaskID ? "Edit" : "New";
    //    saveEditForm(taskEditPopup, serializeArgs([commandName, taskEditPopup.cpTaskID]), page === employeePage);
    //};
    //function taskCancelButton_Click(s, e) {
    //    taskEditPopup.Hide();
    //};
    //function customerSaveButton_Click(s, e) { // TODO rename CustomerEmployeeForm(Button)_Click
    //    saveEditForm(customerEmployeeEditPopup, serializeArgs([customerEmployeeEditPopup.cpCustomerEmployeeID]), true);
    //};
    //function customerCancelButton_Click(s, e) {
    //    customerEmployeeEditPopup.Hide();
    //};

    function dosyaYuklemeVazgecButton_Click(s, e)
    {
        dosyaYuklemePopup.Hide();
    }

    function revenueAnalysisCloseButton_Click(s, e) {
        revenueAnalysisPopup.Hide();
    };

    function getViewModeCore(key) {
        return ASPxClientUtils.GetCookie(key);
    };
    function setViewModeCore(key, value) {
        ASPxClientUtils.SetCookie(key, value);
    };
    function showEditMessagePopup(messageTemplate, operation) {
        var message = messageTemplate.replace("<<Operation>>", operation);
        editMessagePopup.SetContentHtml(message);
        editMessagePopup.Show();
    };
    function checkReadOnlyMode() {
        if (window.readOnlyPopup) { // TODO use hiddenField and one popupControl to readOnly and edit message
            readOnlyPopup.Show();
            return true;
        }
        return false;
    };

    function showClearedPopup(popup) {
        popup.Show();
        ASPxClientEdit.ClearEditorsInContainer(document.getElementById("EditFormsContainer"));
    };

    //sağdan açılan edit popup formum
    function showClearedEditPopup(popup) {
        popup.SetWidth(900);
        popup.SetHeight(document.documentElement.clientHeight);
        popup.ShowAtPos(document.documentElement.clientWidth, 0);
        popup.Show();
        ASPxClientEdit.ClearEditorsInContainer(document.getElementById("EditFormsContainer"));
    };

    function getAttribute(element, attrName) {
        if (element.getAttribute)
            return element.getAttribute(attrName);
        else if (element.getProperty)
            return element.getProperty(attrName);
    };

    function saveEditForm(popup, args, isDetail) {
        if (!ASPxClientEdit.ValidateEditorsInContainer(popup.GetMainElement()))
            return;
        popup.Hide();
        if (checkReadOnlyMode())
            return;
        var callbackArgs = ["SaveEditForm", popup.cpEditFormName, args];
        var panel = isDetail ? detailsCallbackPanel : mainCallbackPanel;
        callbackHelper.DoCallback(panel, serializeArgs(callbackArgs), popup);
    };

    //function showPivotGrid() {
    //    revenueAnalysisPopup.SetContentUrl("PivotGrid.aspx");
    //    revenueAnalysisPopup.Show();
    //};

    ////popup olarak aspx sayfası açılıyor.
    //function openReport(reportName, itemID) {
    //    var url = "DocumentViewer.aspx?ReportArgs=" + serializeArgs([reportName, itemID]);
    //    openPageViewerPopup(url, reportName);
    //};
    //function openSpreadsheet(reportName, itemID) {
    //    var url = "Spreadsheet.aspx?ReportArgs=" + serializeArgs([reportName, itemID]);
    //    openPageViewerPopup(url, reportName);
    //};
    //function openPageViewerPopup(contentUrl, reportName) {
    //    pageViewerPopup.SetHeaderText(pageViewerPopup.cpReportDisplayNames[reportName]);
    //    pageViewerPopup.Show();
    //    pageViewerPopup.SetContentUrl(contentUrl);
    //};
    
    var kullaniciTanimlariPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if(isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if(!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if(employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "New":
                    addUser(null, s); // -mcy 13.09.2017
                    break;
                case "Edit":
                    editUser(employeeID, s); //kullaniciEditButton_Click(); // -mcy 13.09.2017
                    break;
                case "Delete":
                    deleteUser(employeeID, s); // -mcy 13.09.2017
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    addUser(null, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editUser(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteUser(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        function addUser(id, sender) { //mcy
            kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
            firstNameTextBox.Focus();
        }
        function editUser(id, sender) { //mcy
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
        }
        function deleteUser(id, sender) { //mcy
            //if (checkReadOnlyMode())
            //    return;
            if (confirm("Seçili kullanıcıyı silmek istediğinizden eminmisiniz? Veritabanındaki bütün kayıtları silinecektir."))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        //function kullaniciEditButton_Click(s, e) {
        //    editUser(s.cpUserKey, s);
        //}

        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };
        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };
        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }
        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }
        //bla bla bla fonksiyonlar bitiş

        return {
            //bla bal bal geri dönüşler başlangıç
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            //EmployeeEditButton_Click: kullaniciEditButton_Click, //detay alanındaki edit butonuymuş
            //EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            //TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
            //bla bal bal geri dönüşler bitiş
        };
    })();
    var cariHesapEkstresiPage = (function () {
        //bla bla bla fonksiyonlar başla
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;

            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };
        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };

        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };
        //bla bla bla fonksiyonlar bitti

        return {
            //bla bal bal geri dönüşler başla
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,

            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
            //bla bal bal geri dönüşler bitti

        };
    })();
    var hedefSatisDurumuPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;

            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };
        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };

        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        return {
            //bla bal bal geri dönüşler başla
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,

            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
            //bla bal bal geri dönüşler bitti

        };
    })();
    var tyAktivasyonAraRaporuPage = (function()
    {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "NewYukle_AktivasyonAraRaporu":
                    NewYukle_HedefSatisDurumu(1001, s); // -mcy
                    break;
                //case "Delete":
                //    deleteEmployee(employeeID, s);
                //    break;
                //case "Meeting":
                //    showEditMessagePopup(editMessagePopup.cpEmployeeEditMessageTemplate, "create new meeting");
                //    break;
                //case "Task":
                //    addTask(employeeID, s);
                //    break;
                case "ExportToSpreadsheet":
                    excelDownload(s, e);
                    break;
                case "ExportToAcrobatReader":
                    pdfDownload(s, e);
                    break;
                    //case "NewUser":
                    //    addUser(); // -mcy 13.09.2017
                    //    break;
                    //case "EditUser":
                    //    editUser(employeeID, s); //kullaniciEditButton_Click(); // -mcy 13.09.2017
                    //    tbPasswordTextBox.SetVisible(false); //koydum ama çalışmıyor. daha sonra devam edicem buna.
                    //    break;
                    //case "DeleteUser":
                    //    addUser(); // -mcy 13.09.2017
                    //    break;
            }
        }

        function excelDownload(s, e) {
            btnExcel.DoClick();
        }
        function pdfDownload(s, e) {
            btnPDF.DoClick();
        }
        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        function addUser() { //mcy
            kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
            showClearedPopup(kullaniciEditPopup);
            firstNameTextBox.Focus();
            parolayiDegistir.SetVisible(false);
        }
        function editUser(id, sender) { //mcy
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
            parolayiDegistir.SetVisible(true);
        }
        function deleteUser(id, sender) { //mcy
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        //function addEmployee() {
        //    //employeeEditPopup.SetHeaderText("New Employee");
        //    //showClearedPopup(employeeEditPopup);
        //    //firstNameTextBox.Focus();

        //    dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
        //    showClearedPopup(dosyaYuklemePopup);
        //    //firstNameTextBox.Focus();
        //} //dosya yükleme popup
        function NewYukle_HedefSatisDurumu() {
            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        }
        //function addEmployeeCustomer() {
        //    customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
        //    showClearedPopup(customerEmployeeEditPopup);
        //    firstNameTextBox.Focus();
        //}
        //function editEmployee(id, sender) { // TODO
        //    showClearedPopup(employeeEditPopup);
        //    callbackHelper.DoCallback(employeeEditPopup, id, sender);
        //}
        //function deleteEmployee(id, sender) {
        //    if (checkReadOnlyMode())
        //        return;
        //    if (confirm("Remove employee?"))
        //        callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        //}

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function editEvaluation(id, sender) {
            showClearedPopup(evaluationEditPopup);
            callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var TYHedefSatisDurumuPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "NewYukle_HedefSatisDurumu":
                    NewYukle_HedefSatisDurumu(1001, s); // -mcy
                    break;
                //case "Delete":
                //    deleteEmployee(employeeID, s);
                //    break;
                //case "Meeting":
                //    showEditMessagePopup(editMessagePopup.cpEmployeeEditMessageTemplate, "create new meeting");
                //    break;
                //case "Task":
                //    addTask(employeeID, s);
                //    break;
                //case "ExportToSpreadsheet":
                //    excelDownload(s, e);
                //    break;
                //case "ExportToAcrobatReader":
                //    pdfDownload(s, e);
                //    break;
            }
        }
        function excelDownload(s, e) {
            btnExcel.DoClick();
        }
        function pdfDownload(s, e) {
            btnPDF.DoClick();
        }
        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }
        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };
        //function addUser() { //mcy
        //    kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
        //    showClearedPopup(kullaniciEditPopup);
        //    firstNameTextBox.Focus();
        //    parolayiDegistir.SetVisible(false);
        //}
        //function editUser(id, sender) { //mcy
        //    showClearedPopup(kullaniciEditPopup);
        //    callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
        //    parolayiDegistir.SetVisible(true);
        //}
        //function deleteUser(id, sender) { //mcy
        //    if (checkReadOnlyMode())
        //        return;
        //    if (confirm("Remove employee?"))
        //        callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        //}
        //function addEmployee() {
        //    //employeeEditPopup.SetHeaderText("New Employee");
        //    //showClearedPopup(employeeEditPopup);
        //    //firstNameTextBox.Focus();
        //    dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
        //    showClearedPopup(dosyaYuklemePopup);
        //    //firstNameTextBox.Focus();
        //} //dosya yükleme popup
        function NewYukle_HedefSatisDurumu()
        {
            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        }
        //function addEmployeeCustomer() {
        //    customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
        //    showClearedPopup(customerEmployeeEditPopup);
        //    firstNameTextBox.Focus();
        //}
        //function editEmployee(id, sender) { // TODO
        //    showClearedPopup(employeeEditPopup);
        //    callbackHelper.DoCallback(employeeEditPopup, id, sender);
        //}
        //function deleteEmployee(id, sender) {
        //    if (checkReadOnlyMode())
        //        return;
        //    if (confirm("Remove employee?"))
        //        callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        //}
        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }
        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }
        //function evaluationGrid_CustomButtonClick(s, e) {
        //    if (e.buttonID === "EvaluationEditBtn")
        //        editEvaluation(s.GetRowKey(e.visibleIndex), s);
        //    if (e.buttonID === "EvaluationDeleteBtn") {
        //        if (checkReadOnlyMode())
        //            return;
        //        if (confirm("Remove Evaluation?")) {
        //            var rowIndex = s.GetFocusedRowIndex();
        //            callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
        //        }
        //    }
        //}
        //function taskGrid_CustomButtonClick(s, e) {
        //    if (e.buttonID === "EditBtn")
        //        editTask(s.GetRowKey(e.visibleIndex), s);
        //    if (e.buttonID === "DeleteBtn") {
        //        if (checkReadOnlyMode())
        //            return;
        //        if (confirm("Remove Task?")) {
        //            var rowIndex = s.GetFocusedRowIndex();
        //            callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
        //        }
        //    }
        //}
        //function editEvaluation(id, sender) {
        //    showClearedPopup(evaluationEditPopup);
        //    callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        //}
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };
        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };
        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }
        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }
        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            //EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            //TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,
            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
               
    //var employeePage = (function () {
    //    function toolbarMenu_ItemClick(s, e) {
    //        var employeeID = getSelectedEmployeeID();
    //        var name = e.item.name;
    //        switch (name) {
    //            case "GridView":
    //                if (isGridViewMode())
    //                    return;
    //                setViewMode(name);
    //                callbackHelper.DoCallback(mainCallbackPanel, "", s);
    //                break;
    //            case "CardsView":
    //                if (!isGridViewMode())
    //                    return;
    //                setViewMode(name);
    //                callbackHelper.DoCallback(mainCallbackPanel, "", s);
    //                break;
    //            case "ColumnsCustomization":
    //                if (employeesGrid.IsCustomizationWindowVisible())
    //                    employeesGrid.HideCustomizationWindow();
    //                else
    //                    employeesGrid.ShowCustomizationWindow(e.htmlElement);
    //                break;
    //            case "NewYukle_HedefSatisDurumu":
    //                NewYukle_HedefSatisDurumu(1001, s); // -mcy
    //                break;
    //            case "Delete":
    //                deleteEmployee(employeeID, s);
    //                break;
    //            case "Meeting":
    //                showEditMessagePopup(editMessagePopup.cpEmployeeEditMessageTemplate, "create new meeting");
    //                break;
    //            case "Task":
    //                addTask(employeeID, s);
    //                break;
    //            case "ExportToSpreadsheet":
    //                excelDownload(s, e);
    //                break;
    //            case "ExportToAcrobatReader":
    //                pdfDownload(s, e);
    //                break;
    //        }
    //    }
    //    function excelDownload(s, e) {
    //        btnExcel.DoClick();
    //    }
    //    function pdfDownload(s, e) {
    //        btnPDF.DoClick();
    //    }
    //    function employeesGrid_Init(s, e) {
    //        setToolbarCWItemEnabled(true);
    //    }
    //    function employeesGrid_FocusedRowChanged(s, e) {
    //        updateDetailInfo(s);
    //    }
    //    function employeesGrid_EndCallback(s, e) {
    //        updateDetailInfo(s); // TODO check this case
    //    }
    //    function employeesGrid_ContextMenuItemClick(s, e) {
    //        switch (e.item.name) {
    //            case "NewRow":
    //                NewYukle_HedefSatisDurumu(1001, s);
    //                e.handled = true;
    //                break;
    //            case "EditRow":
    //                editEmployee(s.GetRowKey(e.elementIndex), s);
    //                e.handled = true;
    //                break;
    //            case "DeleteRow":
    //                deleteEmployee(s.GetRowKey(e.elementIndex), s);
    //                e.handled = true;
    //                break;
    //        }
    //    }
    //    function gridEditButton_Click(e) {
    //        var src = ASPxClientUtils.GetEventSource(e);
    //        //editEmployee(src.id, src);
    //        editUser(src.id, src);
    //    };
    //    function addUser() { //mcy
    //        kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
    //        showClearedPopup(kullaniciEditPopup);
    //        firstNameTextBox.Focus();
    //        parolayiDegistir.SetVisible(false);
    //    }
    //    function editUser(id, sender) { //mcy
    //        showClearedPopup(kullaniciEditPopup);
    //        callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
    //        parolayiDegistir.SetVisible(true);
    //    }
    //    function deleteUser(id, sender) { //mcy
    //        if (checkReadOnlyMode())
    //            return;
    //        if (confirm("Remove employee?"))
    //            callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
    //    }
    //    function addEmployee() {
    //        //employeeEditPopup.SetHeaderText("New Employee");
    //        //showClearedPopup(employeeEditPopup);
    //        //firstNameTextBox.Focus();
    //        dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
    //        showClearedPopup(dosyaYuklemePopup);
    //        //firstNameTextBox.Focus();
    //    } //dosya yükleme popup
    //    function NewYukle_HedefSatisDurumu()
    //    {
    //        dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
    //        showClearedPopup(dosyaYuklemePopup);
    //        callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
    //    }
    //    function addEmployeeCustomer() {
    //        customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
    //        showClearedPopup(customerEmployeeEditPopup);
    //        firstNameTextBox.Focus();
    //    }
    //    function editEmployee(id, sender) { // TODO
    //        showClearedPopup(employeeEditPopup);
    //        callbackHelper.DoCallback(employeeEditPopup, id, sender);
    //    }
    //    function deleteEmployee(id, sender) {
    //        if (checkReadOnlyMode())
    //            return;
    //        if (confirm("Remove employee?"))
    //            callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
    //    }
    //    function employeeEditButton_Click(s, e) {
    //        editEmployee(s.cpEmployeeID, s);
    //    }
    //    function kullaniciEditButton_Click(s, e) {
    //        editUser(s.cpUserKey, s);
    //    }
    //    function evaluationGrid_CustomButtonClick(s, e) {
    //        if (e.buttonID === "EvaluationEditBtn")
    //            editEvaluation(s.GetRowKey(e.visibleIndex), s);
    //        if (e.buttonID === "EvaluationDeleteBtn") {
    //            if (checkReadOnlyMode())
    //                return;
    //            if (confirm("Remove Evaluation?")) {
    //                var rowIndex = s.GetFocusedRowIndex();
    //                callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
    //            }
    //        }
    //    }
    //    function taskGrid_CustomButtonClick(s, e) {
    //        if (e.buttonID === "EditBtn")
    //            editTask(s.GetRowKey(e.visibleIndex), s);
    //        if (e.buttonID === "DeleteBtn") {
    //            if (checkReadOnlyMode())
    //                return;
    //            if (confirm("Remove Task?")) {
    //                var rowIndex = s.GetFocusedRowIndex();
    //                callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
    //            }
    //        }
    //    }
    //    function editEvaluation(id, sender) {
    //        showClearedPopup(evaluationEditPopup);
    //        callbackHelper.DoCallback(evaluationEditPopup, id, sender);
    //    }
    //    function getSelectedEmployeeID() {
    //        var getIndex, getKey;
    //        if (isGridViewMode()) {
    //            getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
    //            getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
    //        } else {
    //            getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
    //            getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
    //        }
    //        if (getIndex() >= 0)
    //            return getKey(getIndex());
    //        return null;
    //    };
    //    function getViewMode() {
    //        return getViewModeCore("EmployeeViewMode");
    //    };
    //    function setViewMode(value) {
    //        setViewModeCore("EmployeeViewMode", value);
    //    };
    //    function isGridViewMode() {
    //        var viewMode = getViewMode();
    //        return !viewMode || viewMode === "GridView";
    //    };
    //    function getSelectedItemID() {
    //        return getSelectedEmployeeID();
    //    }
    //    function getSelectedItemGuid() { // MCY
    //        return getSelectedEmployeeID();
    //    }
    //    return {
    //        ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
    //        EmployeesGrid_Init: employeesGrid_Init,
    //        EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
    //        EmployeesGrid_EndCallback: employeesGrid_EndCallback,
    //        EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
    //        GridEditButton_Click: gridEditButton_Click,
    //        EmployeeEditButton_Click: employeeEditButton_Click,
    //        EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
    //        TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
    //        GetSelectedItemID: getSelectedItemID,
    //        IsGridViewMode: isGridViewMode,
    //        GetSelectedItemGuid: getSelectedItemGuid // MCY
    //    };
    //})();

    //var customerPage = (function () {
    //    function toolbarMenu_ItemClick(s, e) {
    //        switch (e.item.name) {
    //            case "ColumnsCustomization":
    //                if (customerGrid.IsCustomizationWindowVisible())
    //                    customerGrid.HideCustomizationWindow();
    //                else
    //                    customerGrid.ShowCustomizationWindow(e.htmlElement);
    //                break;
    //            case "New":
    //                showEditMessagePopup(editMessagePopup.cpEditMessageTemplate, "insert new customer");
    //                break;
    //            case "Delete":
    //                showEditMessagePopup(editMessagePopup.cpEditMessageTemplate, "delete customer");
    //                break;
    //            case "ShowPivotGrid":
    //                showPivotGrid();
    //                break;
    //        }
    //    }
    //    function gridEditButton_Click(e) {
    //        showEditMessagePopup(editMessagePopup.cpEditMessageTemplate, "edit customer's");
    //    };
    //    function customerGrid_FocusedRowChanged(s, e) {
    //        updateDetailInfo(s);
    //    }
    //    function customerGrid_ContextMenuItemClick(s, e) {
    //        switch (e.item.name) {
    //            case "NewRow":
    //                showEditMessagePopup(editMessagePopup.cpEditMessageTemplate, "insert new customer");
    //                e.handled = true;
    //                break;
    //            case "EditRow":
    //                showEditMessagePopup(editMessagePopup.cpEditMessageTemplate, "edit customer's");
    //                e.handled = true;
    //                break;
    //            case "DeleteRow":
    //                showEditMessagePopup(editMessagePopup.cpEditMessageTemplate, "delete customer");
    //                e.handled = true;
    //                break;
    //        }
    //    }
    //    function customerEmployeeButton_Click(s, e) {
    //        startEditCustomerEmployee(s.cpCustomerEmployeeID, s);
    //    }
    //    function startEditCustomerEmployee(id, sender) {
    //        showClearedPopup(customerEmployeeEditPopup);
    //        callbackHelper.DoCallback(customerEmployeeEditPopup, id, sender);
    //    }
    //    function sliderMenu_ItemClick(s, e) {
    //        if (e.item.name === "Root")
    //            return;
    //        ASPxClientUtils.SetCookie("CustomerImageSliderMode", e.item.name);
    //        updateDetailInfo(s);
    //    }
    //    function getSelectedItemID() {
    //        var rowIndex = customerGrid.GetFocusedRowIndex();
    //        return rowIndex >= 0 ? customerGrid.GetRowKey(rowIndex) : null;
    //    }
    //    return {
    //        ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
    //        GridEditButton_Click: gridEditButton_Click,
    //        CustomerGrid_FocusedRowChanged: customerGrid_FocusedRowChanged,
    //        CustomerGrid_ContextMenuItemClick: customerGrid_ContextMenuItemClick,
    //        CustomerEmployeeButton_Click: customerEmployeeButton_Click,
    //        SliderMenu_ItemClick: sliderMenu_ItemClick,
    //        GetSelectedItemID: getSelectedItemID
    //    };
    //})();

    //var productPage = (function () {
    //    function toolbarMenu_ItemClick(s, e) {
    //        var name = e.item.name;
    //        switch (name) {
    //            case "ColumnsCustomization":
    //                if (productGrid.IsCustomizationWindowVisible())
    //                    productGrid.HideCustomizationWindow();
    //                else
    //                    productGrid.ShowCustomizationWindow(e.htmlElement);
    //                break;
    //            case "New":
    //                showEditMessagePopup(editMessagePopup.cpEditMessageTemplate, "insert new product");
    //                break;
    //            case "Delete":
    //                showEditMessagePopup(editMessagePopup.cpEditMessageTemplate, "delete product");
    //                break;
    //            case "ShowPivotGrid":
    //                showPivotGrid();
    //                break;
    //        }     
    //    }
    //    function productGrid_FocusedRowChanged(s, e) {
    //        updateDetailInfo(s);
    //    }
    //    function productGrid_ContextMenuItemClick(s, e) {
    //        switch (e.item.name) {
    //            case "NewRow":
    //                showEditMessagePopup(editMessagePopup.cpEditMessageTemplate, "insert new product");
    //                e.handled = true;
    //                break;
    //            case "EditRow":
    //                showEditMessagePopup(editMessagePopup.cpEditMessageTemplate, "edit product");
    //                e.handled = true;
    //                break;
    //            case "DeleteRow":
    //                showEditMessagePopup(editMessagePopup.cpEditMessageTemplate, "delete product");
    //                e.handled = true;
    //                break;
    //        }
    //    }
    //    function productImageSlider_ThumbnailItemClick(s, e) {
    //        callbackHelper.DoCallback(productPopup, s.GetActiveItemIndex(), s);
    //        productPopup.Show();
    //    }
    //    function productImageUpload_FileUploadStart(s, e) {
    //        e.cancel = checkReadOnlyMode();
    //    }
    //    function productImageUpload_FileUploadComplete(s, e) {
    //        updateDetailInfo(s);
    //    }
    //    function productUploadButton_Click(s, e) {
    //        productImageUpload.Upload();
    //    }
    //    function getSelectedItemID() {
    //        var rowIndex = productGrid.GetFocusedRowIndex();
    //        return rowIndex >= 0 ? productGrid.GetRowKey(rowIndex) : null;
    //    }
    //    return {
    //        ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
    //        ProductGrid_FocusedRowChanged: productGrid_FocusedRowChanged,
    //        ProductGrid_ContextMenuItemClick: productGrid_ContextMenuItemClick,
    //        ProductImageSlider_ThumbnailItemClick: productImageSlider_ThumbnailItemClick,
    //        ProductImageUpload_FileUploadStart: productImageUpload_FileUploadStart,
    //        ProductImageUpload_FileUploadComplete: productImageUpload_FileUploadComplete,
    //        ProductUploadButton_Click: productUploadButton_Click,
    //        GetSelectedItemID: getSelectedItemID
    //    };
    //})();

    //var taskPage = (function () {
    //    function toolbarMenu_ItemClick(s, e) {
    //        var name = e.item.name;
    //        switch (name) {
    //            case "GridView":
    //                if (isGridViewMode())
    //                    return;
    //                setViewMode("GridView");
    //                callbackHelper.DoCallback(mainCallbackPanel, "", s);
    //                break;
    //            case "CardsView":
    //                if (!isGridViewMode())
    //                    return;
    //                setViewMode("CardsView");
    //                callbackHelper.DoCallback(mainCallbackPanel, "", s);
    //                break;
    //            case "New":
    //                taskEditPopup.SetHeaderText("New Task");
    //                addTask("", s);
    //                break;
    //        }
    //    }
    //    function taskGrid_CustomButtonClick(s, e) {
    //        switch (e.buttonID) {
    //            case "EditBtn":
    //                editTask(s.GetRowKey(e.visibleIndex), s);
    //                break;
    //            case "DeleteBtn":
    //                deleteTask(s.GetRowKey(e.visibleIndex), s);
    //                break;
    //        }
    //    }
    //    function tasksGrid_ContextMenuItemClick(s, e) {
    //        switch (e.item.name) {
    //            case "NewRow":
    //                addTask("", s);
    //                e.handled = true;
    //                break;
    //            case "EditRow":
    //                editTask(s.GetRowKey(e.elementIndex), s);
    //                e.handled = true;
    //                break;
    //            case "DeleteRow":
    //                deleteTask(s.GetRowKey(e.elementIndex), s);
    //                e.handled = true;
    //                break;
    //        }
    //    }
    //    function viewButton_Click(s, e) {
    //        performTaskCommand("Show", s.cpTaskID, s);
    //    }
    //    function editButton_Click(s, e) {
    //        editTask(s.cpTaskID, s);
    //    }
    //    function deleteButton_Click(s, e) {
    //        deleteTask(s.cpTaskID, s);
    //    }
    //    function getViewMode() {
    //        return getViewModeCore("TaskViewMode");
    //    }
    //    function setViewMode(value) {
    //        setViewModeCore("TaskViewMode", value);
    //    }
    //    function isGridViewMode() {
    //        var viewMode = getViewMode();
    //        return !viewMode || viewMode === "GridView";
    //    }
    //    return {
    //        ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
    //        TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
    //        TasksGrid_ContextMenuItemClick: tasksGrid_ContextMenuItemClick,
    //        ViewButton_Click: viewButton_Click,
    //        EditButton_Click: editButton_Click,
    //        DeleteButton_Click: deleteButton_Click,
    //        IsGridViewMode: isGridViewMode
    //    };
    //})();

    var widgetsPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var name = e.item.name;
            switch (e.item.name) {
                case "DateTime":
                case "Calendar":
                case "Mail":
                case "Weather":
                case "Trading":
                case "News":
                case "Slider":
                case "Urun":
                    var panel = dockManager.GetPanelByUID(e.item.name);
                    if (e.item.GetChecked())
                        panel.Show()
                    else
                        panel.Hide();
            }
            //switch (name) {
            //    case "Slider":
            //        var panel = dockManager.GetPanelByUID(e.item.name);
            //        if (e.item.GetChecked())
            //            panel.HideCustomizationWindow();
            //        else
            //            employeesGrid.ShowCustomizationWindow(e.htmlElement);
            //        break;
            //}
        }

        function sliderPanel_CloseUp(s, e) {
            uncheckToolbarMenuItem(s.panelUID);
        }
        function dateTime_CloseUp(s, e) {
            uncheckToolbarMenuItem(s.panelUID);
        }
        function calendar_CloseUp(s, e) {
            uncheckToolbarMenuItem(s.panelUID);
        }
        function mail_CloseUp(s, e) {
            uncheckToolbarMenuItem(s.panelUID);
        }
        function weather_CloseUp(s, e) {
            uncheckToolbarMenuItem(s.panelUID);
        }
        function trading_CloseUp(s, e) {
            uncheckToolbarMenuItem(s.panelUID);
        }
        function news_CloseUp(s, e) {
            uncheckToolbarMenuItem(s.panelUID);
        }
        function urunPanel_CloseUp(s, e) {
            uncheckToolbarMenuItem(s.panelUID);
        }

        function acilisMesajiPopup_CloseUp(s, e) {
            acilisDuyurusuOkundu.PerformCallback();
        }

        function uncheckToolbarMenuItem(itemName) {
            toolbarMenu.GetItemByName(itemName).SetChecked(false);
        }

        function dockManager_Init(s, e) {
            //revenueChart.GetMainElement().style.width = "100%"; // TODO check this case
            //opportunitiesChart.GetMainElement().style.width = "100%";
            //tileLayoutHelper.DockManager_Init(s, e);
        };
        function dockManager_StartPanelDragging(s, e) {
            tileLayoutHelper.DockManager_StartPanelDragging(s, e);
        }
        function dockManager_EndPanelDragging(s, e) {
            tileLayoutHelper.DockManager_EndPanelDragging(s, e);
        }
        function dockManager_AfterDock(s, e) {
            tileLayoutHelper.DockManager_AfterDock(s, e);
        }
        function dockManager_PanelCloseUp(s, e) {
            tileLayoutHelper.DockManager_PanelCloseUp(s, e);
        }

        var tileLayoutHelper = (function () {
            var zones = [];
            var zoneDimensionsCache = [];
            var draggingPanel;

            function dockManager_Init(s, e) {
                zones = dockManager.GetZones();
                adjustPanes();
                ASPxClientControl.GetControlCollection().BrowserWindowResized.AddHandler(onWindowResize);
            }
            function dockManager_StartPanelDragging(s, e) {
                draggingPanel = e.panel;
                ASPxClientUtils.AttachEventToElement(document, "mousemove", onMouseMove);
            }
            function dockManager_EndPanelDragging(s, e) {
                if (!e.panel.GetOwnerZone())
                    dockPanelToVacantZone(e.panel);
                ASPxClientUtils.DetachEventFromElement(document, "mousemove", onMouseMove);
                draggingPanel = null;
            }
            function dockManager_AfterDock(s, e) {
                var zone = e.panel.GetOwnerZone();
                if (zone.GetPanelCount() > 1) {
                    dockPanelToVacantZone(zone.GetPanels()[0]);
                    zone.GetMainElement().style.height = e.panel.GetMainElement().offsetHeight + "px";
                }
                adjustPanes();
                adjustTopDockZone();
            }
            function dockManager_PanelCloseUp(s, e) {
                adjustTopDockZone();
            }

            function adjustTopDockZone() {
                //var zone = dockManager.GetZoneByUID("Sutun1");
                //if (!zone.GetPanelByVisibleIndex(0).GetVisible())
                //    zone.GetMainElement().style.height = "1px";
            }
            function onWindowResize() {
                window.clearTimeout(updateTimerID);
                updateTimerID = window.setTimeout(adjustPanes, updateTimeout);
            }
            function adjustPanes() {
                window.clearTimeout(updateTimerID);
                //adjustChartSize(revenueChart);
                //adjustChartSize(opportunitiesChart);
                updateZoneDimensionsCache();
            }
            function adjustChartSize(chart) {
                var mainElement = chart.GetMainElement();
                var img = mainElement.getElementsByTagName("IMG")[0];
                var chartWidth = mainElement.offsetWidth;
                var imgWidth = img.offsetWidth;
                if (imgWidth < chartWidth && imgWidth < 500 || imgWidth > chartWidth)
                    callbackHelper.DoCallback(chart, chartWidth, chart);
            };
            function onMouseMove(e) {
                var zone = getZoneUnderCursor(e);
                if (!zone || !draggingPanel)
                    return;
                var zonePanel = zone.GetPanelCount() > 0 && zone.GetPanels()[0];
                if (!zonePanel || zonePanel.panelUID === draggingPanel.panelUID)
                    return;
                dockPanelToVacantZone(zonePanel, zone);
                zone.ShowPanelPlaceholder(draggingPanel);
            }

            function dockPanelToVacantZone(panel, overredZone) {
                var vacantZone = getVacantZone(overredZone);
                panel.Dock(vacantZone);
                panel.GetMainElement().style.width = panel.GetMainElement().parentNode.offsetWidth;
            };
            function getZoneUnderCursor(e) {
                var evtX = ASPxClientUtils.GetEventX(e),
                    evtY = ASPxClientUtils.GetEventY(e);
                for (var i = 0; i < zoneDimensionsCache.length; i++) {
                    var zd = zoneDimensionsCache[i];
                    if (evtX > zd.x && evtX < zd.x + zd.w && evtY > zd.y && evtY < zd.y + zd.h)
                        return dockManager.GetZoneByUID(zd.zoneUID);
                }
                return null;
            };
            function getVacantZone(excludeZone) {
                for (var i = 0; i < zones.length; i++) {
                    var isExcludedZone = excludeZone && (zones[i].zoneUID === excludeZone.zoneUID);
                    if (!isExcludedZone && zones[i].GetPanelCount() === 0)
                        return zones[i];
                }
            };
            function updateZoneDimensionsCache() {
                zoneDimensionsCache = [];
                for (var i = 0; i < zones.length; i++) {
                    var zoneElem = zones[i].GetMainElement();
                    zoneDimensionsCache.push({
                        zoneUID: zones[i].zoneUID,
                        x: ASPxClientUtils.GetAbsoluteX(zoneElem),
                        y: ASPxClientUtils.GetAbsoluteY(zoneElem),
                        w: zones[i].GetWidth(),
                        h: zones[i].GetHeight()
                    });
                }
            };
            return {
                DockManager_Init: dockManager_Init,
                DockManager_StartPanelDragging: dockManager_StartPanelDragging,
                DockManager_EndPanelDragging: dockManager_EndPanelDragging,
                DockManager_AfterDock: dockManager_AfterDock,
                DockManager_PanelCloseUp: dockManager_PanelCloseUp
            };
        })();
        return {
            DockManager_Init: dockManager_Init,
            DockManager_StartPanelDragging: dockManager_StartPanelDragging,
            DockManager_EndPanelDragging: dockManager_EndPanelDragging,
            DockManager_AfterDock: dockManager_AfterDock,
            DockManager_PanelCloseUp: dockManager_PanelCloseUp,
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            SliderPanel_CloseUp: sliderPanel_CloseUp,
            DateTime_CloseUp: dateTime_CloseUp,
            Calendar_CloseUp: calendar_CloseUp,
            Mail_CloseUp: mail_CloseUp,
            Weather_CloseUp: weather_CloseUp,
            Trading_CloseUp: trading_CloseUp,
            News_CloseUp: news_CloseUp,
            UrunPanel_CloseUp: urunPanel_CloseUp,
            AcilisMesajiPopup_CloseUp: acilisMesajiPopup_CloseUp
        };
    })();
    var TYDuyurularPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                //case "New":
                //    addUser(); // -mcy 13.09.2017
                //    break;
                //case "Edit":
                //    editUser(employeeID, s); //kullaniciEditButton_Click(); // -mcy 13.09.2017
                //    break;
                //case "Delete":
                //    deleteUser(employeeID, s); // -mcy 13.09.2017
                //    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            //switch (e.item.name) {
            //    case "NewRow":
            //        addUser();
            //        e.handled = true;
            //        break;
            //    case "EditRow":
            //        editUser(s.GetRowKey(e.elementIndex), s);
            //        e.handled = true;
            //        break;
            //    case "DeleteRow":
            //        deleteUser(s.GetRowKey(e.elementIndex), s);
            //        e.handled = true;
            //        break;
            //}
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        //function addUser() { //mcy
        //    kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
        //    showClearedPopup(kullaniciEditPopup);
        //    firstNameTextBox.Focus();
        //}
        //function editUser(id, sender) { //mcy
        //    showClearedPopup(kullaniciEditPopup);
        //    callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
        //}
        //function deleteUser(id, sender) { //mcy
        //    //if (checkReadOnlyMode())
        //    //    return;
        //    if (confirm("Seçili kullanıcıyı silmek istediğinizden eminmisiniz? Veritabanındaki bütün kayıtları silinecektir."))
        //        callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        //}

        //function kullaniciEditButton_Click(s, e) {
        //    editUser(s.cpUserKey, s);
        //}

        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };
        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };
        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }
        //function getSelectedItemGuid() { // MCY
        //    return getSelectedEmployeeID();
        //}
        //bla bla bla fonksiyonlar bitiş

         
        return {
            //bla bal bal geri dönüşler başlangıç
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            //EmployeeEditButton_Click: kullaniciEditButton_Click, //detay alanındaki edit butonuymuş
            //EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            //TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            //GetSelectedItemGuid: getSelectedItemGuid // MCY
            //bla bal bal geri dönüşler bitiş 
        };
    })();
    var cihazAktivasyonAraRaporuPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "NewYukle_AktivasyonAraRaporu":
                    NewYukle_HedefSatisDurumu(1001, s); // -mcy
                    break;
                case "Delete":
                    deleteEmployee(employeeID, s);
                    break;
                case "Meeting":
                    showEditMessagePopup(editMessagePopup.cpEmployeeEditMessageTemplate, "create new meeting");
                    break;
                case "Task":
                    addTask(employeeID, s);
                    break;
                    //case "NewUser":
                    //    addUser(); // -mcy 13.09.2017
                    //    break;
                    //case "EditUser":
                    //    editUser(employeeID, s); //kullaniciEditButton_Click(); // -mcy 13.09.2017
                    //    tbPasswordTextBox.SetVisible(false); //koydum ama çalışmıyor. daha sonra devam edicem buna.
                    //    break;
                    //case "DeleteUser":
                    //    addUser(); // -mcy 13.09.2017
                    //    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        function addUser() { //mcy
            kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
            showClearedPopup(kullaniciEditPopup);
            firstNameTextBox.Focus();
            parolayiDegistir.SetVisible(false);
        }
        function editUser(id, sender) { //mcy
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
            parolayiDegistir.SetVisible(true);
        }
        function deleteUser(id, sender) { //mcy
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function addEmployee() {
            //employeeEditPopup.SetHeaderText("New Employee");
            //showClearedPopup(employeeEditPopup);
            //firstNameTextBox.Focus();

            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            //firstNameTextBox.Focus();
        } //dosya yükleme popup
        function NewYukle_HedefSatisDurumu() {
            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        }
        function addEmployeeCustomer() {
            customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
            showClearedPopup(customerEmployeeEditPopup);
            firstNameTextBox.Focus();
        }
        function editEmployee(id, sender) { // TODO
            showClearedPopup(employeeEditPopup);
            callbackHelper.DoCallback(employeeEditPopup, id, sender);
        }
        function deleteEmployee(id, sender) {
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function editEvaluation(id, sender) {
            showClearedPopup(evaluationEditPopup);
            callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var tyCihazTemlikRaporuPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "NewYukle_TemlikRaporu":
                    NewYukle_HedefSatisDurumu(1001, s); // -mcy
                    break;
                case "Delete":
                    deleteEmployee(employeeID, s);
                    break;
                case "Meeting":
                    showEditMessagePopup(editMessagePopup.cpEmployeeEditMessageTemplate, "create new meeting");
                    break;
                case "Task":
                    addTask(employeeID, s);
                    break;
                case "ExportToSpreadsheet":
                    excelDownload(s, e);
                    break;
                case "ExportToAcrobatReader":
                    pdfDownload(s, e);
                    break;
            }
        }

        function excelDownload(s, e) {
            btnExcel.DoClick();
        }
        function pdfDownload(s, e) {
            btnPDF.DoClick();
        }
        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        function addUser() { //mcy
            kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
            showClearedPopup(kullaniciEditPopup);
            firstNameTextBox.Focus();
            parolayiDegistir.SetVisible(false);
        }
        function editUser(id, sender) { //mcy
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
            parolayiDegistir.SetVisible(true);
        }
        function deleteUser(id, sender) { //mcy
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function addEmployee() {
            //employeeEditPopup.SetHeaderText("New Employee");
            //showClearedPopup(employeeEditPopup);
            //firstNameTextBox.Focus();

            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            //firstNameTextBox.Focus();
        } //dosya yükleme popup
        function NewYukle_HedefSatisDurumu() {
            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        }
        function addEmployeeCustomer() {
            customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
            showClearedPopup(customerEmployeeEditPopup);
            firstNameTextBox.Focus();
        }
        function editEmployee(id, sender) { // TODO
            showClearedPopup(employeeEditPopup);
            callbackHelper.DoCallback(employeeEditPopup, id, sender);
        }
        function deleteEmployee(id, sender) {
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function editEvaluation(id, sender) {
            showClearedPopup(evaluationEditPopup);
            callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var cihazTemlikRaporuPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "NewYukle_AktivasyonAraRaporu":
                    NewYukle_HedefSatisDurumu(1001, s); // -mcy
                    break;
                case "Delete":
                    deleteEmployee(employeeID, s);
                    break;
                case "Meeting":
                    showEditMessagePopup(editMessagePopup.cpEmployeeEditMessageTemplate, "create new meeting");
                    break;
                case "Task":
                    addTask(employeeID, s);
                    break;
                case "ExportToSpreadsheet":
                    excelDownload(s, e);
                    break;
                case "ExportToAcrobatReader":
                    pdfDownload(s, e);
                    break;
            }
        }
        function excelDownload(s, e) {
            btnExcel.DoClick();
        }
        function pdfDownload(s, e) {
            btnPDF.DoClick();
        }
        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        function addUser() { //mcy
            kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
            showClearedPopup(kullaniciEditPopup);
            firstNameTextBox.Focus();
            parolayiDegistir.SetVisible(false);
        }
        function editUser(id, sender) { //mcy
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
            parolayiDegistir.SetVisible(true);
        }
        function deleteUser(id, sender) { //mcy
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function addEmployee() {
            //employeeEditPopup.SetHeaderText("New Employee");
            //showClearedPopup(employeeEditPopup);
            //firstNameTextBox.Focus();

            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            //firstNameTextBox.Focus();
        } //dosya yükleme popup
        function NewYukle_HedefSatisDurumu() {
            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        }
        function addEmployeeCustomer() {
            customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
            showClearedPopup(customerEmployeeEditPopup);
            firstNameTextBox.Focus();
        }
        function editEmployee(id, sender) { // TODO
            showClearedPopup(employeeEditPopup);
            callbackHelper.DoCallback(employeeEditPopup, id, sender);
        }
        function deleteEmployee(id, sender) {
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function editEvaluation(id, sender) {
            showClearedPopup(evaluationEditPopup);
            callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var tyPrimHakedisRaporuPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "NewYukle_PrimHakedis":
                    NewYukle_PrimHakedis(1001, s); // -mcy
                    break;
                case "Delete":
                    deleteEmployee(employeeID, s);
                    break;
                case "Meeting":
                    showEditMessagePopup(editMessagePopup.cpEmployeeEditMessageTemplate, "create new meeting");
                    break;
                case "Task":
                    addTask(employeeID, s);
                    break;
                case "ExportToSpreadsheet":
                    excelDownload(s, e);
                    break;
                case "ExportToAcrobatReader":
                    pdfDownload(s, e);
                    break;
            }
        }

        function excelDownload(s, e) {
            btnExcel.DoClick();
        }
        function pdfDownload(s, e) {
            btnPDF.DoClick();
        }
        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        function addUser() { //mcy
            kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
            showClearedPopup(kullaniciEditPopup);
            firstNameTextBox.Focus();
            parolayiDegistir.SetVisible(false);
        }
        function editUser(id, sender) { //mcy
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
            parolayiDegistir.SetVisible(true);
        }
        function deleteUser(id, sender) { //mcy
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function addEmployee() {
            //employeeEditPopup.SetHeaderText("New Employee");
            //showClearedPopup(employeeEditPopup);
            //firstNameTextBox.Focus();

            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            //firstNameTextBox.Focus();
        } //dosya yükleme popup
        function NewYukle_PrimHakedis() {
            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        }
        function addEmployeeCustomer() {
            customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
            showClearedPopup(customerEmployeeEditPopup);
            firstNameTextBox.Focus();
        }
        function editEmployee(id, sender) { // TODO
            showClearedPopup(employeeEditPopup);
            callbackHelper.DoCallback(employeeEditPopup, id, sender);
        }
        function deleteEmployee(id, sender) {
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function editEvaluation(id, sender) {
            showClearedPopup(evaluationEditPopup);
            callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var primHakedisRaporuPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        function addUser() { //mcy
            kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
            showClearedPopup(kullaniciEditPopup);
            firstNameTextBox.Focus();
            parolayiDegistir.SetVisible(false);
        }
        function editUser(id, sender) { //mcy
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
            parolayiDegistir.SetVisible(true);
        }
        function deleteUser(id, sender) { //mcy
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function addEmployee() {
            //employeeEditPopup.SetHeaderText("New Employee");
            //showClearedPopup(employeeEditPopup);
            //firstNameTextBox.Focus();

            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            //firstNameTextBox.Focus();
        } //dosya yükleme popup
        function NewYukle_HedefSatisDurumu() {
            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        }
        function addEmployeeCustomer() {
            customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
            showClearedPopup(customerEmployeeEditPopup);
            firstNameTextBox.Focus();
        }
        function editEmployee(id, sender) { // TODO
            showClearedPopup(employeeEditPopup);
            callbackHelper.DoCallback(employeeEditPopup, id, sender);
        }
        function deleteEmployee(id, sender) {
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function editEvaluation(id, sender) {
            showClearedPopup(evaluationEditPopup);
            callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var TYAlSatKarlilikPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "NewYukle_AlSatKarlilik":
                    NewYukle_AlSatKarlilik(1001, s); // -mcy
                    break;
                case "Delete":
                    deleteEmployee(employeeID, s);
                    break;
                case "Meeting":
                    showEditMessagePopup(editMessagePopup.cpEmployeeEditMessageTemplate, "create new meeting");
                    break;
                case "Task":
                    addTask(employeeID, s);
                    break;
                case "ExportToSpreadsheet":
                    excelDownload(s, e);
                    break;
                case "ExportToAcrobatReader":
                    pdfDownload(s, e);
                    break;
            }
        }

        function excelDownload(s, e) {
            btnExcel.DoClick();
        }
        function pdfDownload(s, e) {
            btnPDF.DoClick();
        }
        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        function addUser() { //mcy
            kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
            showClearedPopup(kullaniciEditPopup);
            firstNameTextBox.Focus();
            parolayiDegistir.SetVisible(false);
        }
        function editUser(id, sender) { //mcy
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
            parolayiDegistir.SetVisible(true);
        }
        function deleteUser(id, sender) { //mcy
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function addEmployee() {
            //employeeEditPopup.SetHeaderText("New Employee");
            //showClearedPopup(employeeEditPopup);
            //firstNameTextBox.Focus();

            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            //firstNameTextBox.Focus();
        } //dosya yükleme popup
        function NewYukle_AlSatKarlilik() {
            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        }
        function addEmployeeCustomer() {
            customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
            showClearedPopup(customerEmployeeEditPopup);
            firstNameTextBox.Focus();
        }
        function editEmployee(id, sender) { // TODO
            showClearedPopup(employeeEditPopup);
            callbackHelper.DoCallback(employeeEditPopup, id, sender);
        }
        function deleteEmployee(id, sender) {
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function editEvaluation(id, sender) {
            showClearedPopup(evaluationEditPopup);
            callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var AlSatKarlilikPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        function addUser() { //mcy
            kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
            showClearedPopup(kullaniciEditPopup);
            firstNameTextBox.Focus();
            parolayiDegistir.SetVisible(false);
        }
        function editUser(id, sender) { //mcy
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
            parolayiDegistir.SetVisible(true);
        }
        function deleteUser(id, sender) { //mcy
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function addEmployee() {
            //employeeEditPopup.SetHeaderText("New Employee");
            //showClearedPopup(employeeEditPopup);
            //firstNameTextBox.Focus();

            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            //firstNameTextBox.Focus();
        } //dosya yükleme popup
        function NewYukle_HedefSatisDurumu() {
            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        }
        function addEmployeeCustomer() {
            customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
            showClearedPopup(customerEmployeeEditPopup);
            firstNameTextBox.Focus();
        }
        function editEmployee(id, sender) { // TODO
            showClearedPopup(employeeEditPopup);
            callbackHelper.DoCallback(employeeEditPopup, id, sender);
        }
        function deleteEmployee(id, sender) {
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function editEvaluation(id, sender) {
            showClearedPopup(evaluationEditPopup);
            callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var RaporEnvanterPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        function addUser() { //mcy
            kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
            showClearedPopup(kullaniciEditPopup);
            firstNameTextBox.Focus();
            parolayiDegistir.SetVisible(false);
        }
        function editUser(id, sender) { //mcy
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
            parolayiDegistir.SetVisible(true);
        }
        function deleteUser(id, sender) { //mcy
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function addEmployee() {
            //employeeEditPopup.SetHeaderText("New Employee");
            //showClearedPopup(employeeEditPopup);
            //firstNameTextBox.Focus();

            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            //firstNameTextBox.Focus();
        } //dosya yükleme popup
        function NewYukle_HedefSatisDurumu() {
            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        }
        function addEmployeeCustomer() {
            customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
            showClearedPopup(customerEmployeeEditPopup);
            firstNameTextBox.Focus();
        }
        function editEmployee(id, sender) { // TODO
            showClearedPopup(employeeEditPopup);
            callbackHelper.DoCallback(employeeEditPopup, id, sender);
        }
        function deleteEmployee(id, sender) {
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function editEvaluation(id, sender) {
            showClearedPopup(evaluationEditPopup);
            callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var RaporKarPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        function addUser() { //mcy
            kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
            showClearedPopup(kullaniciEditPopup);
            firstNameTextBox.Focus();
            parolayiDegistir.SetVisible(false);
        }
        function editUser(id, sender) { //mcy
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
            parolayiDegistir.SetVisible(true);
        }
        function deleteUser(id, sender) { //mcy
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function addEmployee() {
            //employeeEditPopup.SetHeaderText("New Employee");
            //showClearedPopup(employeeEditPopup);
            //firstNameTextBox.Focus();

            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            //firstNameTextBox.Focus();
        } //dosya yükleme popup
        function NewYukle_HedefSatisDurumu() {
            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        }
        function addEmployeeCustomer() {
            customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
            showClearedPopup(customerEmployeeEditPopup);
            firstNameTextBox.Focus();
        }
        function editEmployee(id, sender) { // TODO
            showClearedPopup(employeeEditPopup);
            callbackHelper.DoCallback(employeeEditPopup, id, sender);
        }
        function deleteEmployee(id, sender) {
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function editEvaluation(id, sender) {
            showClearedPopup(evaluationEditPopup);
            callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var RaporFaturaPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        function addUser() { //mcy
            kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
            showClearedPopup(kullaniciEditPopup);
            firstNameTextBox.Focus();
            parolayiDegistir.SetVisible(false);
        }
        function editUser(id, sender) { //mcy
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
            parolayiDegistir.SetVisible(true);
        }
        function deleteUser(id, sender) { //mcy
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function addEmployee() {
            //employeeEditPopup.SetHeaderText("New Employee");
            //showClearedPopup(employeeEditPopup);
            //firstNameTextBox.Focus();

            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            //firstNameTextBox.Focus();
        } //dosya yükleme popup
        function NewYukle_HedefSatisDurumu() {
            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        }
        function addEmployeeCustomer() {
            customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
            showClearedPopup(customerEmployeeEditPopup);
            firstNameTextBox.Focus();
        }
        function editEmployee(id, sender) { // TODO
            showClearedPopup(employeeEditPopup);
            callbackHelper.DoCallback(employeeEditPopup, id, sender);
        }
        function deleteEmployee(id, sender) {
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function editEvaluation(id, sender) {
            showClearedPopup(evaluationEditPopup);
            callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var RaporMalzemeSonAlimMaliyetiPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        function addUser() { //mcy
            kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
            showClearedPopup(kullaniciEditPopup);
            firstNameTextBox.Focus();
            parolayiDegistir.SetVisible(false);
        }
        function editUser(id, sender) { //mcy
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
            parolayiDegistir.SetVisible(true);
        }
        function deleteUser(id, sender) { //mcy
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function addEmployee() {
            //employeeEditPopup.SetHeaderText("New Employee");
            //showClearedPopup(employeeEditPopup);
            //firstNameTextBox.Focus();

            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            //firstNameTextBox.Focus();
        } //dosya yükleme popup
        function NewYukle_HedefSatisDurumu() {
            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        }
        function addEmployeeCustomer() {
            customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
            showClearedPopup(customerEmployeeEditPopup);
            firstNameTextBox.Focus();
        }
        function editEmployee(id, sender) { // TODO
            showClearedPopup(employeeEditPopup);
            callbackHelper.DoCallback(employeeEditPopup, id, sender);
        }
        function deleteEmployee(id, sender) {
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function editEvaluation(id, sender) {
            showClearedPopup(evaluationEditPopup);
            callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var RaporGenelDurumPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        function addUser() { //mcy
            kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
            showClearedPopup(kullaniciEditPopup);
            firstNameTextBox.Focus();
            parolayiDegistir.SetVisible(false);
        }
        function editUser(id, sender) { //mcy
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
            parolayiDegistir.SetVisible(true);
        }
        function deleteUser(id, sender) { //mcy
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function addEmployee() {
            //employeeEditPopup.SetHeaderText("New Employee");
            //showClearedPopup(employeeEditPopup);
            //firstNameTextBox.Focus();

            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            //firstNameTextBox.Focus();
        } //dosya yükleme popup
        function NewYukle_HedefSatisDurumu() {
            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        }
        function addEmployeeCustomer() {
            customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
            showClearedPopup(customerEmployeeEditPopup);
            firstNameTextBox.Focus();
        }
        function editEmployee(id, sender) { // TODO
            showClearedPopup(employeeEditPopup);
            callbackHelper.DoCallback(employeeEditPopup, id, sender);
        }
        function deleteEmployee(id, sender) {
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function editEvaluation(id, sender) {
            showClearedPopup(evaluationEditPopup);
            callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var dashboardPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;

        }

      

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,

        };
    })();
    var BayiTanimlariPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "New":
                    addBayi(null, s);
                    break;
                case "Edit":
                    editBayi(employeeID, s);
                    break;
                case "Delete":
                    deleteBayi(employeeID, s);
                    break;
                case "NewVeKullanici":
                    addBayi(null, s);
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    addBayi(null, s);
                    e.handled = true;
                    break;
                //case "NewRow":
                //    NewYukle_HedefSatisDurumu(1001, s);
                //    e.handled = true;
                //    break;
                case "EditRow":
                    editBayi(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteBayi(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            editUser(src.id, src);
        };

        function addBayi(id, sender) {
            bayiEditPopup.SetHeaderText("Yeni Bayi Oluştur");
            showClearedPopup(bayiEditPopup);
            //alert(id + ':' + sender);
            callbackHelper.DoCallback(bayiEditPopup, id, sender);
            bayiKoduTextBox.Focus();
        } 
        function editBayi(id, sender) { // TODO
            showClearedPopup(bayiEditPopup);
            callbackHelper.DoCallback(bayiEditPopup, id, sender);
        }
        function deleteBayi(id, sender) {
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function editEvaluation(id, sender) {
            showClearedPopup(evaluationEditPopup);
            callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            //EmployeeEditButton_Click: employeeEditButton_Click,
            //EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            //TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode
        };
    })();
    var CariTakipPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "NewYukle_CariTakip":
                    NewYukle_HedefSatisDurumu(1001, s); // -mcy
                    break;
                case "Delete":
                    deleteEmployee(employeeID, s);
                    break;
                case "Meeting":
                    showEditMessagePopup(editMessagePopup.cpEmployeeEditMessageTemplate, "create new meeting");
                    break;
                case "Task":
                    addTask(employeeID, s);
                    break;
                    //case "NewUser":
                    //    addUser(); // -mcy 13.09.2017
                    //    break;
                    //case "EditUser":
                    //    editUser(employeeID, s); //kullaniciEditButton_Click(); // -mcy 13.09.2017
                    //    tbPasswordTextBox.SetVisible(false); //koydum ama çalışmıyor. daha sonra devam edicem buna.
                    //    break;
                    //case "DeleteUser":
                    //    addUser(); // -mcy 13.09.2017
                    //    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            editUser(src.id, src);
        };

        function addUser() { //mcy
            kullaniciEditPopup.SetHeaderText("Yeni Kullanıcı Oluştur");
            showClearedPopup(kullaniciEditPopup);
            firstNameTextBox.Focus();
            parolayiDegistir.SetVisible(false);
        }
        function editUser(id, sender) { //mcy
            showClearedPopup(kullaniciEditPopup);
            callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
            parolayiDegistir.SetVisible(true);
        }
        function deleteUser(id, sender) { //mcy
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function addEmployee() {
            //employeeEditPopup.SetHeaderText("New Employee");
            //showClearedPopup(employeeEditPopup);
            //firstNameTextBox.Focus();

            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            //firstNameTextBox.Focus();
        } //dosya yükleme popup
        function NewYukle_HedefSatisDurumu() {
            dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
            showClearedPopup(dosyaYuklemePopup);
            callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        }
        function addEmployeeCustomer() {
            customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
            showClearedPopup(customerEmployeeEditPopup);
            firstNameTextBox.Focus();
        }
        function editEmployee(id, sender) { // TODO
            showClearedPopup(employeeEditPopup);
            callbackHelper.DoCallback(employeeEditPopup, id, sender);
        }
        function deleteEmployee(id, sender) {
            if (checkReadOnlyMode())
                return;
            if (confirm("Remove employee?"))
                callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        }

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function editEvaluation(id, sender) {
            showClearedPopup(evaluationEditPopup);
            callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        }
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var TYDokumanPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
               
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {

        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            showClearedPopup(pdfViewerPopup);
            callbackHelper.DoCallback(pdfViewerPopup, src.id, src);
        };

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var DokumanPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;

            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {

        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            showClearedPopup(pdfViewerPopup);
            callbackHelper.DoCallback(pdfViewerPopup, src.id, src);
        };

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var UrunTanimlariPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;

            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {

        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            showClearedPopup(pdfViewerPopup);
            callbackHelper.DoCallback(pdfViewerPopup, src.id, src);
        };

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var SiparisIslemleriPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;

            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {

        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            showClearedPopup(pdfViewerPopup);
            callbackHelper.DoCallback(pdfViewerPopup, src.id, src);
        };

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var CihazTakipPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;

            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {

        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            showClearedPopup(pdfViewerPopup);
            callbackHelper.DoCallback(pdfViewerPopup, src.id, src);
        };

        function employeeEditButton_Click(s, e) {
            editEmployee(s.cpEmployeeID, s);
        }

        function kullaniciEditButton_Click(s, e) {
            editUser(s.cpUserKey, s);
        }

        function evaluationGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EvaluationEditBtn")
                editEvaluation(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "EvaluationDeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Evaluation?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function taskGrid_CustomButtonClick(s, e) {
            if (e.buttonID === "EditBtn")
                editTask(s.GetRowKey(e.visibleIndex), s);
            if (e.buttonID === "DeleteBtn") {
                if (checkReadOnlyMode())
                    return;
                if (confirm("Remove Task?")) {
                    var rowIndex = s.GetFocusedRowIndex();
                    callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
                }
            }
        }

        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            EmployeeEditButton_Click: employeeEditButton_Click,
            EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var MenuYetkileriPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "CardsView":
                    if (!isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "Edit":
                    editRole(employeeID, s);
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                //case "NewRow":
                //    addUser(null, s);
                //    e.handled = true;
                //    break;
                case "EditRow":
                    editRole(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                //case "DeleteRow":
                //    deleteUser(s.GetRowKey(e.elementIndex), s);
                //    e.handled = true;
                //    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //showClearedPopup(pdfViewerPopup);
            //callbackHelper.DoCallback(pdfViewerPopup, src.id, src);
            editRole(src.id, src);
        };

        //function employeeEditButton_Click(s, e) {
        //    //editEmployee(s.cpEmployeeID, s);
        //}

        function editRole(id, sender) { // TODO
            showClearedPopup(roleEditPopup);
            callbackHelper.DoCallback(roleEditPopup, id, sender);
        }

        //function evaluationGrid_CustomButtonClick(s, e) {
        //    if (e.buttonID === "EvaluationEditBtn")
        //        editEvaluation(s.GetRowKey(e.visibleIndex), s);
        //    if (e.buttonID === "EvaluationDeleteBtn") {
        //        if (checkReadOnlyMode())
        //            return;
        //        if (confirm("Remove Evaluation?")) {
        //            var rowIndex = s.GetFocusedRowIndex();
        //            callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
        //        }
        //    }
        //}

        //function taskGrid_CustomButtonClick(s, e) {
        //    if (e.buttonID === "EditBtn")
        //        editTask(s.GetRowKey(e.visibleIndex), s);
        //    if (e.buttonID === "DeleteBtn") {
        //        if (checkReadOnlyMode())
        //            return;
        //        if (confirm("Remove Task?")) {
        //            var rowIndex = s.GetFocusedRowIndex();
        //            callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
        //        }
        //    }
        //}

        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,
            GridEditButton_Click: gridEditButton_Click,
            //EmployeeEditButton_Click: employeeEditButton_Click,
            //EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            //TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,
            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var AktivasyonFaturaliPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                //case "CardsView":
                //    if (!isGridViewMode())
                //        return;
                //    setViewMode(name);
                //    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                //    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "New":
                    addUser(null, s); // -mcy
                    break;
                //case "Delete":
                //    deleteEmployee(employeeID, s);
                //    break;
                //case "Meeting":
                //    showEditMessagePopup(editMessagePopup.cpEmployeeEditMessageTemplate, "create new meeting");
                //    break;
                //case "Task":
                //    addTask(employeeID, s);
                //    break;
                    //case "NewUser":
                    //    addUser(); // -mcy 13.09.2017
                    //    break;
                    //case "EditUser":
                    //    editUser(employeeID, s); //kullaniciEditButton_Click(); // -mcy 13.09.2017
                    //    tbPasswordTextBox.SetVisible(false); //koydum ama çalışmıyor. daha sonra devam edicem buna.
                    //    break;
                    //case "DeleteUser":
                    //    addUser(); // -mcy 13.09.2017
                    //    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            //editUser(src.id, src);
        };

        function addUser(id, sender) { //mcy
            pcAktFaturali.SetHeaderText("Aktivasyon Faturalı Oluştur");
            showClearedEditPopup(pcAktFaturali);
            callbackHelper.DoCallback(pcAktFaturali, id, sender);
            //firstNameTextBox.Focus();
            //parolayiDegistir.SetVisible(false);
        }
        //function editUser(id, sender) { //mcy
        //    showClearedPopup(kullaniciEditPopup);
        //    callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
        //    parolayiDegistir.SetVisible(true);
        //}
        //function deleteUser(id, sender) { //mcy
        //    if (checkReadOnlyMode())
        //        return;
        //    if (confirm("Remove employee?"))
        //        callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        //}

        //function addEmployee() {
        //    //employeeEditPopup.SetHeaderText("New Employee");
        //    //showClearedPopup(employeeEditPopup);
        //    //firstNameTextBox.Focus();

        //    dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
        //    showClearedPopup(dosyaYuklemePopup);
        //    //firstNameTextBox.Focus();
        //} //dosya yükleme popup

        //function NewYukle_HedefSatisDurumu() {
        //    dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
        //    showClearedPopup(dosyaYuklemePopup);
        //    callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        //}
        //function addEmployeeCustomer() {
        //    customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
        //    showClearedPopup(customerEmployeeEditPopup);
        //    firstNameTextBox.Focus();
        //}
        //function editEmployee(id, sender) { // TODO
        //    showClearedPopup(employeeEditPopup);
        //    callbackHelper.DoCallback(employeeEditPopup, id, sender);
        //}
        //function deleteEmployee(id, sender) {
        //    if (checkReadOnlyMode())
        //        return;
        //    if (confirm("Remove employee?"))
        //        callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        //}

        //function employeeEditButton_Click(s, e) {
        //    editEmployee(s.cpEmployeeID, s);
        //}

        //function kullaniciEditButton_Click(s, e) {
        //    editUser(s.cpUserKey, s);
        //}

        //function evaluationGrid_CustomButtonClick(s, e) {
        //    if (e.buttonID === "EvaluationEditBtn")
        //        editEvaluation(s.GetRowKey(e.visibleIndex), s);
        //    if (e.buttonID === "EvaluationDeleteBtn") {
        //        if (checkReadOnlyMode())
        //            return;
        //        if (confirm("Remove Evaluation?")) {
        //            var rowIndex = s.GetFocusedRowIndex();
        //            callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
        //        }
        //    }
        //}

        //function taskGrid_CustomButtonClick(s, e) {
        //    if (e.buttonID === "EditBtn")
        //        editTask(s.GetRowKey(e.visibleIndex), s);
        //    if (e.buttonID === "DeleteBtn") {
        //        if (checkReadOnlyMode())
        //            return;
        //        if (confirm("Remove Task?")) {
        //            var rowIndex = s.GetFocusedRowIndex();
        //            callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
        //        }
        //    }
        //}

        //function editEvaluation(id, sender) {
        //    showClearedPopup(evaluationEditPopup);
        //    callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        //}

        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,

            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,

            //GridEditButton_Click: gridEditButton_Click,
            //EmployeeEditButton_Click: employeeEditButton_Click,
            //EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            //TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,

            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var AktivasyonFaturasizPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                //case "CardsView":
                //    if (!isGridViewMode())
                //        return;
                //    setViewMode(name);
                //    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                //    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "New":
                    addUser(null, s); // -mcy
                    break;
                //case "Delete":
                //    deleteEmployee(employeeID, s);
                //    break;
                //case "Meeting":
                //    showEditMessagePopup(editMessagePopup.cpEmployeeEditMessageTemplate, "create new meeting");
                //    break;
                //case "Task":
                //    addTask(employeeID, s);
                //    break;
                //case "NewUser":
                //    addUser(); // -mcy 13.09.2017
                //    break;
                //case "EditUser":
                //    editUser(employeeID, s); //kullaniciEditButton_Click(); // -mcy 13.09.2017
                //    tbPasswordTextBox.SetVisible(false); //koydum ama çalışmıyor. daha sonra devam edicem buna.
                //    break;
                //case "DeleteUser":
                //    addUser(); // -mcy 13.09.2017
                //    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s); // TODO check this case
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
            //editEmployee(src.id, src);
            //editUser(src.id, src);
        };

        function addUser(id, sender) { //mcy
            pcAktFaturali.SetHeaderText("Aktivasyon Faturasız Oluştur");
            showClearedEditPopup(pcAktFaturali);
            callbackHelper.DoCallback(pcAktFaturali, id, sender);
            //firstNameTextBox.Focus();
            //parolayiDegistir.SetVisible(false);
        }
        //function editUser(id, sender) { //mcy
        //    showClearedPopup(kullaniciEditPopup);
        //    callbackHelper.DoCallback(kullaniciEditPopup, id, sender);
        //    parolayiDegistir.SetVisible(true);
        //}
        //function deleteUser(id, sender) { //mcy
        //    if (checkReadOnlyMode())
        //        return;
        //    if (confirm("Remove employee?"))
        //        callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        //}

        //function addEmployee() {
        //    //employeeEditPopup.SetHeaderText("New Employee");
        //    //showClearedPopup(employeeEditPopup);
        //    //firstNameTextBox.Focus();

        //    dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
        //    showClearedPopup(dosyaYuklemePopup);
        //    //firstNameTextBox.Focus();
        //} //dosya yükleme popup

        //function NewYukle_HedefSatisDurumu() {
        //    dosyaYuklemePopup.SetHeaderText("Dosya Yükleme");
        //    showClearedPopup(dosyaYuklemePopup);
        //    callbackHelper.DoCallback(dosyaYuklemePopup, id, sender);
        //}
        //function addEmployeeCustomer() {
        //    customerEmployeeEditPopup.SetHeaderText("New Employee Customer");
        //    showClearedPopup(customerEmployeeEditPopup);
        //    firstNameTextBox.Focus();
        //}
        //function editEmployee(id, sender) { // TODO
        //    showClearedPopup(employeeEditPopup);
        //    callbackHelper.DoCallback(employeeEditPopup, id, sender);
        //}
        //function deleteEmployee(id, sender) {
        //    if (checkReadOnlyMode())
        //        return;
        //    if (confirm("Remove employee?"))
        //        callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["DeleteEntry", id]), sender);
        //}

        //function employeeEditButton_Click(s, e) {
        //    editEmployee(s.cpEmployeeID, s);
        //}

        //function kullaniciEditButton_Click(s, e) {
        //    editUser(s.cpUserKey, s);
        //}

        //function evaluationGrid_CustomButtonClick(s, e) {
        //    if (e.buttonID === "EvaluationEditBtn")
        //        editEvaluation(s.GetRowKey(e.visibleIndex), s);
        //    if (e.buttonID === "EvaluationDeleteBtn") {
        //        if (checkReadOnlyMode())
        //            return;
        //        if (confirm("Remove Evaluation?")) {
        //            var rowIndex = s.GetFocusedRowIndex();
        //            callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Evaluation", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
        //        }
        //    }
        //}

        //function taskGrid_CustomButtonClick(s, e) {
        //    if (e.buttonID === "EditBtn")
        //        editTask(s.GetRowKey(e.visibleIndex), s);
        //    if (e.buttonID === "DeleteBtn") {
        //        if (checkReadOnlyMode())
        //            return;
        //        if (confirm("Remove Task?")) {
        //            var rowIndex = s.GetFocusedRowIndex();
        //            callbackHelper.DoCallback(detailsCallbackPanel, serializeArgs(["DeleteEntry", "Task", rowIndex >= 0 ? s.GetRowKey(rowIndex) : ""]), s);
        //        }
        //    }
        //}

        //function editEvaluation(id, sender) {
        //    showClearedPopup(evaluationEditPopup);
        //    callbackHelper.DoCallback(evaluationEditPopup, id, sender);
        //}

        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { // MCY
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,

            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,

            //GridEditButton_Click: gridEditButton_Click,
            //EmployeeEditButton_Click: employeeEditButton_Click,
            //EvaluationGrid_CustomButtonClick: evaluationGrid_CustomButtonClick,
            //TaskGrid_CustomButtonClick: taskGrid_CustomButtonClick,

            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid // MCY
        };
    })();
    var AktivasyonSebekeIciGecisPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "New":
                    addUser(null, s);
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
        };

        function addUser(id, sender) { 
            pcAktFaturali.SetHeaderText("Aktivasyon Şebeke İçi Geçiş Oluştur");
            showClearedEditPopup(pcAktFaturali);
            callbackHelper.DoCallback(pcAktFaturali, id, sender);
        }
      
        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() { 
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,

            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,

            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid 
        };
    })();
    var AktivasyonTaahhutnamePage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "New":
                    addUser(null, s);
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
        };

        function addUser(id, sender) {
            pcAktFaturali.SetHeaderText("Aktivasyon Şebeke İçi Geçiş Oluştur");
            showClearedEditPopup(pcAktFaturali);
            callbackHelper.DoCallback(pcAktFaturali, id, sender);
        }

        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() {
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,

            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,

            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid
        };
    })();
    var AktivasyonHatIptalPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "New":
                    addUser(null, s);
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
        };

        function addUser(id, sender) {
            pcAktFaturali.SetHeaderText("Aktivasyon Şebeke İçi Geçiş Oluştur");
            showClearedEditPopup(pcAktFaturali);
            callbackHelper.DoCallback(pcAktFaturali, id, sender);
        }

        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() {
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,

            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,

            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid
        };
    })();
    var AktivasyonVodafoneNetPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "New":
                    addUser(null, s);
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
        };

        function addUser(id, sender) {
            pcAktFaturali.SetHeaderText("Aktivasyon Şebeke İçi Geçiş Oluştur");
            showClearedEditPopup(pcAktFaturali);
            callbackHelper.DoCallback(pcAktFaturali, id, sender);
        }

        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() {
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,

            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,

            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid
        };
    })();
    var AktivasyonEFaturaPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "New":
                    addUser(null, s);
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
        };

        function addUser(id, sender) {
            pcAktFaturali.SetHeaderText("Aktivasyon Şebeke İçi Geçiş Oluştur");
            showClearedEditPopup(pcAktFaturali);
            callbackHelper.DoCallback(pcAktFaturali, id, sender);
        }

        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() {
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,

            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,

            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid
        };
    })();
    var AktivasyonYoneticiPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;
            switch (name) {
                case "GridView":
                    if (isGridViewMode())
                        return;
                    setViewMode(name);
                    callbackHelper.DoCallback(mainCallbackPanel, "", s);
                    break;
                case "ColumnsCustomization":
                    if (employeesGrid.IsCustomizationWindowVisible())
                        employeesGrid.HideCustomizationWindow();
                    else
                        employeesGrid.ShowCustomizationWindow(e.htmlElement);
                    break;
                case "New":
                    addUser(null, s);
                    break;
            }
        }

        function employeesGrid_Init(s, e) {
            setToolbarCWItemEnabled(true);
        }
        function employeesGrid_FocusedRowChanged(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_EndCallback(s, e) {
            updateDetailInfo(s);
        }
        function employeesGrid_ContextMenuItemClick(s, e) {
            switch (e.item.name) {
                case "NewRow":
                    NewYukle_HedefSatisDurumu(1001, s);
                    e.handled = true;
                    break;
                case "EditRow":
                    editEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
                case "DeleteRow":
                    deleteEmployee(s.GetRowKey(e.elementIndex), s);
                    e.handled = true;
                    break;
            }
        }

        function gridEditButton_Click(e) {
            var src = ASPxClientUtils.GetEventSource(e);
        };

        function addUser(id, sender) {
            pcAktFaturali.SetHeaderText("Aktivasyon Şebeke İçi Geçiş Oluştur");
            showClearedEditPopup(pcAktFaturali);
            callbackHelper.DoCallback(pcAktFaturali, id, sender);
        }

        function getSelectedEmployeeID() {
            var getIndex, getKey;
            if (isGridViewMode()) {
                getIndex = employeesGrid.GetFocusedRowIndex.aspxBind(employeesGrid);
                getKey = employeesGrid.GetRowKey.aspxBind(employeesGrid);
            } else {
                getIndex = employeeCardView.GetFocusedCardIndex.aspxBind(employeeCardView);
                getKey = employeeCardView.GetCardKey.aspxBind(employeeCardView);
            }
            if (getIndex() >= 0)
                return getKey(getIndex());
            return null;
        };

        function getViewMode() {
            return getViewModeCore("EmployeeViewMode");
        };
        function setViewMode(value) {
            setViewModeCore("EmployeeViewMode", value);
        };
        function isGridViewMode() {
            var viewMode = getViewMode();
            return !viewMode || viewMode === "GridView";
        };

        function getSelectedItemID() {
            return getSelectedEmployeeID();
        }

        function getSelectedItemGuid() {
            return getSelectedEmployeeID();
        }

        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,

            EmployeesGrid_Init: employeesGrid_Init,
            EmployeesGrid_FocusedRowChanged: employeesGrid_FocusedRowChanged,
            EmployeesGrid_EndCallback: employeesGrid_EndCallback,
            EmployeesGrid_ContextMenuItemClick: employeesGrid_ContextMenuItemClick,

            GetSelectedItemID: getSelectedItemID,
            IsGridViewMode: isGridViewMode,

            GetSelectedItemGuid: getSelectedItemGuid
        };
    })();
    var PersonelYoneticiPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;

        }



        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,

        };
    })();
    var YBayiCihazDashboardPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;

        }



        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,

        };
    })();
    var YBayiCihazTemlikGunDashboardPage = (function () {
        function toolbarMenu_ItemClick(s, e) {
            var employeeID = getSelectedEmployeeID();
            var name = e.item.name;

        }



        return {
            ToolbarMenu_ItemClick: toolbarMenu_ItemClick,

        };
    })();
    
    function getCurrentPage() {
        var pageName = DevAVPageName;
        switch (pageName) {
            
            case "Dashboards":
                return dashboardPage;
            case "HedefSatisDurumu": 
                return hedefSatisDurumuPage;
            case "TYHedefSatisDurumu": 
                return TYHedefSatisDurumuPage;
            case "KullaniciTanimlari":
                return kullaniciTanimlariPage;
            case "CariHesapEkstresi":
                return cariHesapEkstresiPage;
            case "TYAktivasyonAraRaporu":
                return tyAktivasyonAraRaporuPage;
            case "Widgets":
                return widgetsPage;
            case "TYDuyurular":
                return TYDuyurularPage;
            case "CihazAktivasyonAraRaporu":
                return cihazAktivasyonAraRaporuPage;
            case "TYTemlikIslemleri":
                return tyCihazTemlikRaporuPage;
            case "CihazTemlik":
                return cihazTemlikRaporuPage;
            case "TYPrimHakedis":
                return tyPrimHakedisRaporuPage;
            case "PrimHakedis":
                return primHakedisRaporuPage;
            case "TYAlSatKarlilik":
                return TYAlSatKarlilikPage;
            case "AlSatKarlilik":
                return AlSatKarlilikPage;
            case "RaporEnvanter":
                return RaporEnvanterPage;
            case "RaporKar":
                return RaporKarPage;
            case "RaporFatura":
                return RaporFaturaPage;
            case "RaporMalzemeSonAlimMaliyeti":
                return RaporMalzemeSonAlimMaliyetiPage;
            case "RaporGenelDurum":
                return RaporGenelDurumPage;
            case "BayiTanimlari":
                return BayiTanimlariPage;
            case "CariTakip":
                return CariTakipPage;
            case "TYDokuman":
                return TYDokumanPage;
            case "Dokumanlar":
                return DokumanPage;
            case "UrunTanimlari":
                return UrunTanimlariPage;
            case "SiparisIslemleri":
                return SiparisIslemleriPage;
            case "CihazTakip":
                return CihazTakipPage;
            case "MenuYetkileri":
                return MenuYetkileriPage;
            case "AktivasyonFaturali":
                return AktivasyonFaturaliPage;
            case "AktivasyonFaturasiz":
                return AktivasyonFaturasizPage;
            case "AktivasyonSebekeIciGecis":
                return AktivasyonSebekeIciGecisPage;
            case "AktivasyonTaahhutname":
                return AktivasyonTaahhutnamePage;
            case "AktivasyonHatIptal":
                return AktivasyonHatIptalPage;
            case "AktivasyonVodafoneNet":
                return AktivasyonVodafoneNetPage;
            case "AktivasyonEFatura":
                return AktivasyonEFaturaPage;
            case "Aktivasyon":
                return AktivasyonYoneticiPage;
            case "YBayiCihazDashboard":
                return YBayiCihazDashboardPage;
            case "YBayiCihazTemlikGunDashboard":
                return YBayiCihazTemlikGunDashboardPage;
        }
    };

    var page = getCurrentPage();

    function gridEditButton_Click(event) {
        page.GridEditButton_Click(event);
        ASPxClientUtils.PreventEventAndBubble(event);
    }

    function adjustMainContentPaneSize() {
        var pane = splitter.GetPaneByName("MainContentPane");
        if (page === TYHedefSatisDurumuPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === kullaniciTanimlariPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if(page === cariHesapEkstresiPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === hedefSatisDurumuPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === tyAktivasyonAraRaporuPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);

        if (page === TYDuyurularPage)
            adjustControlSizeDuyuruSlider(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);

        if (page === widgetsPage)
            adjustControlSizeSplitter(pane);

        if (page === cihazAktivasyonAraRaporuPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === cihazTemlikRaporuPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === tyCihazTemlikRaporuPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === tyPrimHakedisRaporuPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === primHakedisRaporuPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === TYAlSatKarlilikPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === AlSatKarlilikPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === RaporEnvanterPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === RaporKarPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === RaporFaturaPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === RaporMalzemeSonAlimMaliyetiPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === RaporGenelDurumPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === BayiTanimlariPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === CariTakipPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === TYDokumanPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === DokumanPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === UrunTanimlariPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === SiparisIslemleriPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === CihazTakipPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === MenuYetkileriPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === AktivasyonFaturaliPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === AktivasyonFaturasizPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === AktivasyonSebekeIciGecisPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === AktivasyonTaahhutnamePage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === AktivasyonHatIptalPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === AktivasyonVodafoneNetPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === AktivasyonEFaturaPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);
        if (page === AktivasyonYoneticiPage)
            adjustControlSize(pane, page.IsGridViewMode() ? employeesGrid : employeeCardView, detailsCallbackPanel);

        if (page === YBayiCihazDashboardPage)
            adjustControlSizeDashboard(pane);
        if (page === YBayiCihazTemlikGunDashboardPage)
            adjustControlSizeDashboard(pane);
    }
    function adjustControlSize(splitterPane, grid, detailPanel, minHeight) {
        grid.SetHeight(splitterPane.GetClientHeight() - (detailPanel ? detailPanel.GetHeight() : 0));
    }
    function adjustControlSizeDuyuruSlider(splitterPane, grid, detailPanel, minHeight) {
        grid.SetHeight(splitterPane.GetClientHeight() - (detailPanel ? detailPanel.GetHeight() : 0));
        duyurularSliderGrid.SetHeight(splitterPane.GetClientHeight() - (detailPanel ? detailPanel.GetHeight() : 0));
    }
    function adjustControlSizeSplitter(splitterPane) {
        widgetSplitter.SetHeight(splitterPane.GetClientHeight());
    }

    function adjustControlSizeDashboard(splitterPane) {
        aSPxDashboard1.SetHeight(splitterPane.GetClientHeight());
    }

    //function filterNavBar_Init(s, e) {
    //    loadFilterNavBarSelectedItem();
    //};
    //function filterNavBar_ItemClick(s, e) {
    //    if (e.item.name !== s.cpPrevSelectedItemName)
    //        changeFilter(s.cpFilterExpressions[e.item.name], s);
    //};

    //function searchBox_KeyDown(s, e) {
    //    window.clearTimeout(searchBoxTimer);
    //    searchBoxTimer = window.setTimeout(function () { onSearchTextChanged(s); }, 1200);
    //    e = e.htmlEvent;
    //    if (e.keyCode === 13) {
    //        if (e.preventDefault)
    //            e.preventDefault();
    //        else
    //            e.returnValue = false;
    //    }
    //};
    //function searchBox_TextChanged(s, e) {
    //    onSearchTextChanged(s);
    //};
    //function onSearchTextChanged(sender) {
    //    window.clearTimeout(searchBoxTimer);
    //    var searchText = searchBox.GetText();
    //    if (hiddenField.Get("SearchText") === searchText)
    //        return;
    //    hiddenField.Set("SearchText", searchText);
    //    callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["Search"]), sender);
    //};

    //function filterControl_Applied(s, e) {
    //    changeFilter(e.filterExpression, s);
    //}
    //function saveCustomFilterCheckBox_CheckedChanged(s, e) {
    //    customFilterTextBox.SetEnabled(s.GetChecked());
    //    customFilterTextBox.SetIsValid(true);
    //}
    //function customFilterTextBox_Validation(s, e) {
    //    e.isValid = !!e.value || !saveCustomFilterCheckBox.GetChecked();
    //}
    //function saveFilterButton_Click(s, e) {
    //    if (saveCustomFilterCheckBox.GetChecked()) {
    //        var validated = ASPxClientEdit.ValidateEditorsInContainer(filterPopup.GetMainElement());
    //        if (validated)
    //            filterPopup.Hide();
    //        return;
    //    }
    //    e.processOnServer = false;
    //    filterPopup.Hide();
    //    filterControl.Apply();
    //}
    //function cancelFilterButton_Click(s, e) {
    //    filterPopup.Hide();
    //}

    function mainCallbackPanel_EndCallback(s, e) {
        if (s.cpSelectedFilterNavBarItemName)
            updateFilterNavBarSelection(s.cpSelectedFilterNavBarItemName);
        adjustMainContentPaneSize();
    }

    function splitter_PaneResized(s, e) {
        if (e.pane.name === 'MainContentPane')
            window.setTimeout(function () { adjustMainContentPaneSize(); }, 0);
    }

    //function pageViewerPopup_Shown(s, e) {
    //    preparePopupWithIframe(s);
    //}
    //function revenueAnalysisPopup_Shown(s, e) {
    //    preparePopupWithIframe(s);
    //}
    //function pageViewerPopup_CloseUp(s, e) {
    //    s.SetContentUrl("");
    //}
    //function revenueAnalysisPopup_CloseUp(s, e) {
    //    s.SetContentUrl("");
    //}

    function toolbarMenu_ItemClick(s, e) {
        var name = e.item.name;

        var selectedItemID = page.GetSelectedItemID && page.GetSelectedItemID();
        // grid deki item ları şuan için ihtiyacım yok. grid olmadığı için hata veriyor. yukarıdaki new buttonu için popup açmaya çalışıyorum. -mcy

        //if (name === "Print" || e.item.parent && e.item.parent.name === "Print")
        //    openReport(s.cpReportNames[name], selectedItemID);
        //if (name === "ExportToSpreadsheet")
        //    openSpreadsheet(s.cpReportNames[name], selectedItemID);
        //if (name === "Filter")
        //    filterPopup.Show();

        //if (name === "Cikis")
        //{
        //    window.location.href("~/");
        //}

        page.ToolbarMenu_ItemClick(s, e);
    }

    function preparePopupWithIframe(popup) {
        var iframe = popup.GetContentIFrame();
        setAttribute(iframe, "scrolling", "no");
        iframe.style.overflow = "hidden";
    };

    //function updateFilterNavBarSelection(selectedItemName) {
    //    var oldItem = filterNavBar.GetSelectedItem();
    //    var newItem = filterNavBar.GetItemByName(selectedItemName);
    //    if (oldItem && newItem && filterNavBar.cpFilterExpressions[oldItem.name] === filterNavBar.cpFilterExpressions[newItem.name])
    //        return;
    //    filterNavBar.SetSelectedItem(newItem);
    //    loadFilterNavBarSelectedItem();
    //}

    //function changeFilter(expression, sender) {
    //    callbackHelper.DoCallback(mainCallbackPanel, serializeArgs(["FilterChanged", expression]), sender);
    //    loadFilterNavBarSelectedItem();
    //}

    //function loadFilterNavBarSelectedItem() {
    //    var item = filterNavBar.GetSelectedItem();
    //    filterNavBar.cpPrevSelectedItemName = item ? item.name : "";
    //}

    function serializeArgs(args) {
        var result = [];
        for (var i = 0; i < args.length; i++) {
            var value = args[i] ? args[i].toString() : "";
            result.push(value.length);
            result.push("|");
            result.push(value);
        }
        return result.join("");
    }
    function setAttribute(element, attrName, value) {
        if (element.setAttribute)
            element.setAttribute(attrName, value);
        else if (element.setProperty)
            element.setProperty(attrName, value, "");
    }

    function employeeEditPopup_EndCallback(s, e) {
        s.SetHeaderText(s.cpHeaderText);
        //firstNameTextBox.Focus();
    }
    //function evaluationEditPopup_EndCallback(s, e) {
    //    s.SetHeaderText(s.cpHeaderText);
    //    evaluationSubjectTextBox.Focus();
    //}
    //function taskEditPopup_EndCallback(s, e) {
    //    s.SetHeaderText(s.cpHeaderText);
    //    OwnerComboBox.Focus();
    //}
    //function customerEditPopup_EndCallback(s, e) {
    //    s.SetHeaderText(s.cpHeaderText);
    //    //firstNameTextBox.Focus();
    //}
    function bayiEditPopup_EndCallback(s, e) {
        s.SetHeaderText(s.cpHeaderText);
        bayiKoduTextBox.Focus();
    }
    function aktivasyonFaturaliEditForm_EndCallback(s, e) {
        s.SetHeaderText(s.cpHeaderText);
        txtAdi.Focus();
    }
    function roleEditPopup_EndCallback(s, e) {
        s.SetHeaderText(s.cpHeaderText);
    }
    function aktivasyonFaturasizEditForm_EndCallback(s, e) {
        s.SetHeaderText(s.cpHeaderText);
        txtAdi.Focus();
    }
    function aktivasyonSebekeIciGecisEditForm_EndCallback(s, e) {
        s.SetHeaderText(s.cpHeaderText);
        txtAdi.Focus();
    }
    function aktivasyonTaahhutnameEditForm_EndCallback(s, e) {
        s.SetHeaderText(s.cpHeaderText);
        txtAdi.Focus();
    }
    function aktivasyonHatIptalEditForm_EndCallback(s, e) {
        s.SetHeaderText(s.cpHeaderText);
        txtAdi.Focus();
    }
    function aktivasyonVodafoneNetEditForm_EndCallback(s, e) {
        s.SetHeaderText(s.cpHeaderText);
        txtAdi.Focus();
    }
    //AktivasyonEFaturaPage
    function aktivasyonEFaturaEditForm_EndCallback(s, e) {
        s.SetHeaderText(s.cpHeaderText);
        txtAdi.Focus();
    }
    return {
        Page: page,
        //FilterNavBar_Init: filterNavBar_Init,
        //FilterNavBar_ItemClick: filterNavBar_ItemClick,
        //SearchBox_KeyDown: searchBox_KeyDown,
        //SearchBox_TextChanged: searchBox_TextChanged,
        //FilterControl_Applied: filterControl_Applied,
        //SaveCustomFilterCheckBox_CheckedChanged: saveCustomFilterCheckBox_CheckedChanged,
        //CustomFilterTextBox_Validation: customFilterTextBox_Validation,
        //SaveFilterButton_Click: saveFilterButton_Click,
        //CancelFilterButton_Click: cancelFilterButton_Click,
        MainCallbackPanel_EndCallback: mainCallbackPanel_EndCallback,
        Splitter_PaneResized: splitter_PaneResized,
        //PageViewerPopup_Shown: pageViewerPopup_Shown,
        //PageViewerPopup_CloseUp: pageViewerPopup_CloseUp,
        //RevenueAnalysisPopup_Shown: revenueAnalysisPopup_Shown,
        //RevenueAnalysisPopup_CloseUp: revenueAnalysisPopup_CloseUp,
        //RevenueAnalysisCloseButton_Click: revenueAnalysisCloseButton_Click,

        ToolbarMenu_ItemClick: toolbarMenu_ItemClick,
        GridEditButton_Click: gridEditButton_Click,

        GridCustomizationWindow_CloseUp: gridCustomizationWindow_CloseUp,

        //CardView_Init: cardView_Init,
        //CardView_EndCallback: cardView_EndCallback,

        //EmployeeCancelButton_Click: employeeCancelButton_Click,
        //EmployeeSaveButton_Click: employeeSaveButton_Click,

        //EvaluationSaveButton_Click: evaluationSaveButton_Click,
        //EvaluationCancelButton_Click: evaluationCancelButton_Click,
        //TaskSaveButton_Click: taskSaveButton_Click,
        //TaskCancelButton_Click: taskCancelButton_Click,
        //CustomerCancelButton_Click: customerCancelButton_Click,
        //CustomerSaveButton_Click: customerSaveButton_Click,

        EmployeeEditPopup_EndCallback: employeeEditPopup_EndCallback,

        //EvaluationEditPopup_EndCallback: evaluationEditPopup_EndCallback,
        //TaskEditPopup_EndCallback: taskEditPopup_EndCallback,
        //CustomerEditPopup_EndCallback: customerEditPopup_EndCallback,

        DosyaYuklemeVazgecButton_Click: dosyaYuklemeVazgecButton_Click,

        KullaniciSaveButton_Click: kullaniciSaveButton_Click,
        KullaniciCancelButton_Click: kullaniciCancelButton_Click,

        BayiEditPopup_EndCallback: bayiEditPopup_EndCallback,
        BayiSaveButton_Click: bayiSaveButton_Click,
        BayiCancelButton_Click: bayiCancelButton_Click,
        KaydetVeKullaniciOlusturButton_Click: kaydetVeKullaniciOlusturButton_Click,

        AktivasyonFaturaliSaveButton_Click: aktivasyonFaturaliSaveButton_Click,
        AktivasyonFaturaliCancelButton_Click: aktivasyonFaturaliCancelButton_Click,
        AktivasyonFaturaliEditForm_EndCallback: aktivasyonFaturaliEditForm_EndCallback,

        AktivasyonFaturasizEditForm_EndCallback: aktivasyonFaturasizEditForm_EndCallback,
        AktivasyonFaturasizSaveButton_Click: aktivasyonFaturasizSaveButton_Click,
        AktivasyonFaturasizCancelButton_Click: aktivasyonFaturasizCancelButton_Click,

        RoleEditPopup_EndCallback: roleEditPopup_EndCallback,
        RoleSaveButton_Click: roleSaveButton_Click,
        RoleCancelButton_Click: roleCancelButton_Click,

        AktivasyonSebekeIciGecisEditForm_EndCallback: aktivasyonSebekeIciGecisEditForm_EndCallback,
        AktivasyonSebekeIciGecisSaveButton_Click: aktivasyonSebekeIciGecisSaveButton_Click,
        AktivasyonSebekeIciGecisCancelButton_Click: aktivasyonSebekeIciGecisCancelButton_Click,

        AktivasyonTaahhutnameEditForm_EndCallback: aktivasyonTaahhutnameEditForm_EndCallback,
        AktivasyonTaahhutnameSaveButton_Click: aktivasyonTaahhutnameSaveButton_Click,
        AktivasyonTaahhutnameCancelButton_Click: aktivasyonTaahhutnameCancelButton_Click,

        AktivasyonHatIptalEditForm_EndCallback: aktivasyonHatIptalEditForm_EndCallback,
        AktivasyonHatIptalSaveButton_Click: aktivasyonHatIptalSaveButton_Click,
        AktivasyonHatIptalCancelButton_Click: aktivasyonHatIptalCancelButton_Click,

        //AktivasyonVodafoneNet
        AktivasyonVodafoneNetEditForm_EndCallback: aktivasyonVodafoneNetEditForm_EndCallback,
        AktivasyonVodafoneNetSaveButton_Click: aktivasyonVodafoneNetSaveButton_Click,
        AktivasyonVodafoneNetCancelButton_Click: aktivasyonVodafoneNetCancelButton_Click,

        //AktivasyonEFatura
        AktivasyonEFaturaEditForm_EndCallback: aktivasyonEFaturaEditForm_EndCallback,
        AktivasyonEFaturaSaveButton_Click: aktivasyonVodafoneNetSaveButton_Click,
        AktivasyonEFaturaCancelButton_Click: aktivasyonEFaturaCancelButton_Click
    };

})();

//MCY SCRIPT BAŞLANGIÇI
//function OnImageClick(s, e) {
//    MainLogo.GetMainElement().onmouseover = null;
//}
function Cikis() {
    popupCikis.Show();
}
function CikisHide() {
    popupCikis.Hide();
}
//KULLANICI TANIMLARI - GRID MENÜSÜ
//function gridCustomizationWindow_CloseUp() {
//    toolbarMenu.GetItemByName("ColumnsCustomization").SetChecked(false);
//};
//function toolbarMenu_ItemClick(s, e) {
//    var name = e.item.name;
//    switch (name) {
//        case "ColumnsCustomization":
//            if (grid.IsCustomizationWindowVisible())
//                grid.HideCustomizationWindow();
//            else
//                grid.ShowCustomizationWindow(e.htmlElement);
//            break;
//    }
//}

//DEFAULT - WIDGET
//function ShowWidgetPanel(widgetPanelUID) {
//    var panel = dockManager.GetPanelByUID(widgetPanelUID);
//    panel.Show();
//}
//function SetWidgetButtonVisible(widgetName, visible) {
//    var button = ASPxClientControl.GetControlCollection().GetByName('widgetButton_' + widgetName);
//    button.GetMainElement().className = visible ? '' : 'disabled';
//}

//GRİD YÜKSEKLİĞİNİ SAYFAYA GÖRE AYARLAR
//window.onload = function () {
//    adjustSize();
//}

//function adjustSize() {
//    if (document.getElementById('DuyuruGridContainer') != null) {
//        var topContainer = document.getElementById('DuyuruGridContainer');
//        var height = Math.max(0, document.documentElement.clientHeight - topContainer.offsetHeight + 57);
//        duyurularimGrid.SetHeight(height);
//    }
//    else if (document.getElementById('KullaniciTanimlariGridContainer') != null) {
//        var topContainer = document.getElementById('KullaniciTanimlariGridContainer');
//        var height = Math.max(0, document.documentElement.clientHeight - topContainer.offsetHeight + 90);
//        grid.SetHeight(height);
//    }
//    else if (document.getElementById('TakvimGridContainer') != null) {
//        var divElement = document.getElementById("TakvimGridContainer");
//        divElement.style.height = document.documentElement.clientHeight - divElement.offsetHeight - 122 + "px";
//    }
//    else if (document.getElementById('HedefSatisDurumuGridContainer') != null) {
//        var topContainer = document.getElementById('HedefSatisDurumuGridContainer');
//        var height = Math.max(0, document.documentElement.clientHeight - topContainer.offsetHeight - 450);
//        grid.SetHeight(height);
//    }
//}

var lastCountry = null;
function OnCountryChanged(cmbSehir) {
    if (cmbIlce.InCallback())
        lastCountry = cmbSehir.GetValue().toString();
    else
        cmbIlce.PerformCallback(cmbSehir.GetValue().toString());
}
function OnEndCallback(s, e) {
    if (lastCountry) {
        cmbIlce.PerformCallback(lastCountry);
        lastCountry = null;
    }
}
