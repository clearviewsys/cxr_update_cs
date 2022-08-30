//%attributes = {}
// PE_ShowPictureInArea
// Config the Area and show the picture applying the Doka Component
C_TEXT:C284($1; $webAreaName)
C_TEXT:C284($url; $jpgFile)

Case of 
	: (Count parameters:C259=1)
		$webAreaName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

WA SET PREFERENCE:C1041(*; $webAreaName; WA enable Web inspector:K62:7; True:C214)

$url:=Get 4D folder:C485(Current resources folder:K5:16; *)
$url:=Convert path system to POSIX:C1106($url)
$url:="file://"+$url+"tui_ieditor/cvs/main.html"

$jpgFile:=Convert path system to POSIX:C1106($url)
OBJECT SET ENABLED:C1123(*; "bUseImg"; False:C215)

WA OPEN URL:C1020(*; $webAreaName; $url)
//WA SET PREFERENCE(*; $webAreaName; _o_WA enable JavaScript; True)
WA SET PREFERENCE:C1041(*; $webAreaName; WA enable Web inspector:K62:7; True:C214)

