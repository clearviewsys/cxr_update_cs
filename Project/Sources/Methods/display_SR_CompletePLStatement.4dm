//%attributes = {}
//author: Amir
//9th Jan 2019
If (isUserAllowedToViewProfits)
	openFormWindow(->[Reports:73]; "SR_CompletePLStatement")
Else 
	myAlert_AccessDenied
End if 