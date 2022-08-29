//%attributes = {}
// isProgressBarStopped(progressID) 
C_LONGINT:C283($1; $progressID)
C_BOOLEAN:C305($0; $stopped)

$progressID:=$1

Case of 
	: (Application type:C494=4D Server:K5:6)  //6/15/*17 IBB we don't have progress on server
		$stopped:=False:C215
	: (Process state:C330($progressID)>=Executing:K13:4)
		GET PROCESS VARIABLE:C371($progressID; vProgressBarStopped; $stopped)
	Else 
		$stopped:=True:C214
End case 

$0:=$stopped