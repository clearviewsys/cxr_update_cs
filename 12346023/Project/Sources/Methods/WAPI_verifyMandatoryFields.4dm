//%attributes = {}
C_POINTER:C301($ptrField; $ptrNameArray; $ptrValueArray)
C_LONGINT:C283($i; $iElem; $iType)
C_TEXT:C284($tJavaScript; $tValue)

QUERY:C277([FieldConstraints:69]; [FieldConstraints:69]TableNo:1=Table:C252($ptrValueArray); *)
QUERY:C277([FieldConstraints:69];  & ; [FieldConstraints:69]isMandatory:4=True:C214)

SELECTION TO ARRAY:C260([FieldConstraints:69]FieldNo:2; $aiFieldNums)

For ($i; 1; Size of array:C274($ptrNameArray->))
	$ptrField:=WAPI_txt2Field($ptrValueArray->{$i})
	
	If (Is nil pointer:C315($ptrField))  //not a field
	Else 
		$iElem:=Find in array:C230($aiFieldNums; Field:C253($ptrField))
		
		If ($iElem>0)  //this is mandatory
			$tValue:=$ptrValueArray->{$i}  //get value to eval
			$iType:=Type:C295($ptrField->)
			
			Case of 
				: ($iType=Is date:K8:7)
					
				: ($iType=Is real:K8:4) | ($iType=Is longint:K8:6) | ($iType=Is integer:K8:5)
					
				: ($iType=Is picture:K8:10)
					
				: ($iType=Is BLOB:K8:12)
					
					
				Else   //else text or string
					If ($tValue="")
						$tJavaScript:=$tJavaScript+WAPI_setDOMError(WAPI_getInputControlID($ptrField); "ERROR - "+Field name:C257($ptrField)+" is Mandatory."; "text-danger")
					End if 
			End case 
		End if 
	End if 
End for 
