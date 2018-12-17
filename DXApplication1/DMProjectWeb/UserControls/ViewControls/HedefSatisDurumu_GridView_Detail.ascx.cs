using DevExpress.Web;
using DevExpress.Web.ASPxPivotGrid;
using DevExpress.XtraCharts;
using DevExpress.XtraCharts.Web;
using DevExpress.XtraPivotGrid;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb.UserControls.ViewControls
{
    public partial class HedefSatisDurumu_GridView_Detail : DetailUserControl
    {
        
        //public override long SelectedItemID
        //{
        //    get
        //    {
        //        //var employeeID = EmployeesGrid.GetRowValues(EmployeesGrid.FocusedRowIndex, EmployeesGrid.KeyFieldName);
        //        return 1;// employeeID != null ? (long)employeeID : 1;// DataProvider.emptyEntryID;
        //    }
        //    set
        //    {
        //        BindGrid();
        //        //EmployeesGrid.FocusedRowIndex = EmployeesGrid.FindVisibleIndexByKeyValue(value);
        //        UpdateDetail();
        //    }
        //}

        DMPortalEntities db = new DMPortalEntities();

        public DateTime _BaslangicTarihi = new DateTime();
        public DateTime _BitisTarihi = new DateTime();

        protected void Page_Load(object sender, EventArgs e)
        {
            PivotGrid.CellTemplate = new CellTemplate();
        }

        //private void BindGrid()
        //{
        //    _BaslangicTarihi = OwnerPage.BaslangicTarihi;
        //    _BitisTarihi = OwnerPage.BitisTarihi;
        //    ProfileBase curProfile = ProfileBase.Create(Membership.GetUser().UserName);
        //    string BayiID = curProfile.GetPropertyValue("BayiID").ToString();
        //    if (Roles.GetRolesForUser(Membership.GetUser().UserName)[0].ToString() == "PersonelYonetici")
        //    {
        //        if (BayiID == null || BayiID == "") //if ile yönetici yetkisi roles dan kontrol edip -1 göndermek lazım.
        //            BayiID = "-1";
        //    }
        //    var listPivot = db.S_HedefSatisDurumuPivot(Convert.ToInt32(BayiID), _BaslangicTarihi, _BitisTarihi).ToList();
        //    if (listPivot.Count > 0)
        //    {
        //        PivotGrid.DataSource = listPivot;
        //        PivotGrid.DataBind();
        //    }
        //    else
        //    {
        //        PivotGrid.DataSource = null;
        //        PivotGrid.DataBind();
        //    }
        //}

        //private void UpdateDetail()
        //{
        //    _BaslangicTarihi = OwnerPage.BaslangicTarihi;
        //    _BitisTarihi = OwnerPage.BitisTarihi;
        //    ProfileBase curProfile = ProfileBase.Create(Membership.GetUser().UserName);
        //    string BayiID = curProfile.GetPropertyValue("BayiID").ToString();
        //    if (Roles.GetRolesForUser(Membership.GetUser().UserName)[0].ToString() == "PersonelYonetici")
        //    {
        //        if (BayiID == null || BayiID == "") //if ile yönetici yetkisi roles dan kontrol edip -1 göndermek lazım.
        //            BayiID = "-1";
        //    }
        //    var listPivot = db.S_HedefSatisDurumuPivot(Convert.ToInt32(BayiID), _BaslangicTarihi, _BitisTarihi).ToList();
        //    if (listPivot.Count > 0)
        //    {
        //        PivotGrid.DataSource = listPivot;
        //        PivotGrid.DataBind();
        //    }
        //    else
        //    {
        //        PivotGrid.DataSource = null;
        //        PivotGrid.DataBind();
        //    }
        //}

        List<S_HedefSatisDurumuPivot_Result> pivotList = new List<S_HedefSatisDurumuPivot_Result>();
        public override void Update()
        {
            _BaslangicTarihi = OwnerPage.BaslangicTarihi;
            _BitisTarihi = OwnerPage.BitisTarihi;
            ProfileBase curProfile = ProfileBase.Create(Membership.GetUser().UserName);
            string BayiID = curProfile.GetPropertyValue("BayiID").ToString();
            if (Roles.GetRolesForUser(Membership.GetUser().UserName)[0].ToString() == "PersonelYonetici")
            {
                if (BayiID == null || BayiID == "" || BayiID == "130" || BayiID == "140") //if ile yönetici yetkisi roles dan kontrol edip -1 göndermek lazım.
                    BayiID = "-1";
            }

            var listPivot = db.S_HedefSatisDurumuPivot(Convert.ToInt32(BayiID), _BaslangicTarihi, _BitisTarihi).ToList();
            if (listPivot.Count > 0)
            {
                PivotGrid.DataSource = listPivot;
                PivotGrid.DataBind();
            }
            else
            {
                PivotGrid.DataSource = null;
                PivotGrid.DataBind();
            }
        }
        
        class CellTemplate : ITemplate
        {
            void ITemplate.InstantiateIn(Control container)
            {
                var cellContainer = (PivotGridCellTemplateContainer)container;
                var field = cellContainer.DataField;
                if (field == null || field.Caption != "Gerçekleşme Yüzdesi")
                {
                    cellContainer.Controls.Add(new LiteralControl(cellContainer.Text));
                    return;
                }
                var table = new Table() { CssClass = "progressBarTable" };
                cellContainer.Controls.Add(table);
                var row = new TableRow();
                table.Rows.Add(row);

                var cell = new TableCell() { CssClass = "progressBarCell" };
                row.Cells.Add(cell);

                var val = Convert.ToDecimal(cellContainer.Value) * 100;
                cell.Controls.Add(new ASPxProgressBar()
                {
                    Width = Unit.Percentage(100),
                    Height = 10,
                    Value = val,
                    ShowPosition = false
                });

                cell = new TableCell() { CssClass = "progressValueCell", Text = string.Format("{0:N}%", val) };
                row.Cells.Add(cell);
            }
        }






    }
}