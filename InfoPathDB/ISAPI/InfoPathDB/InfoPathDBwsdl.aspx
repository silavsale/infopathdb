<%@ Page Language="C#" Inherits="System.Web.UI.Page" %> <%@ Assembly Name="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> <%@ Import Namespace="Microsoft.SharePoint.Utilities" %> <%@ Import Namespace="Microsoft.SharePoint" %>
<% Response.ContentType = "text/xml"; %>

<wsdl:definitions xmlns:tm="http://microsoft.com/wsdl/mime/textMatching/" xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:http="http://schemas.xmlsoap.org/wsdl/http/" xmlns:tns="http://infopathdb.codeplex.com/" xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/" xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" targetNamespace="http://infopathdb.codeplex.com/" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/">
  <wsdl:types>
    <s:schema elementFormDefault="qualified" targetNamespace="http://infopathdb.codeplex.com/">
      <s:element name="HelloWorld">
        <s:complexType />
      </s:element>
      <s:element name="HelloWorldResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="HelloWorldResult" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="HelloWorldAsJSON">
        <s:complexType />
      </s:element>
      <s:element name="HelloWorldAsJSONResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="HelloWorldAsJSONResult" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="QueryFormLibrary">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="SiteURL" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="FormLibraryTitle" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="OptionalContentType" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="OptionalRefreshSeconds" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="OptionalCAMLFilter" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="OptionalBooleanIncludeAttachments" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="QueryFormLibraryResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="QueryFormLibraryResult">
              <s:complexType mixed="true">
                <s:sequence>
                  <s:any />
                </s:sequence>
              </s:complexType>
            </s:element>
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="QueryFormLibraryAsJSON">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="SiteURL" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="FormLibraryTitle" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="OptionalContentType" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="OptionalRefreshSeconds" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="OptionalCAMLFilter" type="s:string" />
            <s:element minOccurs="0" maxOccurs="1" name="OptionalBooleanIncludeAttachments" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
      <s:element name="QueryFormLibraryAsJSONResponse">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="HelloWorldResult" type="s:string" />
          </s:sequence>
        </s:complexType>
      </s:element>
    </s:schema>
  </wsdl:types>
  <wsdl:message name="HelloWorldSoapIn">
    <wsdl:part name="parameters" element="tns:HelloWorld" />
  </wsdl:message>
  <wsdl:message name="HelloWorldSoapOut">
    <wsdl:part name="parameters" element="tns:HelloWorldResponse" />
  </wsdl:message>
  <wsdl:message name="HelloWorldAsJSONSoapIn">
    <wsdl:part name="parameters" element="tns:HelloWorldAsJSON" />
  </wsdl:message>
  <wsdl:message name="HelloWorldAsJSONSoapOut">
    <wsdl:part name="parameters" element="tns:HelloWorldAsJSONResponse" />
  </wsdl:message>
  <wsdl:message name="QueryFormLibrarySoapIn">
    <wsdl:part name="parameters" element="tns:QueryFormLibrary" />
  </wsdl:message>
  <wsdl:message name="QueryFormLibrarySoapOut">
    <wsdl:part name="parameters" element="tns:QueryFormLibraryResponse" />
  </wsdl:message>
  <wsdl:message name="QueryFormLibraryAsJSONSoapIn">
    <wsdl:part name="parameters" element="tns:QueryFormLibraryAsJSON" />
  </wsdl:message>
  <wsdl:message name="QueryFormLibraryAsJSONSoapOut">
    <wsdl:part name="parameters" element="tns:QueryFormLibraryAsJSONResponse" />
  </wsdl:message>
  <wsdl:portType name="InfoPathDBSoap">
    <wsdl:operation name="HelloWorld">
      <wsdl:documentation xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/">For basic testing.  Returns a simple 'Hello World' String object.</wsdl:documentation>
      <wsdl:input message="tns:HelloWorldSoapIn" />
      <wsdl:output message="tns:HelloWorldSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="HelloWorldAsJSON">
      <wsdl:documentation xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/">For basic testing.  Returns a simple 'Hello World' String object.</wsdl:documentation>
      <wsdl:input message="tns:HelloWorldAsJSONSoapIn" />
      <wsdl:output message="tns:HelloWorldAsJSONSoapOut" />
    </wsdl:operation>
    <wsdl:operation name="QueryFormLibrary">
      <wsdl:documentation xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/">Query multiple InfoPath XML documents within a SharePoint Form Library.  The InfoPath published column feature has limitations. High numbers of fields and repeating sections are all now clearly visible with this Web Service. Easily aggregate XML files for robust reporting.</wsdl:documentation>
      <wsdl:input message="tns:QueryFormLibrarySoapIn" />
      <wsdl:output message="tns:QueryFormLibrarySoapOut" />
    </wsdl:operation>
    <wsdl:operation name="QueryFormLibraryAsJSON">
      <wsdl:documentation xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/">Query multiple InfoPath XML documents within a SharePoint Form Library.  The InfoPath published column feature has limitations. High numbers of fields and repeating sections are all now clearly visible with this Web Service. Easily aggregate XML files for robust reporting.</wsdl:documentation>
      <wsdl:input message="tns:QueryFormLibraryAsJSONSoapIn" />
      <wsdl:output message="tns:QueryFormLibraryAsJSONSoapOut" />
    </wsdl:operation>
  </wsdl:portType>
  <wsdl:binding name="InfoPathDBSoap" type="tns:InfoPathDBSoap">
    <soap:binding transport="http://schemas.xmlsoap.org/soap/http" />
    <wsdl:operation name="HelloWorld">
      <soap:operation soapAction="http://infopathdb.codeplex.com/HelloWorld" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="HelloWorldAsJSON">
      <soap:operation soapAction="http://infopathdb.codeplex.com/HelloWorldAsJSON" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="QueryFormLibrary">
      <soap:operation soapAction="http://infopathdb.codeplex.com/QueryFormLibrary" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="QueryFormLibraryAsJSON">
      <soap:operation soapAction="http://infopathdb.codeplex.com/QueryFormLibraryAsJSON" style="document" />
      <wsdl:input>
        <soap:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:binding name="InfoPathDBSoap12" type="tns:InfoPathDBSoap">
    <soap12:binding transport="http://schemas.xmlsoap.org/soap/http" />
    <wsdl:operation name="HelloWorld">
      <soap12:operation soapAction="http://infopathdb.codeplex.com/HelloWorld" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="HelloWorldAsJSON">
      <soap12:operation soapAction="http://infopathdb.codeplex.com/HelloWorldAsJSON" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="QueryFormLibrary">
      <soap12:operation soapAction="http://infopathdb.codeplex.com/QueryFormLibrary" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="QueryFormLibraryAsJSON">
      <soap12:operation soapAction="http://infopathdb.codeplex.com/QueryFormLibraryAsJSON" style="document" />
      <wsdl:input>
        <soap12:body use="literal" />
      </wsdl:input>
      <wsdl:output>
        <soap12:body use="literal" />
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:service name="InfoPathDB">
    <wsdl:port name="InfoPathDBSoap" binding="tns:InfoPathDBSoap">
      <soap:address location=<% SPEncode.WriteHtmlEncodeWithQuote(Response, SPWeb.OriginalBaseUrl(Request), '"'); %> />
    </wsdl:port>
    <wsdl:port name="InfoPathDBSoap12" binding="tns:InfoPathDBSoap12">
      <soap12:address location=<% SPEncode.WriteHtmlEncodeWithQuote(Response, SPWeb.OriginalBaseUrl(Request), '"'); %> />
    </wsdl:port>
  </wsdl:service>
</wsdl:definitions>