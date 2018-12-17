using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Caching;
using System.Web.SessionState;
using System.Xml.Linq;
using DevExpress.Data.Filtering;
//using DevExpress.DevAV;
//using DevExpress.DevAV.Reports;
using DevExpress.Web;
using DevExpress.XtraPrinting;
using DevExpress.XtraReports.UI;

public static class DemoUtils
{
    const char SerializedStringArraySeparator = '|';
    const string StateHiddenFieldContextKey = "216A8C03-7A8A-4735-8CBB-4C62E0D4D23C",
        SearchExpressionsContextKey = "7063240E-83E6-415E-A399-5F6C917CA385";
    //StatesFilePath = "~/App_Data/States.xml",
    //GridViewViewModeKey = "GridView",
    //ContactImageSlideViewModeKey = "Contacts",
    //EmployeePageViewModeCookieKey = "EmployeeViewMode",
    //TaskPageViewModeCookieKey = "TaskViewMode",
    //ImageSliderModeCookieKey = "CustomerImageSliderMode",
    //

    public static HttpContext Context { get { return HttpContext.Current; } }
    static ASPxHiddenField StateHiddenField
    {
        get { return Context.Items[StateHiddenFieldContextKey] as ASPxHiddenField; }
        set { Context.Items[StateHiddenFieldContextKey] = value; }
    }
    public static List<string> DeserializeCallbackArgs(string data)
    {
        List<string> items = new List<string>();
        if (!string.IsNullOrEmpty(data))
        {
            int currentPos = 0;
            int dataLength = data.Length;
            while (currentPos < dataLength)
            {
                string item = DeserializeStringArrayItem(data, ref currentPos);
                items.Add(item);
            }
        }
        return items;
    }
    static string DeserializeStringArrayItem(string data, ref int currentPos)
    {
        int indexOfFirstSeparator = data.IndexOf(SerializedStringArraySeparator, currentPos);
        string itemLengthString = data.Substring(currentPos, indexOfFirstSeparator - currentPos);
        int itemLength = Int32.Parse(itemLengthString);
        currentPos += itemLengthString.Length + 1;
        string item = data.Substring(currentPos, itemLength);
        currentPos += itemLength;
        return item;
    }

    //public static void RegisterStateHiddenField(ASPxHiddenField hf)
    //{
    //    StateHiddenField = hf;
    //}

    public static bool TryGetClientStateValue<T>(string key, out T result)
    {
        if (!IsStateHiddenFieldContainsKey(key))
        {
            result = default(T);
            return false;
        }
        result = (T)StateHiddenField[key];
        return true;
    }
    static bool IsStateHiddenFieldContainsKey(string key)
    {
        return StateHiddenField != null && StateHiddenField.Contains(key);
    }
    public static bool TrySetClientStateValue<T>(string key, T value)
    {
        if (StateHiddenField == null)
            return false;
        StateHiddenField[key] = value;
        return true;
    }

    //comboboxlar için olan kodlar -başlangıç
    //public static void BindComboBoxToEnum(ASPxComboBox comboBox, Type enumType)
    //{
    //    comboBox.ValueType = enumType;
    //    PopulateComboBoxItems(comboBox.Items, enumType);
    //}
    //public static void BindComboBoxToEnum(ComboBoxProperties prop, Type enumType)
    //{
    //    prop.ValueType = enumType;
    //    PopulateComboBoxItems(prop.Items, enumType);
    //}
    //static void PopulateComboBoxItems(ListEditItemCollection items, Type enumType)
    //{
    //    items.Clear();
    //    foreach (var value in Enum.GetValues(enumType))
    //        items.Add(DevExpress.Web.Internal.CommonUtils.SplitPascalCaseString(value.ToString()), value);
    //}
    //comboboxlar için olan kodlar -bitiş

    public static void RegisterStateHiddenField(ASPxHiddenField hf)
    {
        StateHiddenField = hf;
    }

}

public static class DemoExtentionUtils
{

    public static T Add<T>(this ArrayList self, T item)
    {
        self.Add(item);
        return item;
    }

    public static TableRow Add(this TableRowCollection collection)
    { // TODO check why it doesn't work
        var row = new TableRow();
        collection.Add(row);
        return row;
    }
}
