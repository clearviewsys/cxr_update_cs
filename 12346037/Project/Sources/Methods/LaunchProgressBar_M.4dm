//%attributes = {}
C_BOOLEAN:C305(vProgressBarStopped)
C_LONGINT:C283(vProgressCompleted; vProgressTotal)
vProgressBarStopped:=False:C215
vProgressCompleted:=-1
vProgressTotal:=0

If (Application type:C494=4D Server:K5:6)  //6/29/16 IBB
	//don't display on server
Else 
	openFormWindow(->[CompanyInfo:7]; "ProgressBar"; Palette form window:K39:9; On the right:K39:3; At the top:K39:5; False:C215)
End if 