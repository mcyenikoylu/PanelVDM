using DevExpress.XtraBars;
using DevExpress.XtraBars.Ribbon;
using DevExpress.XtraEditors;
using DevExpress.XtraTabbedMdi;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace DMProject
{
    public partial class AnaForm : DevExpress.XtraBars.Ribbon.RibbonForm
    {
        public AnaForm()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            this.Ribbon.MdiMergeStyle = RibbonMdiMergeStyle.Always;
            xtraTabbedMdiManager1.ClosePageButtonShowMode = DevExpress.XtraTab.ClosePageButtonShowMode.InActiveTabPageHeaderAndOnMouseHover;
            xtraTabbedMdiManager1.HeaderButtons = DevExpress.XtraTab.TabButtons.Prev;
            xtraTabbedMdiManager1.HeaderButtons = DevExpress.XtraTab.TabButtons.Next;
            xtraTabbedMdiManager1.HeaderButtonsShowMode = DevExpress.XtraTab.TabButtonShowMode.Always;
            xtraTabbedMdiManager1.HeaderLocation = DevExpress.XtraTab.TabHeaderLocation.Bottom;
        }

        private void btnExcelAktarim_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            BenimMenumItemClickMethod(e, "ExcelAktarim");

        }

        private void btnProgramiKapat_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            try
            {
             
                    if (XtraMessageBox.Show("Programı kapatmak istediğinize emin misiniz?", "Onay", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.Yes)
                    {
                        Application.Exit();
                    }
                  
                
            }
            catch (Exception Hata)
            {

            }
        }

        private void btnProgramBilgi_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            XtraMessageBox.Show("Yapım Aşamasında!", "Uyarı", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);

        }

        private void BenimMenumItemClickMethod(ItemClickEventArgs e, string FormAdi)
        {
            try
            {
                RibbonForm f = FormBul(FormAdi);
                if (MDIFormAcikMi(f))
                {
                    XtraMdiTabPage page = FindPageByText(f.Text);
                    xtraTabbedMdiManager1.SelectedPage = page;
                    ribbonControl1.HideApplicationButtonContentControl();
                    return;
                }
                ribbonControl1.HideApplicationButtonContentControl();
                f.Ribbon.MdiMergeStyle = RibbonMdiMergeStyle.Always;
                f.MdiParent = this;
                f.Show();
                ribbonControl1.SelectedPage = f.Ribbon.Pages[0];
            }
            catch (Exception Hata)
            {
                //Genel.LogErrorYaz(iFormID, Hata);
                //XtraMessageBox.Show(Genel.DilGetirMesaj(1034) + "\n\n" + Hata.Message, Genel.DilGetirMesaj(2), MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        private RibbonForm FormBul(string FormAdi)
        {
            try
            {
                if (FormAdi == "") return null;
                FormAdi = FormAdi.Replace(" ", "");
                string FormTypeFullName = string.Format("{0}.{1}", this.GetType().Namespace, FormAdi.Trim().Replace("ı", "i"));
                Type type = Type.GetType(FormTypeFullName.Trim(), true);
                RibbonForm frm = (RibbonForm)Activator.CreateInstance(type);
                return frm;
            }
            catch (Exception Hata)
            {
                //Genel.LogErrorYaz(iFormID, Hata);
                //XtraMessageBox.Show(Genel.DilGetirMesaj(1034) + "\n\n" + Hata.Message, Genel.DilGetirMesaj(2), MessageBoxButtons.OK, MessageBoxIcon.Error);
                return null;
            }
        }
        private bool MDIFormAcikMi(XtraForm frm)
        {
            try
            {
                Form AcikFormlar = Application.OpenForms[frm.Name];
                if (AcikFormlar == null)
                    return false;
                else
                    return true;
            }
            catch (Exception Hata)
            {
                //Genel.LogErrorYaz(iFormID, Hata);
                //XtraMessageBox.Show(Genel.DilGetirMesaj(1034) + "\n\n" + Hata.Message, Genel.DilGetirMesaj(2), MessageBoxButtons.OK, MessageBoxIcon.Error);
                return true;
            }
        }
        private XtraMdiTabPage FindPageByText(string pageText)
        {
            foreach (XtraMdiTabPage page in xtraTabbedMdiManager1.Pages)
            {
                if (page.MdiChild.Text == pageText)
                    return page;
            }
            return null;
        }

        private void AnaForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            try
            {
                if (e == null || e.CloseReason == CloseReason.UserClosing)
                {
                    if (XtraMessageBox.Show("Programı kapatmak istediğinize emin misiniz?", "Onay", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.Yes)
                    {
                        Application.Exit();
                    }
                    else if (e != null)
                        e.Cancel = true;
                }
            }
            catch (Exception Hata)
            {

            }
        }
    }
}
