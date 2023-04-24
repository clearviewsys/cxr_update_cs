//%attributes = {}
// convert the post to a collection of objects
// each object is a transactions/register
// might only get a single register so need to wrap in a collection

C_COLLECTION:C1488($col)
C_OBJECT:C1216($o; $status)
C_LONGINT:C283($elem)

ARRAY TEXT:C222($aNames; 0)
ARRAY TEXT:C222($aValues; 0)
WEB GET VARIABLES:C683($aNames; $aValues)

If (Size of array:C274($aNames)>0)
	
	$col:=JSON Parse:C1218($aNames{1})
	
Else 
	$col:=New collection:C1472  // init
	If (False:C215)
		$elem:=Find in array:C230($aNames; "transactions")
		If ($elem>0)
			$col:=JSON Parse:C1218($aValues{$elem})
		Else 
			$elem:=Find in array:C230($aNames; "transaction")
			If ($elem>0)
				$o:=JSON Parse:C1218($aValues{$elem})
				$col:=New collection:C1472($o)
			End if 
		End if 
	End if 
End if 


Case of 
	: ($col=Null:C1517)
		WEB SEND TEXT:C677(JSON Stringify:C1217(New object:C1471("success"; False:C215; "status"; -9998; "statusText"; "Transaction object NOT found.")))
		
	: ($col.length>0)
		// send the collection to method that will create the registers here
		// create batch log and pass the ID here
		$status:=CXR_createTransactions("batchID"; $col)
		
		If (OK=1)
			WEB SEND TEXT:C677(JSON Stringify:C1217(New object:C1471("success"; True:C214; "status"; 0; "statusText"; String:C10($col.length)+" transactions received and processed.")))
		Else 
			API_sendError("400"; New object:C1471("success"; False:C215; "status"; 400; "statusText"; String:C10($col.length)+" transactions could NOT be processed."))
		End if 
		
	Else 
		API_sendError("400"; New object:C1471("success"; False:C215; "status"; 400; "statusText"; "Transaction object NOT found."))
End case 