namespace DMProject
{
    partial class AnaForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(AnaForm));
            this.ribbonControl1 = new DevExpress.XtraBars.Ribbon.RibbonControl();
            this.btnProgramiKapat = new DevExpress.XtraBars.BarButtonItem();
            this.btnProgramBilgi = new DevExpress.XtraBars.BarButtonItem();
            this.btnExcelAktarim = new DevExpress.XtraBars.BarButtonItem();
            this.ribbonPage1 = new DevExpress.XtraBars.Ribbon.RibbonPage();
            this.ribbonPageGroup1 = new DevExpress.XtraBars.Ribbon.RibbonPageGroup();
            this.ribbonPageGroup2 = new DevExpress.XtraBars.Ribbon.RibbonPageGroup();
            this.ribbonStatusBar1 = new DevExpress.XtraBars.Ribbon.RibbonStatusBar();
            this.xtraTabbedMdiManager1 = new DevExpress.XtraTabbedMdi.XtraTabbedMdiManager(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.ribbonControl1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.xtraTabbedMdiManager1)).BeginInit();
            this.SuspendLayout();
            // 
            // ribbonControl1
            // 
            this.ribbonControl1.ExpandCollapseItem.Id = 0;
            this.ribbonControl1.Items.AddRange(new DevExpress.XtraBars.BarItem[] {
            this.ribbonControl1.ExpandCollapseItem,
            this.btnProgramiKapat,
            this.btnProgramBilgi,
            this.btnExcelAktarim});
            this.ribbonControl1.Location = new System.Drawing.Point(0, 0);
            this.ribbonControl1.MaxItemId = 6;
            this.ribbonControl1.Name = "ribbonControl1";
            this.ribbonControl1.Pages.AddRange(new DevExpress.XtraBars.Ribbon.RibbonPage[] {
            this.ribbonPage1});
            this.ribbonControl1.RibbonStyle = DevExpress.XtraBars.Ribbon.RibbonControlStyle.Office2007;
            this.ribbonControl1.Size = new System.Drawing.Size(840, 143);
            this.ribbonControl1.StatusBar = this.ribbonStatusBar1;
            // 
            // btnProgramiKapat
            // 
            this.btnProgramiKapat.Caption = "Programı Kapat";
            this.btnProgramiKapat.Glyph = ((System.Drawing.Image)(resources.GetObject("btnProgramiKapat.Glyph")));
            this.btnProgramiKapat.Id = 1;
            this.btnProgramiKapat.LargeGlyph = ((System.Drawing.Image)(resources.GetObject("btnProgramiKapat.LargeGlyph")));
            this.btnProgramiKapat.Name = "btnProgramiKapat";
            this.btnProgramiKapat.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnProgramiKapat_ItemClick);
            // 
            // btnProgramBilgi
            // 
            this.btnProgramBilgi.Caption = "Bilgi";
            this.btnProgramBilgi.Glyph = ((System.Drawing.Image)(resources.GetObject("btnProgramBilgi.Glyph")));
            this.btnProgramBilgi.Id = 3;
            this.btnProgramBilgi.LargeGlyph = ((System.Drawing.Image)(resources.GetObject("btnProgramBilgi.LargeGlyph")));
            this.btnProgramBilgi.Name = "btnProgramBilgi";
            this.btnProgramBilgi.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnProgramBilgi_ItemClick);
            // 
            // btnExcelAktarim
            // 
            this.btnExcelAktarim.Caption = "Vodafone Excel Entegrasyon";
            this.btnExcelAktarim.Glyph = ((System.Drawing.Image)(resources.GetObject("btnExcelAktarim.Glyph")));
            this.btnExcelAktarim.Id = 4;
            this.btnExcelAktarim.LargeGlyph = ((System.Drawing.Image)(resources.GetObject("btnExcelAktarim.LargeGlyph")));
            this.btnExcelAktarim.Name = "btnExcelAktarim";
            this.btnExcelAktarim.ItemClick += new DevExpress.XtraBars.ItemClickEventHandler(this.btnExcelAktarim_ItemClick);
            // 
            // ribbonPage1
            // 
            this.ribbonPage1.Groups.AddRange(new DevExpress.XtraBars.Ribbon.RibbonPageGroup[] {
            this.ribbonPageGroup1,
            this.ribbonPageGroup2});
            this.ribbonPage1.Name = "ribbonPage1";
            this.ribbonPage1.Text = "Ana Menü";
            // 
            // ribbonPageGroup1
            // 
            this.ribbonPageGroup1.ItemLinks.Add(this.btnExcelAktarim);
            this.ribbonPageGroup1.Name = "ribbonPageGroup1";
            this.ribbonPageGroup1.Text = "Genel";
            // 
            // ribbonPageGroup2
            // 
            this.ribbonPageGroup2.ItemLinks.Add(this.btnProgramBilgi);
            this.ribbonPageGroup2.ItemLinks.Add(this.btnProgramiKapat);
            this.ribbonPageGroup2.Name = "ribbonPageGroup2";
            this.ribbonPageGroup2.Text = "Program";
            // 
            // ribbonStatusBar1
            // 
            this.ribbonStatusBar1.Location = new System.Drawing.Point(0, 580);
            this.ribbonStatusBar1.Name = "ribbonStatusBar1";
            this.ribbonStatusBar1.Ribbon = this.ribbonControl1;
            this.ribbonStatusBar1.Size = new System.Drawing.Size(840, 31);
            // 
            // xtraTabbedMdiManager1
            // 
            this.xtraTabbedMdiManager1.MdiParent = this;
            // 
            // AnaForm
            // 
            this.AllowFormGlass = DevExpress.Utils.DefaultBoolean.False;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(840, 611);
            this.Controls.Add(this.ribbonStatusBar1);
            this.Controls.Add(this.ribbonControl1);
            this.IsMdiContainer = true;
            this.Name = "AnaForm";
            this.Ribbon = this.ribbonControl1;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.StatusBar = this.ribbonStatusBar1;
            this.Text = "Dağıtım Merkezi";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.AnaForm_FormClosing);
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.ribbonControl1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.xtraTabbedMdiManager1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraBars.Ribbon.RibbonControl ribbonControl1;
        private DevExpress.XtraBars.Ribbon.RibbonPage ribbonPage1;
        private DevExpress.XtraBars.Ribbon.RibbonPageGroup ribbonPageGroup1;
        private DevExpress.XtraBars.BarButtonItem btnProgramiKapat;
        private DevExpress.XtraBars.BarButtonItem btnProgramBilgi;
        private DevExpress.XtraBars.Ribbon.RibbonPageGroup ribbonPageGroup2;
        private DevExpress.XtraBars.BarButtonItem btnExcelAktarim;
        private DevExpress.XtraBars.Ribbon.RibbonStatusBar ribbonStatusBar1;
        private DevExpress.XtraTabbedMdi.XtraTabbedMdiManager xtraTabbedMdiManager1;
    }
}

