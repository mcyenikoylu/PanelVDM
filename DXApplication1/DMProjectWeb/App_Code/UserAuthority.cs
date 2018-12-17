using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace DMProjectWeb.Class
{
    public static class UserAuthority
    {
        static HttpSessionState Session { get { return HttpContext.Current.Session; } }

        static DataObject Data
        {
            get
            {
                const string key = "BA18EA5F-5BAD-4538-9A21-6C1012FE68BF"; // "FB1EB35F-86F5-4FFE-BB23-CBAAF1514C49";
                if (Session[key] == null)
                {
                    var obj = new DataObject();
                    obj.FillObj();
                    Session[key] = obj;
                }
                return (DataObject)Session[key];
            }
        }

        public static List<YetkisizMenuListesi> GetYetkisizMenuler()
        {
            return Data.YetkisizMenuler;
        }


    }

    public class DataObject
    {
        DMPortalEntities db = new DMPortalEntities();
        public List<YetkisizMenuListesi> YetkisizMenuler { get; set; }
        public void FillObj()
        {
            Guid UserGUID = new Guid(Membership.GetUser().ProviderUserKey.ToString());

            YetkisizMenuler = new List<YetkisizMenuListesi>();

            //var yetkisizMenuList = db.S_KullaniciYetkisizMenuleri(UserGUID).ToList();
            //if (yetkisizMenuList.Count > 0)
            //{
            //    foreach (var item in yetkisizMenuList)
            //    {
            //        var c = new YetkisizMenuListesi
            //        {
            //            ID = item.ID,
            //            MenuAdi = item.MenuAdi,
            //            NavBarIndex = Convert.ToInt32(item.NavBarIndex),
            //            NavBarGroupIndex = Convert.ToInt32(item.NavBarGroupIndex),
            //        };
            //        YetkisizMenuler.Add(c);
            //    }
            //}
        }
    }

    public class YetkisizMenuListesi
    {
        public int ID { get; set; }
        public string MenuAdi { get; set; }
        public int NavBarIndex { get; set; }
        public int NavBarGroupIndex { get; set; }
    }
}