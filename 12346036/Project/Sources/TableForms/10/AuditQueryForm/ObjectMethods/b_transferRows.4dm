C_TEXT:C284($path; $url; $reportName; $webServerURL)

$path:=getFilePathByID("WebPivotTable public")
$reportName:="MyReport"
$webServerURL:=getFilePathByID("WebPivotTable URL")



//$url:=WPT_EXPORT_LISTBOX_TO_WPT (->WPTListBox;$path;$reportName;$webServerURL)
WA OPEN URL:C1020(*; "WPTWebArea"; $url)


