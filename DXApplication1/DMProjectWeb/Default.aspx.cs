using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DMProjectWeb {
    public partial class _Default : MasterDetailPage
    {
        MasterUserControl masterUC;
        DetailUserControl detailUC;

        public override string PageName { get { return "Default"; } }

        public override MasterUserControl MasterUC { get { return masterUC; } }
        public override DetailUserControl DetailUC { get { return detailUC; } }

        protected void Page_Load(object sender, EventArgs e) {
            Response.Redirect("Widgets.aspx");
        }

        protected string GetClientButtonClickHandler(RepeaterItem container)
        {
            return string.Format("function(s, e) {{ ShowWidgetPanel('{0}') }}", container.DataItem);
        }

    }
}