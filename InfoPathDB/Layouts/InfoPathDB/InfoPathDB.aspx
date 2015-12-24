<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls"
    Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InfoPathDB.aspx.cs" Inherits="InfoPathDB.Layouts.InfoPathDB.InfoPathDB"
    DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <style type="text/css">
        .InfoPathDBTable
        {
            background-color: #E5E5E5;
        }
        div.InfoPathDBTable
        {
            background-color: #FFFFFF;
        }
        .InfoPathDBHidden
        {
            display: none;
        }
        .InfoPathDBIcon 
        {
            margin-left:5px;
            margin-right:5px;
        }
    </style>
    <script type="text/javascript" src="jquery-1.10.2.js"></script>
    <script type="text/javascript" src="InfoPathDB.js"></script>
    <script type="text/javascript">
        //namespace
        var InfoPathDB = InfoPathDB || {};

        // Get destination XML
        InfoPathDB.guiLaunchDestinationXML = function () {
            return document.getElementById("<%= textWebAppUrl.ClientID %>").value + "/_vti_bin/InfoPathDB/InfoPathDB.asmx/QueryFormLibrary?"
                    + "SiteURL="
                    + document.getElementById("<%= textWebUrl.ClientID %>").value
                    + "&FormLibraryTitle="
                    + document.getElementById("<%= FormLibraryTitle.ClientID %>").value
                    + "&OptionalContentType=" 
                    + document.getElementById("<%= OptionalContentType.ClientID %>").value
                    + "&OptionalCAMLFilter=" 
                    + document.getElementById("<%= OptionalCAMLFilter.ClientID %>").value
                    + "&OptionalBooleanIncludeAttachments=" 
                    + document.getElementById("<%= OptionalBooleanIncludeAttachments.ClientID %>").value;
        };

        // Launch IQY Excel web query with GUI parameters
        InfoPathDB.guiLaunchIQY = function () {
            document.location.href = "Excel.aspx?destinationURL=" + escape(InfoPathDB.guiLaunchDestinationXML());
        };

        // Launch XML in new window with GUI parameters
        InfoPathDB.guiLaunchXML = function () {
            window.open(InfoPathDB.guiLaunchDestinationXML());
        };

        // Launch JSON function with GUI parameters
        InfoPathDB.guiLaunchJSON = function () {
            $('#JSONresponse').html("Fetching data ...");
            InfoPathDB.getJSON(document.getElementById("<%= textWebUrl.ClientID %>").value,
                document.getElementById("<%= FormLibraryTitle.ClientID %>").value,
                document.getElementById("<%= OptionalContentType.ClientID %>").value,
                document.getElementById("<%= OptionalCAMLFilter.ClientID %>").value,
                document.getElementById("<%= OptionalBooleanIncludeAttachments.ClientID %>").value);
        };
    </script>
    <table border="0" cellpadding="5" width="90%">
        <tr><td colspan="2"><img src="InfoPath.png" /><a href="http://infopathdb.codeplex.com/" target="_blank">http://infopathdb.codeplex.com/</a></td></tr>
        <tr>
            <td colspan="2">
                <!-- parameters -->
                <table border="0" cellspacing="0" cellpadding="4" class="InfoPathDBTable" width="100%">
                    <tr>
                        <td>
                            Parameter
                        </td>
                        <td>
                            Value
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            FormLibraryTitle:
                        </td>
                        <td>
                            <asp:DropDownList ID="FormLibraryTitle" name="FormLibraryTitle" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            OptionalContentType:
                        </td>
                        <td>
                            <asp:TextBox ID="OptionalContentType" runat="server" size="100"></asp:TextBox>
                            <br />
                            Content Type name in the source Form Library. Commonly used with InfoPath Central
                            Admin full trust or Sandbox XSN which are published as Features.
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            OptionalCAMLFilter:
                        </td>
                        <td>
                            <asp:TextBox ID="OptionalCAMLFilter" runat="server" size="100"></asp:TextBox>
                            <br />
                            &lt;Where&gt;&lt;Eq&gt;&lt;FieldRef Name=&quot;ID&quot; /&gt;&lt;Value Type=&quot;Counter&quot;&gt;1&lt;/Value&gt;&lt;/Eq&gt;&lt;/Where&gt;
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            OptionalBooleanIncludeAttachments:
                        </td>
                        <td>
                            <asp:DropDownList ID="OptionalBooleanIncludeAttachments" runat="server">
                            <asp:ListItem Selected="True"></asp:ListItem>
                            <asp:ListItem>true</asp:ListItem>
                            <asp:ListItem>false</asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            "True" if you want binary embedded file attachments (base64) to be included in return data
                        </td>
                    </tr>
                </table>
            </td>
            <td width="50px">&nbsp;</td>
        </tr>
        <tr>
            <td valign="top">
                <!-- actions -->
                <table cellspacing="0" cellpadding="4" class="InfoPathDBTable" style="padding-bottom:5px;">
                    <tr>
                        <td>
                            <img alt="XLSX" src="../images/XLS16.GIF" class="InfoPathDBIcon" />
                        </td>
                        <td style="min-width: 180px">
                            <a href="javascript:InfoPathDB.guiLaunchIQY();">Download to Excel</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <img alt="XML" src="../images/XML16.GIF" class="InfoPathDBIcon" />
                        </td>
                        <td>
                            <a href="javascript:InfoPathDB.guiLaunchXML();">Query as XML</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <img alt="JS" src="../images/JS16.GIF" class="InfoPathDBIcon" />
                        </td>
                        <td>
                            <a href="javascript:InfoPathDB.guiLaunchJSON();">Query as JSON</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <img alt="JS" src="../images/ENTITYINSTANCERESOLVER.png" class="InfoPathDBIcon" />
                        </td>
                        <td>
                            <a href="/_vti_bin/InfoPathDB/InfoPathDB.asmx" target="_blank">SOAP invoke form</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <img alt="JS" src="../images/ENTITYINSTANCERESOLVER.png" class="InfoPathDBIcon" />
                        </td>
                        <td>
                            <a href="/_vti_bin/InfoPathDB/InfoPathDB.asmx?WSDL" target="_blank">SOAP endpoint
                                WSDL</a>
                        </td>
                    </tr>
                </table>
            </td>
            <td valign="top" width="100%" align="left">
                <!-- JSON output -->
                <div class="InfoPathDBTable">
                    <div style="margin-bottom:5px">View JSON data by presssing F12 for Developer Tools and watching "<b>test</b>" JavaScript
                    object.</div>
                    <textarea id="JSONresponse" cols="100" rows="7"></textarea>
                </div>
                <img src="../images/blank.gif" width="100%" height="1px" />
            </td>
            <td width="50px">&nbsp;</td>
        </tr>
    </table>
    <asp:TextBox ID="textWebUrl" runat="server" size="100" CssClass="InfoPathDBHidden"></asp:TextBox>
    <asp:TextBox ID="textWebAppUrl" runat="server" size="100" CssClass="InfoPathDBHidden"></asp:TextBox>
</asp:Content>
<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
    InfoPathDB
</asp:Content>
<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea"
    runat="server">
    InfoPathDB
</asp:Content>
