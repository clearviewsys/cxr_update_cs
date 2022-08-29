C_TEXT:C284($path; $url; $reportName; $webServerURL)

$path:=getFilePathByID("WebPivotTable")
$reportName:="MyReport"
$webServerURL:="http://localhost:8002/"




//$url:=WPT_EXPORT_LISTBOX_TO_WPT (OBJECT Get pointer(Object named;"mainListBox");$path;$reportName;$webServerURL)
WA OPEN URL:C1020(*; "WPTWebArea"; $url)


