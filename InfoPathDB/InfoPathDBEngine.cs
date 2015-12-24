using System;
using System.Diagnostics;
using System.IO;
using System.Runtime.Serialization;
using System.Xml;
using System.Linq;
using System.Xml.Linq;
using Microsoft.SharePoint;
using Newtonsoft.Json;

namespace InfoPathDB
{
    class InfoPathDBEngine
    {
        public static XmlDocument QueryFormLibrary(string SiteURL, string FormLibraryTitle, string OptionalContentType, string OptionalCAMLFilter, string OptionalBooleanIncludeAttachments)
        {
            //declare variables
            string currentUser = "";
            try
            {
                //open site context
                using (SPSite site = new SPSite(SiteURL))
                {
                    using (SPWeb web = site.OpenWeb())
                    {
                        //initialize
                        Stopwatch watch = new Stopwatch();
                        int countItem = 0;
                        currentUser = web.CurrentUser.LoginName.ToString();
                        watch.Start();

                        //validate parameter - FormLibraryTitle
                        if (String.IsNullOrEmpty(FormLibraryTitle))
                        {
                            //missing Form Library name, try to find first one in current Web
                            foreach (SPList l in web.GetListsOfType(SPBaseType.DocumentLibrary))
                            {
                                if (l.BaseTemplate == SPListTemplateType.XMLForm)
                                {
                                    FormLibraryTitle = l.Title;
                                    break;
                                }
                            }

                            //unable to find one, return error
                            if (String.IsNullOrEmpty(FormLibraryTitle))
                            {
                                throw new System.NullReferenceException("Required parameter missing.  No form library provided and none exists on this site.");
                            }
                        }

                        //open Form Library
                        SPDocumentLibrary list = (SPDocumentLibrary)web.Lists[FormLibraryTitle];

                        //CAML filter to reduce number of items
                        SPListItemCollection items;
                        if (!String.IsNullOrEmpty(OptionalCAMLFilter))
                        {
                            SPQuery query = new SPQuery(list.DefaultView);
                            query.Query = OptionalCAMLFilter;
                            items = list.GetItems(query);
                        }
                        else
                        {
                            items = list.Items;
                        }
                        countItem = items.Count;

                        //open XML documents with XSD schema
                        string result = "";
                        int i = 0;
                        foreach (SPListItem item in items)
                        {
                            if (item.File.Name.ToUpper().EndsWith(".XML"))
                            {
                                try
                                {
                                    //read file as XML
                                    byte[] data = item.File.OpenBinary();
                                    XmlDocument xml = new XmlDocument();
                                    MemoryStream stream = new MemoryStream();
                                    stream.Write(data, 0, data.Length);
                                    stream.Seek(0, SeekOrigin.Begin);
                                    XmlTextReader reader = new XmlTextReader(stream);
                                    xml.Load(reader);
                                    xml = RemoveXmlns(xml.OuterXml);

                                    //loop XML child nodes
                                    foreach (XmlNode n in xml.ChildNodes)
                                    {
                                        string outer = n.OuterXml.ToString();
                                        if (!outer.StartsWith("<?"))
                                        {
                                            string append = String.Format("<{0}>{1}</{0}>", n.Name, n.InnerXml.Replace(" xsi:nil=\"true\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"",""));
                                            result += append;
                                            break;
                                        }
                                    }
                                }
                                catch (Exception ex)
                                {
                                    //unable to process file
                                    result += String.Format("<Exception><File>{0}</File><Message>{1}</Message><StackTrace>{2}</StackTrace></Exception>", item.File.Name, ex.Message, ex.StackTrace);
                                }
                            }
                            //increment item counter
                            i++;
                        }

                        //diagnostic
                        watch.Stop();
                        string durationMS = watch.ElapsedMilliseconds.ToString();

                        //return merged output
                        result = "<NewDataSet>" + result + String.Format("<Diagnostic><DurationMS>{0}</DurationMS><SPListItems>{1}</SPListItems></Diagnostic></NewDataSet>", durationMS, countItem);

                        //ULS and EventLog
                        InfoPathDBLog.writeLog(String.Format("Success\r\nDurationMS:{6}\r\nSPListItems:{5}\r\nSiteURL:{0}\r\nFormLibraryTitle:{1}\r\nOptionalContentType:{2}\r\nOptionalCAMLFilter:{3}\r\nOptionalBooleanIncludeAttachments:{4}", SPContext.Current.Web.Url, FormLibraryTitle, OptionalContentType, OptionalCAMLFilter, OptionalBooleanIncludeAttachments, countItem, durationMS));

                        //return
                        XmlDocument doc = new XmlDocument();
                        doc.LoadXml(result);
                        return doc;
                    }
                }
            }
            catch (System.Exception ex)
            {
                //error handling
                InfoPathDBLog.writeLog(ex);
                XmlDocument doc = new XmlDocument();
                doc.InnerXml = String.Format("<ERROR><Type>{0}</Type><Message>{1}</Message><Source>{2}</Source><StackTrace>{3}</StackTrace><TargetSite>{4}</TargetSite><InnerException>{5}</InnerException><HelpLink>{6}</HelpLink><User>{7}</User></ERROR>", cleanXml(ex.GetType()), cleanXml(ex.Message), cleanXml(ex.Source), cleanXml(ex.StackTrace), cleanXml(ex.TargetSite), cleanXml(ex.InnerException), cleanXml(ex.HelpLink), cleanXml(currentUser));
                return doc;
            }
        }
        public static String QueryFormLibraryAsJSON(string siteURL, string FormLibraryTitle, string OptionalContentType, string OptionalCAMLFilter, string OptionalBooleanIncludeAttachments)
        {
            return JsonConvert.SerializeXmlNode(QueryFormLibrary(siteURL, FormLibraryTitle, OptionalContentType, OptionalCAMLFilter, OptionalBooleanIncludeAttachments));
        }
        private static string cleanXml(object o)
        {
            //special characters in stack trace caused HTTP 500, removing to be extra safe
            if (o == null)
            {
                return "";
            }
            else
            {
                return o.ToString().Replace("&", "").Replace("<", "").Replace(">", "");
            }
        }
        public static XmlDocument RemoveXmlns(String xml)
        {
            //remove any namespace prefixes ("my:" InfoPath)
            XDocument d = XDocument.Parse(xml);
            d.Root.Descendants().Attributes().Where(x => x.IsNamespaceDeclaration).Remove();

            foreach (var elem in d.Descendants())
                elem.Name = elem.Name.LocalName;

            var xmlDocument = new XmlDocument();
            xmlDocument.Load(d.CreateReader());

            return xmlDocument;
        }
    }
}
