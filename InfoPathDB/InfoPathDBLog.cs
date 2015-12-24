using System;
using System.Diagnostics;
using Microsoft.SharePoint.Administration;
using Microsoft.SharePoint;

namespace InfoPathDB
{
    class InfoPathDBLog
    {
        public static void writeLog(string msg)
        {
            SPSecurity.RunWithElevatedPrivileges(delegate()
            {
                EventLog.WriteEntry("InfoPathDB", msg, EventLogEntryType.Information);
                SPDiagnosticsService.Local.WriteTrace(0, new SPDiagnosticsCategory("InfoPathDB", TraceSeverity.Medium, EventSeverity.Information), TraceSeverity.Unexpected, msg, msg);
            });
        }

        public static void writeLog(Exception ex)
        {
            SPSecurity.RunWithElevatedPrivileges(delegate()
            {
                EventLog.WriteEntry("InfoPathDB", "InfoPathDB Exception" + ex.Message + ex.StackTrace, EventLogEntryType.Error);
                SPDiagnosticsService.Local.WriteTrace(0, new SPDiagnosticsCategory("InfoPathDB", TraceSeverity.Unexpected, EventSeverity.Error), TraceSeverity.Unexpected, ex.Message, ex.StackTrace);
            });
        }
    }
}
