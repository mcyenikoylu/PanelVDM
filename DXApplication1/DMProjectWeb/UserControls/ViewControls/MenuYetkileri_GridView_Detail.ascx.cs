using DevExpress.Web.ASPxTreeList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.ViewControls
{
    public partial class MenuYetkileri_GridView_Detail : DetailUserControl
    {
        DMPortalEntities db = new DMPortalEntities();
        public override void Update()
        {
            //ASPxTreeList1.DataBind();
            //ASPxTreeList1.SettingsSelection.Recursive = true;
            //ASPxTreeList1.ExpandToLevel(2);
          
            //foreach (var item in GridUpdating(3).ToList())
            //{
            //    if ((bool)item.Checkbox)
            //        ASPxTreeList1.FindNodeByFieldValue("ID", item.ID).Selected = true;
            //    else
            //        ASPxTreeList1.FindNodeByFieldValue("ID", item.ID).Selected = false;
            //}
        }
        //public dynamic TestProperty
        //{
        //    get
        //    {
        //        return ASPxTreeList1.GetSelectedNodes();
        //    }
        //}
      
        //protected List<S_MenuYetkileri_Result> GridUpdating(int islemtipi)
        //{
        //    var list2 = db.S_MenuYetkileri(islemtipi, SelectedItemGuid).ToList();
        //    if (list2.Count > 0)
        //    {
        //        return list2;
        //    }
        //    else
        //        return null;
        //}
        protected void ASPxTreeList1_DataBinding(object sender, EventArgs e)
        {
            //ASPxTreeList1.DataSource = GridUpdating(3);
        }

               ////button click iptal edilip Update() eventine taşınabilir.
            //var collection = TestProperty;
            //foreach (var item in collection)
            //{
            //    string value = ((DevExpress.Web.ASPxTreeList.TreeListNode)item).Key;
            //    db.I_MenuYetkileri(Convert.ToInt32(value), SelectedItemGuid);
            //}

    }
}