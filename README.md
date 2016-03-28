## Description
Aggregate and query multiple InfoPath XML documents from a SharePoint Form Library. Supports SOAP, XML, JSON, and IQY Excel format. Site Settings>InfoPathDB

Have you ever wanted to report directly against InfoPath Form Library data? Have you been frustrated by the limitations of published columns? Have you had trouble when trying to report on repeating table (one-to-many) data? Do you like working with clean XML web services? Then download and check out this SOAP/JSON web service. 

This code will aggregate many source XML documents into a single XML for easy reporting. Completely redesigned XML merge with pure XML text, much faster, less strict validation, and more robust handling of XML input.

![image](https://raw.githubusercontent.com/spjeff/infopathdb/master/doc/logo.png)

## Features
* Download to Excel IQY web query
* XML output
* JSON output
* CAML row filter
* People Picker data with BuiltInActiveXControls.xsd
* Item level security
* Both HTTP GET and POST
* Farm Feature applies IIS virtual directory "Convert to Application" change across the farm (needed for web.config to apply)
* Site Settings > Site Administration > InfoPathDB custom menu
* Query builder ASPX page

## How It Works
* Reads SharePoint Form Library
* Reads all XML document files
* Outputs a single aggregate XML data set
* Compatible any XML reporting tool (Excel, SQL Reporting Services, Performance Point Services, PowerPivot, InfoPath, etc.)

## SharePoint Compatibility
* Works on SP2010
* Works on SP2013
* Not ready for Office 365 (farm full trust, no sandbox or app)

## Usage
There are four parameters to the SOAP method QueryFormLibrary:

* SiteURL - URL address of the SPWeb hosting the Form Library
* FormLibraryTitle - Title of the Form Library
* OptionalContentType - When working with Administrator approved Central Admin XSN templates, you may need to specify a content type. with basic forms, this should be "Form".
* OptionalCAMLFilter - Where clause filter to reduce Form Library rows. For example, "<Where><Eq><FieldRef Name='Status'/><Value Type='CHOICE'>Not Started</Value></Eq></Where>"
* OptionalBooleanIncludeAttachments - Include large binary attachment fields (base64 data type). By default, these values are skipped over.

## Screenshots
![image](https://raw.githubusercontent.com/spjeff/infopathdb/master/doc/1.png)
![image](https://raw.githubusercontent.com/spjeff/infopathdb/master/doc/2.png)
![image](https://raw.githubusercontent.com/spjeff/infopathdb/master/doc/3.png)
![image](https://raw.githubusercontent.com/spjeff/infopathdb/master/doc/4.png)
![image](https://raw.githubusercontent.com/spjeff/infopathdb/master/doc/5.png)
![image](https://raw.githubusercontent.com/spjeff/infopathdb/master/doc/6.png)
![image](https://raw.githubusercontent.com/spjeff/infopathdb/master/doc/7.png)
![image](https://raw.githubusercontent.com/spjeff/infopathdb/master/doc/8.png)
![image](https://raw.githubusercontent.com/spjeff/infopathdb/master/doc/9.png)

## Credits
JSON parsing method from Json.NET. All other trademarks and copyrights are property of their respective owners.

## Contact
Please drop a line to [@spjeff](https://twitter.com/spjeff) or [spjeff@spjeff.com](mailto:spjeff@spjeff.com)
Thanks!  =)

![image](http://img.shields.io/badge/first--timers--only-friendly-blue.svg?style=flat-square)

## License

The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.