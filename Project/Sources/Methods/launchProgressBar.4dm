//%attributes = {}
C_LONGINT:C283($0; $processID)

C_TEXT:C284($title; $1)
$title:=$1


$0:=New process:C317("LaunchProgressBar_M"; 0; "ProgressBar")
If ($0=0)
	myAlert("Progress Bar Could not be initialized")
Else 
	setProgressBarTitle($0; $title)
End if 

//$processID:=Progress New 
//$0:=$processID

