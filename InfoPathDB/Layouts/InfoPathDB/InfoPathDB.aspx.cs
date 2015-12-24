using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;

namespace InfoPathDB.Layouts.InfoPathDB
{
    public partial class InfoPathDB : LayoutsPageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //first load only
            if (!Page.IsPostBack)
            {
                using (SPSite site = new SPSite(SPContext.Current.Web.Url))
                {
                    using (SPWeb web = site.OpenWeb())
                    {
                        //initialize
                        foreach (SPList l in web.Lists)
                        {
                            if (l.BaseTemplate == SPListTemplateType.XMLForm) FormLibraryTitle.Items.Add(l.Title);
                        }
                    }
                }
            }
            //share current Web URL with client JS functions
            Uri app = new Uri(SPContext.Current.Web.Url);
            textWebUrl.Text = app.ToString();
            textWebAppUrl.Text = (app.Scheme + Uri.SchemeDelimiter + app.Host + ":" + app.Port).Replace(":80","");
        }
    }
}
