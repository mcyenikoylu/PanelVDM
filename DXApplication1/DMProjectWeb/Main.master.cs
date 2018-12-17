using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb
{
    public partial class MainMaster : System.Web.UI.MasterPage
    {

        DMPortalEntities db = new DMPortalEntities();

        protected BasePage BasePage { get { return Page as BasePage; } }

        protected void Page_Init(object sender, EventArgs e)
        {
            SetupPage();
        }

        public void SetupPage()
        {
            //BasePage.Title = BasePage.PageName + " - DevAV Demo | ASP.NET Controls by DevExpress";

            List<S_MenuNavigation_Result> MenuListesi;
            List<S_MenuNavigation_Result> MenuListesiAll;
            if (Membership.GetUser() != null) //master page ilk yüklendiði zaman boþ geliyor. menü listesi null olmasýn diye kontrol ediyorum.
            {
                Guid UserGUID = new Guid(Membership.GetUser().ProviderUserKey.ToString());
                MenuListesi = db.S_MenuNavigation(UserGUID).ToList();
                ProfileBase curProfile = ProfileBase.Create(Membership.GetUser().UserName);
                string loginName = "(" + curProfile.GetPropertyValue("BayiKodu").ToString() + ")";
                loginName += " " + curProfile.GetPropertyValue("BayiCariAdi").ToString();
                loginName += ", " + curProfile.GetPropertyValue("Ismi").ToString();
                loginName += " " + curProfile.GetPropertyValue("Soyismi").ToString();
                lblHosgeldin.Text = loginName;
            }
            else
                MenuListesi = null;

            string ustSayfaAdi = "";
            string altSayfaAdi = BasePage.PageName;

            if (MenuListesi != null && MenuListesi.Count > 0)
            {
                var a = MenuListesi.Where(c => c.Name == altSayfaAdi).ToList().Count > 0 ? MenuListesi.Where(c => c.Name == altSayfaAdi).FirstOrDefault().ParentID.Value : -1;
                if (a < 0)
                {
                    MenuListesiAll = db.S_MenuNavigation(null).ToList();
                    if (MenuListesiAll.Count > 0)
                    {
                        int _ParentID = MenuListesiAll.Where(c => c.Name == altSayfaAdi).First().ParentID.Value;
                        var linklist = MenuListesiAll.Where(c => c.ParentID == _ParentID).ToList();
                        if (linklist.Count > 0)
                        {
                            ustSayfaAdi = MenuListesi.Where(c => c.ParentID == _ParentID).FirstOrDefault().Name;
                        }
                    }
                }
                else
                {
                    //alt sayfa adýndan üst sayfa adýný buluyorum. alt tarafdaki kodlarda kullanmak için.
                    int parentId = MenuListesi.Where(c => c.Name == altSayfaAdi).FirstOrDefault().ParentID.Value;
                    ustSayfaAdi = MenuListesi.Where(c => c.ID == parentId).FirstOrDefault().Name;
                }
                //ana manü yükleniyor.
                var MenuAnaListesi = MenuListesi.Where(c => c.ParentID == 1).ToList();
                if (MenuAnaListesi.Count > 0)
                {
                    foreach (var item in MenuAnaListesi)
                    {
                        NavigationMenu.Items[0].Items.Add(item.Text, item.Name, "", item.NavigateURL);
                    }
                }

                //menü deki resimleri dinamik olarak ekliyor.
                if (a < 0)
                {
                    MenuListesiAll = db.S_MenuNavigation(null).ToList();
                    var linklist = MenuListesiAll.Where(c => c.Name == ustSayfaAdi).ToList();
                    int parentid = linklist.FirstOrDefault().ParentID.Value;
                    string _ustSayfaAdi = MenuListesi.Where(c => c.ID == parentid).FirstOrDefault().Name;
                    NavigationMenu.Items[0].Image.Url = string.Format("~/Content/Images/LogoMenuIcons/{0}.png", _ustSayfaAdi);
                }
                else
                {
                    NavigationMenu.Items[0].Image.Url = string.Format("~/Content/Images/LogoMenuIcons/{0}.png", ustSayfaAdi);
                }
                NavigationMenu.Items[0].SubMenuStyle.CssClass = "navigationPopupMenu";
                NavigationMenu.Items[0].PopOutImage.Url = "Content/Images/LogoMenuIcons/PopOutIcon.png";

                //anasayfa adýný bulmasý için yaptým. bulamadýðý zaman ana menüdeki bulunduðu sayfanýn adýný kýrmýzý seçili þekilde yapamýyordu.
                int menuSelectedIndex = 0;
                if (ustSayfaAdi != null)
                {
                    foreach (var item in MenuAnaListesi)
                    {
                        if (a < 0)
                        {
                            var list = MenuListesi.Where(c => c.Name == ustSayfaAdi).ToList();
                            int parentid = list.FirstOrDefault().ParentID.Value;
                            if (item.ID == parentid)
                            {
                                NavigationMenu.Items[0].Items[menuSelectedIndex].Selected = true;
                            }
                            menuSelectedIndex++;
                        }
                        else
                        {
                            if (item.Name == ustSayfaAdi)
                            {
                                NavigationMenu.Items[0].Items[menuSelectedIndex].Selected = true;
                            }
                            menuSelectedIndex++;
                        }
                    }
                }

                SplitterPane contentPane = Splitter.GetPaneByName("MainContentPane");
                if (contentPane != null)
                {
                    contentPane.ScrollBars = BasePage.ContentHasScroll ? ScrollBars.Auto : ScrollBars.None;
                    contentPane.PaneStyle.CssClass = BasePage.ContentHasBorder ? "mainContentPane frame" : "mainContentPane";
                }
                //ReadOnlyPopup.Visible = DemoUtils.IsSiteMode;

                //NavBar yükleniyor.
                int anaMenuId = -1;
                if (a < 0)
                {
                    MenuListesiAll = db.S_MenuNavigation(null).ToList();
                    if (MenuListesiAll.Count > 0)
                    {
                        anaMenuId = MenuListesiAll.Where(c => c.Name == altSayfaAdi).First().ParentID.Value;
                    }
                }
                else
                {
                    anaMenuId = MenuListesi.Where(c => c.Name == altSayfaAdi).FirstOrDefault().ParentID.Value;
                }
                var MenuNavBarListesi = MenuListesi.Where(c => c.ParentID == anaMenuId).ToList();
                if (MenuNavBarListesi.Count > 0)
                {
                    NavigationBarMenu.Groups.Add("MENU", ustSayfaAdi);

                    foreach (var item in MenuNavBarListesi)
                    {
                        NavigationBarMenu.Groups[0].Items.Add(item.Text, item.Name, "", item.NavigateURL);
                    }
                }
                //Filtre grubu þimdilik iptal ettim. ileriki zamanlarda ekleyeceðim.
                //NavigationBarMenu.Groups.Add("FAVORÝ FÝLTRELER", "Favorites");
                //NavigationBarMenu.Groups[1].Items.Add("Bu Ay", "BuAy", "", "#");
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void MainCallbackPanel_Callback(object sender, CallbackEventArgsBase e)
        {
            var args = DemoUtils.DeserializeCallbackArgs(e.Parameter);
            if (args.Count == 0)
                return;
            if (args[0] == "SaveEditForm")
                BasePage.SaveEditFormChanges(args[2]);
            if (args[0] == "DeleteEntry")
                BasePage.DeleteEntry(args[1]);
            //if (args[0] == "FilterChanged")
            //{
            //    FilterBag.FilterControlExpression = args[1];
            //    UpdateFilterControlExpression();
            //    MainCallbackPanel.JSProperties["cpSelectedFilterNavBarItemName"] = FilterBag.GetActiveFilterName();
            //    BasePage.OnFilterChanged();
            //}
        }

        protected void HiddenField_Init(object sender, EventArgs e)
        {
            DemoUtils.RegisterStateHiddenField(HiddenField);
        }

        protected void ToolbarMenuDataSource_Init(object sender, EventArgs e)
        {
            ToolbarMenuDataSource.XPath = string.Format("Pages/{0}/Item", BasePage.PageName);
        }

        protected void HeadLoginStatus_LoggedOut(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            FormsAuthentication.RedirectToLoginPage();
        }

        protected void EditMessagePopup_CustomJSProperties(object sender, CustomJSPropertiesEventArgs e)
        {
            e.Properties["cpEmployeeEditMessageTemplate"] = EmployeeEditMessageTemplate;
            e.Properties["cpEditMessageTemplate"] = EditMessageTemplate;
        }
        protected string EmployeeEditMessageTemplate { get { return "Bu web uygulamasý <<Operation>> kayýtlarýnýn veritabanýna girilmesine izin vermiyor."; } }
        protected string EditMessageTemplate { get { return EmployeeEditMessageTemplate + " To see how DevExpress ASP.NET Controls can help you build amazing data entry forms, navigate to the Employees Module."; } }


    }
}