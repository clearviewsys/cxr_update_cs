//%attributes = {}

C_COLLECTION:C1488($col)
C_TEXT:C284($path)


$path:=Get 4D folder:C485(Current resources folder:K5:16)+"cab"+Folder separator:K24:12+"cabTransCodes.txt"

If (Test path name:C476($path)=Is a document:K24:1)
	
	$col:=IE4_importTabToCollection($path)
	
	Use (Storage:C1525)
		Storage:C1525.cabTransCodes:=New shared collection:C1527
		Use (Storage:C1525.cabTransCodes)
			Storage:C1525.cabTransCodes:=$col.copy(ck shared:K85:29)
		End use 
	End use 
	
End if 


$path:=Get 4D folder:C485(Current resources folder:K5:16)+"cab"+Folder separator:K24:12+"cabFlexModules.txt"

If (Test path name:C476($path)=Is a document:K24:1)
	
	$col:=IE4_importTabToCollection($path)
	
	Use (Storage:C1525)
		Storage:C1525.cabFlexModules:=New shared collection:C1527
		Use (Storage:C1525.cabFlexModules)
			Storage:C1525.cabFlexModules:=$col.copy(ck shared:K85:29)
		End use 
	End use 
	
End if 