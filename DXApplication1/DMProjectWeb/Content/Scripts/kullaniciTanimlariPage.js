var kullaniciTanimlariPage = (function () {
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

    //function kullaniciEditButton_Click(s, e) { //bunun bir fonksiyonu olduğunu düşünmüyorum. eskiden kalmış sanırım.
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