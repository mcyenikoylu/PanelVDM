using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.ViewControls
{
    public partial class BayiTanimlari_GridView_Detail : DetailUserControl
    {
        DMPortalEntities db = new DMPortalEntities();
        public override void Update()
        {
            int id = Convert.ToInt32(SelectedItemID);
            var list = db.S_Bayi(Convert.ToInt32(id)).ToList();
            if(list.Count>0)
            {
                //DetailsPageControl.Visible = true;

                EmployeeImage.ImageUrl = "../../Images/UploadBayi/" + list.First().ResimAdi != null ? "../../Images/UploadBayi/DefaultBayi.jpg" : "../../Images/UploadBayi/" + list.First().ResimAdi;// string.Empty;// DemoUtils.ImageLoader.EmployeeImageVirtPath(employee.Id);
                //EditImage.JSProperties["cpEmployeeID"] = list.First().ID;

                DetailsHeaderHeadLine.NavigateUrl = string.Format("javascript:ShowEmployeeEditForm('{0}')", list.First().ID);
                DetailsHeaderHeadLine.HeaderText = string.Format("{0} {1}", list.First().BayiAdi, ""); //employee.LastName
                DetailsHeaderHeadLine.ContentText = list.First().YetkiliAdiSoyadi;

                //var address = list.First().Adres;
                DetailsAddressText.InnerHtml = list.First().Adres + "<br />" + list.First().SehirAdi + ", " + list.First().IlceAdi + ", " + list.First().SemtAdi;
                DetailsPhoneText.InnerHtml = list.First().Telefon;
                DetailsEmailText.InnerHtml = list.First().Mail;
            }
            else
            {
                //DetailsPageControl.Visible = false;
                EmployeeImage.ImageUrl = string.Empty;

                DetailsHeaderHeadLine.HeaderText = "None";
                DetailsHeaderHeadLine.ContentText = "None";

                DetailsAddressText.InnerHtml = "None";
                DetailsPhoneText.InnerHtml = "None";
                DetailsEmailText.InnerHtml = "None";
            }

        }
    }
}