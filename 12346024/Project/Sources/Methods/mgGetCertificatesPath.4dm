//%attributes = {}
// returns path to a folder containing MOneyGram certificates prepared for accessing SOAP API

C_TEXT:C284($0)

If (Application type:C494#4D Server:K5:6)
	$0:=getFilePathByID("MoneyGram.certPath")
Else 
	$0:=Get 4D folder:C485(Data folder:K5:33)+"mg_certificates"+Folder separator:K24:12
End if 
