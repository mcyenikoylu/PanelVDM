using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Utils;
using DevExpress.XtraCharts;
using DevExpress.XtraCharts.Web;
using DevExpress.Web;
using DevExpress.Pdf;
public abstract class BasePage : System.Web.UI.Page
{
    public abstract string PageName { get; }
    public virtual bool ContentHasScroll { get { return false; } }
    public virtual bool ContentHasBorder { get { return true; } }
    public virtual void SaveEditFormChanges(string args) { }
    public virtual void DeleteEntry(string args) { }
}

public abstract class MasterDetailPage : BasePage
{
    public abstract MasterUserControl MasterUC { get; }
    public abstract DetailUserControl DetailUC { get; }
    public int SelectedItemID { get { return MasterUC.SelectedItemID; } }
    public Guid SelectedItemGuid { get { return MasterUC.SelectedItemGuid; } } // MCY kullanici kayıt ekranı id almadığı için ekledim.
    public DateTime BaslangicTarihi { get { return MasterUC.BaslangicTarihi; } }
    public DateTime BitisTarihi { get { return MasterUC.BitisTarihi; } }
    public string AramaKelimesi { get { return MasterUC.AramaKelimesi; } }
    public void Update()
    {
        MasterUC.Update(); // should force update detail
    }
    public virtual void UpdateDetail()
    {
        if (DetailUC != null)
            DetailUC.Update();
    }
}
public abstract class MasterUserControl : ViewUserControl
{
    public new MasterDetailPage OwnerPage { get { return Page as MasterDetailPage; } }

    protected virtual void UpdateDetail()
    {
        OwnerPage.UpdateDetail();
    }
}
public abstract class DetailUserControl : ViewUserControl
{
    public new MasterDetailPage OwnerPage { get { return Page as MasterDetailPage; } }
    public override int SelectedItemID { get { return OwnerPage.SelectedItemID; } set { } }
    public override Guid SelectedItemGuid { get { return OwnerPage.SelectedItemGuid; } } //MCY kullanici kayıt ekranı id almadığı için ekledim.
    public override DateTime BaslangicTarihi { get { return OwnerPage.BaslangicTarihi; } set { } }
    public override DateTime BitisTarihi { get { return OwnerPage.BitisTarihi; } set { } }
    public override String AramaKelimesi { get { return OwnerPage.AramaKelimesi; } set { } }
}

public abstract class ViewUserControl : UserControl
{
    public abstract void Update();

    public BasePage OwnerPage { get { return Page as BasePage; } }
    public virtual int SelectedItemID { get; set; }

    public virtual Guid SelectedItemGuid { get; set; } // MCY kullanici kayıt ekranı id almadığı için ekledim.

    //protected FilterBag Filter { get { return OwnerPage.FilterBag; } }

    public virtual DateTime BaslangicTarihi { get; set; }
    public virtual DateTime BitisTarihi { get; set; }
    public virtual String AramaKelimesi { get; set; }
}

public abstract class EditFormUserControl : UserControl
{
    public abstract int SaveChanges(string args);
    public abstract Guid SaveChangesKullanici(string args);
}

public abstract class EditFormViewUserControl : ViewUserControl
{
    public new MasterDetailPage OwnerPage { get { return Page as MasterDetailPage; } }
    public abstract int SaveChanges(string args);
    public abstract Guid SaveChangesKullanici(string args);
    public override int SelectedItemID { get { return OwnerPage.SelectedItemID; } set { } }
    public override Guid SelectedItemGuid { get { return OwnerPage.SelectedItemGuid; } }
}

//public abstract class ChartUserControl : UserControl
//{
//    public abstract WebChartControl Chart { get; }

//    public virtual long SelectedItemID { get; set; }
//    protected void ChangeChartWidth(int width)
//    {
//        Chart.Width = Unit.Pixel(width < 500 ? width : 500);
//        Chart.Series[0].LabelsVisibility = width < 375 ? DefaultBoolean.False : DefaultBoolean.True;
//    }
//    protected void OnCustomDrawSeriesPoint(CustomDrawSeriesPointEventArgs e)
//    {
//        e.LegendText = e.SeriesPoint.Argument.ToString();
//        var legendImage = new Bitmap(11, 11);
//        using (var graphics = Graphics.FromImage(legendImage))
//        {
//            graphics.FillRectangle(new LinearGradientBrush(new Rectangle(new Point(), legendImage.Size),
//                e.LegendDrawOptions.Color, e.LegendDrawOptions.ActualColor2, LinearGradientMode.BackwardDiagonal),
//                new Rectangle(new Point(), legendImage.Size));
//        }
//        e.LegendMarkerImage = legendImage;
//    }
//}
