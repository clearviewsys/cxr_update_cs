//%attributes = {}
C_TEXT:C284($path)

C_COLLECTION:C1488($col)



$path:=Get 4D folder:C485(Database folder:K5:14)+"WebFolder"+Folder separator:K24:12+"custom"+\
Folder separator:K24:12+"customers"+Folder separator:K24:12+"config"+Folder separator:K24:12+\
"wire-map.json"

If (Test path name:C476($path)=Is a document:K24:1)
	
	$col:=JSON Parse:C1218(Document to text:C1236($path; "UTF-8"))
	
	If ($col.length>0)
		Use (Storage:C1525)
			
			If (Storage:C1525.wiresMap=Null:C1517)
				Storage:C1525.wiresMap:=New shared collection:C1527
			End if 
			
			Use (Storage:C1525.wiresMap)
				OB_CopyCollection($col; Storage:C1525.wiresMap)
			End use 
			
		End use 
	End if 
	
End if 