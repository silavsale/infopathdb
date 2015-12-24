using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Administration;
using Microsoft.SharePoint.Utilities;
using Microsoft.Web.Administration;

namespace InfoPathDB.Features.InfoPathDBFeature
{
    /// <summary>
    /// This class handles events raised during feature activation, deactivation, installation, uninstallation, and upgrade.
    /// </summary>
    /// <remarks>
    /// The GUID attached to this class may be used during packaging and should not be modified.
    /// </remarks>

    [Guid("8bf66f2e-14cc-47ea-b7c6-5d2963a38a84")]
    public class InfoPathDBFeatureEventReceiver : SPFeatureReceiver
    {
        // Uncomment the method below to handle the event raised after a feature has been activated.

        public override void FeatureActivated(SPFeatureReceiverProperties properties)
        {
            //collect SP Web Applications
            string log = "";
            log += "\r\nBuild number: " + SPFarm.Local.BuildVersion.ToString();
            string hive = SPUtility.GetGenericSetupPath(string.Empty);
            log += "\r\nHive: " + hive;
            Dictionary<int, string> spWebApps = new Dictionary<int, string>();
            foreach (SPWebApplication wa in SPWebService.ContentService.WebApplications)
            {
                try
                {
                    int id = wa.IisSettings[0].PreferredInstanceId;
                    string path = wa.IisSettings[0].Path.ToString();
                    spWebApps.Add(id, path);
                    log += "\r\nFound SPWebApplication Id:" + id + " and Path:" + path;
                }
                catch (Exception ex)
                {
                    // Optional - continue if unable to query SP
                    InfoPathDBLog.writeLog(ex);
                }
            }

            //repeat for all servers in the SP farm
            foreach (SPServer s in SPFarm.Local.Servers)
            {
                try
                {
                    //skip SQL and SMTP machines
                    if (s.Role != SPServerRole.Invalid)
                    {
                        //open remote IIS manager
                        log += "\r\nServer: " + s.Name;
                        bool haveChanges = false;
                        ServerManager manager = ServerManager.OpenRemote(s.Name);
                        foreach (Site site in manager.Sites)
                        {
                            //defaults
                            bool matchWebApp = false;
                            bool foundInfoPathDB = false;

                            //is this a SP web app?  or generic IIS website?
                            foreach (KeyValuePair<int, string> pair in spWebApps)
                            {
                                try
                                {
                                    if (site.Id == pair.Key &&
                                        site.Applications["/"].VirtualDirectories["/"].PhysicalPath == pair.Value)
                                    {
                                        matchWebApp = true;
                                    }
                                }
                                catch (Exception ex)
                                {
                                    // Optional - continue if unable to query IIS
                                    InfoPathDBLog.writeLog(ex);
                                }
                            }

                            //create Application (if not already done)
                            if (matchWebApp)
                            {
                                foreach (Application app in site.Applications)
                                {
                                    if (app.Path == "/_vti_bin/InfoPathDB")
                                    {
                                        foundInfoPathDB = true;
                                        log += "\r\nFound App /_vti_bin/InfoPathDB/ on " + site.Name;
                                    }
                                }
                                if (!foundInfoPathDB)
                                {
                                    Application app = site.Applications.Add("/_vti_bin/InfoPathDB", hive + @"ISAPI\InfoPathDB");
                                    app.ApplicationPoolName = site.Applications["/"].ApplicationPoolName;
                                    haveChanges = true;
                                    log += "\r\nCovert App /_vti_bin/InfoPathDB/ on " + site.Name + " with pool " + app.ApplicationPoolName;
                                }
                            }
                        }
                        //save changes
                        if (haveChanges)
                        {
                            log += "\r\nIIS commit changes";
                            manager.CommitChanges();
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Optional - continue to next Farm server
                    InfoPathDBLog.writeLog(ex);
                }
            }

            //logging
            InfoPathDBLog.writeLog("Feature Activated OK" + log);
        }
        public override void FeatureDeactivating(SPFeatureReceiverProperties properties)
        {
            InfoPathDBLog.writeLog("Feature Deactivating");
        }
        public override void FeatureInstalled(SPFeatureReceiverProperties properties)
        {
            InfoPathDBLog.writeLog("Feature Installed");
        }
        public override void FeatureUninstalling(SPFeatureReceiverProperties properties)
        {
            InfoPathDBLog.writeLog("Feature Uninstalling");
        }
        public override void FeatureUpgrading(SPFeatureReceiverProperties properties, string upgradeActionName, System.Collections.Generic.IDictionary<string, string> parameters)
        {
            InfoPathDBLog.writeLog("Feature Upgrading");
        }
    }
}
