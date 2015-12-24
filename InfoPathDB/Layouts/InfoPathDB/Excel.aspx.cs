using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;

namespace InfoPathDB.Layouts.InfoPathDB
{
    public partial class Excel : LayoutsPageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //create IQY and transmit over HTTP
            string destinationUrl = Request["destinationURL"];
            Response.Clear();
            Response.ClearContent();
            Response.AppendHeader("Content-Type", "text/x-ms-iqy; charset=UTF-8");
            Response.AppendHeader("Content-Disposition", "attachment; filename=InfoPathDB.iqy");
            Response.Write("WEB\r\n1\r\n" + destinationUrl + "\r\n\r\nSelection=\r\nFormatting=None\r\nPreFormattedTextToColumns=True\r\nConsecutiveDelimitersAsOne=True\r\nSingleBlockTextImport=False\r\nDisableDateRecognition=False\r\nDisableRedirections=False\r\n");
            Response.End();
        }
    }
}
