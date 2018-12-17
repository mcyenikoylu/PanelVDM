using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.EditForms
{
    public partial class MenuYetkisiEditForm : EditFormViewUserControl
    {
        DMPortalEntities db = new DMPortalEntities();
        public override void Update()
        {
            //EditFormViewUserControl için eklemek zorundayım.
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            ASPxTreeList1.DataBind();
            ASPxTreeList1.SettingsSelection.Recursive = true;
            ASPxTreeList1.ExpandToLevel(2);
        }
        protected List<S_MenuYetkileri_Result> GridUpdating(int islemtipi)
        {
            var list2 = db.S_MenuYetkileri(islemtipi, SelectedItemGuid).ToList();
            if (list2.Count > 0)
            {
                return list2;
            }
            else
                return null;
        }
        public override int SaveChanges(string args) //EditFormUserControl class'ında zorunlu olduğu için duruyor. bu ekranda guid olduğu için kullanılmıyor.
        {
            var callbackArgs = DemoUtils.DeserializeCallbackArgs(args);
            return 0;
        }
        public override Guid SaveChangesKullanici(string args) //kullanmasamda zorunlu olarak koymak zorunda kalıyorum her sayfaya.
        {
            var callbackArgs = DemoUtils.DeserializeCallbackArgs(args);
            Guid roleGuid = new Guid(callbackArgs[1]);
            if (callbackArgs[0] == "New")
            {

            }
            else if (callbackArgs[0] == "Edit")
            {
                db.D_RoleMenuYetkileriSil(roleGuid);
                var collection = TestProperty;
                foreach (var item in collection)
                {
                    string value = ((DevExpress.Web.ASPxTreeList.TreeListNode)item).Key;
                    db.I_MenuYetkileri(Convert.ToInt32(value), roleGuid);
                }
            }
            return roleGuid;
        }
        protected void BayiEditPopup_WindowCallback(object source, DevExpress.Web.PopupWindowCallbackArgs e)
        {
            var roleGuid = e.Parameter.ToString();
            Guid guid = new Guid(roleGuid);
            var list2 = db.S_MenuYetkileri(3, guid).ToList();
            if (list2.Count > 0)
                ASPxTreeList1.DataSource = list2;
            else
                ASPxTreeList1.DataSource = null;

            ASPxTreeList1.DataBind();
            ASPxTreeList1.SettingsSelection.Recursive = true;
            ASPxTreeList1.ExpandToLevel(2);

            foreach (var item in list2.ToList())
            {
                if ((bool)item.Checkbox)
                    ASPxTreeList1.FindNodeByFieldValue("ID", item.ID).Selected = true;
                else
                    ASPxTreeList1.FindNodeByFieldValue("ID", item.ID).Selected = false;
            }

            RoleEditPopup.JSProperties["cpEmployeeID"] = roleGuid;
            RoleEditPopup.JSProperties["cpHeaderText"] = string.Format("Role Düzenle, ({0} {1})", "Guid", roleGuid);
        }
        protected void ASPxTreeList1_DataBinding(object sender, EventArgs e)
        {
            ASPxTreeList1.DataSource = GridUpdating(3);
        }
        public dynamic TestProperty
        {
            get
            {
                return ASPxTreeList1.GetSelectedNodes();
            }
        }
    }
}