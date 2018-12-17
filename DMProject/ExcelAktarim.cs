using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using DevExpress.XtraBars;

namespace DMProject
{
    public partial class ExcelAktarim : DevExpress.XtraBars.Ribbon.RibbonForm
    {
        public ExcelAktarim()
        {
            InitializeComponent();
        }

        private void ExcelAktarim_Load(object sender, EventArgs e)
        {

        }

        private DataSet ex = new DataSet();
        private string filename = "";
        private void txtDosya1_ButtonClick(object sender, DevExpress.XtraEditors.Controls.ButtonPressedEventArgs e)
        {
            //Sabit Hizmetler Raporu
            OpenFileDialog file = new OpenFileDialog();
            if (file.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                string name = file.FileName;
                txtDosya1.Text = name;
                filename = name;
                ex = ExcelImport.ToDataSet(name, false);

            }
        }

        private void txtDosya2_ButtonClick(object sender, DevExpress.XtraEditors.Controls.ButtonPressedEventArgs e)
        {
            //Kampanyalı Cihazlar Raporu

        }

        private void txtDosya3_ButtonClick(object sender, DevExpress.XtraEditors.Controls.ButtonPressedEventArgs e)
        {
            //Kanal Gross Addition Raporu

        }
    }
}