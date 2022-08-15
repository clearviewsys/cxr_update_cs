//%attributes = {}
// getFileNameFromURL ( $URL )
// Returns the base name of the given URL.
// i.e.: if URL is "http:8082//cxr_updates/CXR4950.zip" wil return "CXR4950.zip"


C_TEXT:C284($1; $0; $url)
C_LONGINT:C283($start; $p; $lf)

// Get the file Name
$start:=1

Repeat 
	$p:=Position:C15("/"; $1; $start; $lf)
	$start:=$start+1
Until ($p=0)
$0:=Substring:C12($1; $start-1)
