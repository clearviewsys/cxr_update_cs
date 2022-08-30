//%attributes = {}


// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 06/14/20, 10:43:57
// ----------------------------------------------------
// Method: SP_Stop
// Description
// 
//
// Parameters
// ----------------------------------------------------



If (Application type:C494=4D Remote mode:K5:5)
	//running on server so don't do anything here
Else 
	SET PROCESS VARIABLE:C370(-1; <>SP_Stop; True:C214)
End if 