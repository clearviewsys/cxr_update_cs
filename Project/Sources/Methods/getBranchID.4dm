//%attributes = {"shared":true,"publishedWeb":true}
// this method returns this workstation's branchID or else it will return the global <>branchID from server prefs

C_TEXT:C284($0; $branchID)
C_TEXT:C284(<>branchPrefix)


$branchID:=getClientBranchID
If ($branchID="")
	$branchID:=Uppercase:C13(<>branchPrefix)
End if 
$0:=$branchID