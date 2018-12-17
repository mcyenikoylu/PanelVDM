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
    public partial class KullaniciTanimlari_GridView_Detail : DetailUserControl
    {
        DMPortalEntities db = new DMPortalEntities();
        public override void Update()
        {
            var employee = Membership.GetAllUsers().Cast<MembershipUser>().Where(c => c.ProviderUserKey.ToString() == SelectedItemGuid.ToString()).FirstOrDefault();
            if (employee == null)
                return;

            ProfileBase curProfile = ProfileBase.Create(employee.UserName);
            string resimadi = curProfile.GetPropertyValue("ResimAdi").ToString();
            EmployeeImage.ImageUrl = "../../Images/UploadPersonel/" + resimadi;

            DetailsHeaderHeadLine.HeaderText = string.Format("{0} {1}", curProfile.GetPropertyValue("Ismi").ToString(), curProfile.GetPropertyValue("Soyismi").ToString());
            DetailsHeaderHeadLine.ContentText = employee.UserName;
            DetailsAddressText.InnerHtml = curProfile.GetPropertyValue("BayiKodu").ToString();
            DetailsPhoneText.InnerHtml = curProfile.GetPropertyValue("CepNumarasi").ToString();
            DetailsEmailText.InnerHtml = employee.Email;

            ////    EditImage.JSProperties["cpEmployeeID"] = list.First().ID;
            ////    DetailsHeaderHeadLine.NavigateUrl = string.Format("javascript:ShowEmployeeEditForm('{0}')", list.First().ID);
        }
    }
}