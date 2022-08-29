//%attributes = {"publishedWeb":true,"shared":true}
C_TEXT:C284($1)  //country code
C_TEXT:C284($2)  // bank required field - ie. iban/swift/aba/transit/ifsc

C_BOOLEAN:C305($0)

var $col : Collection

$col:=webGetCountrySettings($1).result

If ($col.length>0)
	
	If ($col[0].bankReq.indexOf($2)>=0)
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
	
Else 
	$0:=False:C215
End if 