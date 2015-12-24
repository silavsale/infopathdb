using System;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Xml;
using System.Diagnostics;
using Microsoft.SharePoint;

namespace InfoPathDB
{
    /// <summary>
    /// Summary description for InfoPathDB
    /// </summary>
    [ScriptService]
    [WebService(Namespace = "http://infopathdb.codeplex.com/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class InfoPathDBWebService : System.Web.Services.WebService
    {
        [WebMethod(Description = "For basic testing.  Returns a simple 'Hello World' String object.")]
        public String HelloWorld()
        {
            return "Hello World " + DateTime.Now.ToString();
        }
        [WebMethod(Description = "For basic testing.  Returns a simple 'Hello World' String object.")]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public String HelloWorldAsJSON()
        {
            return "{'HelloWorld' : '" + DateTime.Now.ToString() + "'}";
        }
        [WebMethod(Description = "Query multiple InfoPath XML documents within a SharePoint Form Library. Return XmlDocument http://infopathdb.codeplex.com/")]
        public XmlDocument QueryFormLibrary(string SiteURL, string FormLibraryTitle, string OptionalContentType, string OptionalCAMLFilter, string OptionalBooleanIncludeAttachments)
        {
            return InfoPathDBEngine.QueryFormLibrary(SiteURL, FormLibraryTitle, OptionalContentType, OptionalCAMLFilter, OptionalBooleanIncludeAttachments);
        }
        [WebMethod(Description = "Query multiple InfoPath XML documents within a SharePoint Form Library. Return JSON String http://infopathdb.codeplex.com/")]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public String QueryFormLibraryAsJSON(string SiteURL, string FormLibraryTitle, string OptionalContentType, string OptionalCAMLFilter, string OptionalBooleanIncludeAttachments)
        {
            return InfoPathDBEngine.QueryFormLibraryAsJSON(SiteURL, FormLibraryTitle, OptionalContentType, OptionalCAMLFilter, OptionalBooleanIncludeAttachments);
        }
    }
}
