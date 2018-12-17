using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.ViewControls
{
    public partial class Dokumanlar_GridView_Master : MasterUserControl
    {
        DMPortalEntities db = new DMPortalEntities();

        protected void Page_Load(object sender, EventArgs e)
        {
            Update();
            EmployeesGrid.DataBind();
        }

        public override void Update()
        {
            BindGrid();
            UpdateDetail();
        }

        protected void BindGrid()
        {

        }
        protected List<S_Dokumanlar_Result> GridUpdating()
        {
            var list = db.S_Dokumanlar(-1).Where(c => c.DokumanTipi_TipID5 == 11).ToList();
            if (list.Count > 0)
                return list;
            else
                return null;
        }
        protected void downloadButton_Click(object sender, EventArgs e)
        {
            ASPxButton button = (ASPxButton)sender;
            GridViewDataItemTemplateContainer container = button.NamingContainer as GridViewDataItemTemplateContainer;
            int visibleIndex = container.VisibleIndex;
            string text = container.Grid.GetRowValues(visibleIndex, "ID").ToString();
            var list = db.S_Dokumanlar(Convert.ToInt32(text)).ToList();
            if (list.Count > 0)
            {
                SendFile(list.FirstOrDefault().DosyaAdi);
            }
        }
        private void SendFile(string param)
        {
            string fileName = "Docs/" + param;
            string filePath = Server.MapPath(fileName);
            if (!File.Exists(filePath))
            {
                Response.SuppressContent = false;
                Response.Write("Dosya bulunamadı.");
                Response.End();
                return;
            }
            string[] split = param.Split('.');
            if (split[1].ToString() == "pdf")
                Response.ContentType = "application/pdf";
            //if (split[1].ToString() == "xls")
            //    Response.ContentType = "application/xls";
            //if (split[1].ToString() == "xlsx")
            //    Response.ContentType = "application/xlsx";
            //if (split[1].ToString() == "doc")
            //    Response.ContentType = "application/doc";
            //if (split[1].ToString() == "docx")
            //    Response.ContentType = "application/docx";

            Response.AddHeader("Content-Disposition", "attachment; filename=" + param);
            Response.TransmitFile(filePath);
            Response.End();
        }

        protected void EmployeesGrid_DataBinding(object sender, EventArgs e)
        {
            EmployeesGrid.DataSource = GridUpdating();

        }

   
    }
}