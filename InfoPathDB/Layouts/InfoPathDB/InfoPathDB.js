//namespace
var test;
var InfoPathDB = InfoPathDB || {};

// gather data in JSON format
InfoPathDB.getJSON = function (SiteURL, FormLibraryTitle, OptionalContentType, OptionalCAMLFilter, OptionalBooleanIncludeAttachments) {
    $.ajax({
        type: "POST",
        url: "/_vti_bin/InfoPathDB/InfoPathDB.asmx/QueryFormLibraryAsJSON",
        data: "{'SiteURL': '" + SiteURL + "', 'FormLibraryTitle': '" + FormLibraryTitle + "', 'OptionalContentType':'" + OptionalContentType + "', 'OptionalCAMLFilter':'" + OptionalCAMLFilter + "', 'OptionalBooleanIncludeAttachments':'" + OptionalBooleanIncludeAttachments + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            // Save for F15 Developer Tools to see
            test = JSON.parse(msg.d);

            // Display in <div>
            $('#JSONresponse').html(JSON.stringify(test));
        },
        error: function (xhr) {
            alert(xhr);
        }
    });
};