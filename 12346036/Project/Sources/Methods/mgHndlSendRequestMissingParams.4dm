//%attributes = {}
C_TEXT:C284($1; $root; $xml)
C_OBJECT:C1216($2; $parameters; $0)
C_TEXT:C284($3; $customerID)
C_BOOLEAN:C305($4; $isSilent)
C_BOOLEAN:C305($5; $forceFormatToMissing)

C_COLLECTION:C1488($required; $missing; $formatting; $col)
C_OBJECT:C1216($xmlObj; $subObj; $oneField; $formMissing)
C_BOOLEAN:C305($missingValidated; $missingAllValidated; $push; $enumerated; $isValid)
C_LONGINT:C283($winref; $maxLength; $index)
C_TEXT:C284($value; $type)

$xml:=$1
$parameters:=$2

If (Count parameters:C259>2)
	$customerID:=$3
Else 
	$customerID:=""
End if 

If (Count parameters:C259>=4)
	$isSilent:=$4
Else 
	$isSilent:=False:C215
End if 

If (Count parameters:C259>=5)
	$forceFormatToMissing:=$5
Else 
	$forceFormatToMissing:=False:C215
End if 

If (mgIsStateRequired(mgCountryID2CountryCode($parameters.SenderCountry)))
	If ($customerID#"")
		$formMissing:=New object:C1471
		$formMissing.customer:=ds:C1482.Customers.query("CustomerID = :1"; $customerID)
		$formMissing.stateRequired:=True:C214
		$formMissing.states:=mgGetStatesFromStorage(True:C214)
		$formMissing.states:=$formMissing.states.query("Country = :1"; String:C10(mgCountryCode2CountryID($parameters.SenderCountry)))
		$missing:=New collection:C1472
		$oneField:=mgCreateSendRequestMissingObj($formMissing.states; "SenderState"; "Sender state"; \
			"StateOfCountryName"; "StateOfCountry"; $formMissing.customer.Province)
		$missing.push($oneField)
	End if 
End if 

$0:=New object:C1471

$root:=DOM Parse XML variable:C720($xml)
$xmlObj:=mgXML2Object($root)
DOM CLOSE XML:C722($root)

$subObj:=mgGetSubObject($xmlObj; "GetMethodInfoResult")

$required:=mgSOAP_GetMethodInfoGetFields($subObj; "true")
$formatting:=New collection:C1472

$0.required:=$required  //collection of field objects
$0.success:=True:C214  // init
$0.accept:=True:C214  // init

For each ($oneField; $required)
	
	$push:=True:C214
	$isValid:=True:C214
	If ($parameters[$oneField.Name]#Null:C1517)
		$value:=OB Get:C1224($parameters; $oneField.Name; Is text:K8:3)
		If ($value#"")
			// this is ok, do not add item to collection
			$push:=False:C215
			
			//text to see if valid type/length/...
			$type:=$oneField.Type
			$maxLength:=Num:C11($oneField.MaxLength)
			$enumerated:=Choose:C955($oneField.Enumerated="true"; True:C214; False:C215)
			
			Case of 
				: ($type="CurrencyAmount")
					If (Num:C11($value)>0)
					Else 
						$isValid:=False:C215
					End if 
				: ($type="Integer")
					If (Length:C16($value)>$maxLength)
						$isValid:=False:C215
					End if 
				: ($type="Boolean")
					If ($value="true") | ($value="false")
					Else 
						$isValid:=False:C215
					End if 
				: ($type="DateTime")
					If (mgGetDateFromProfixDateTime($value; " ")>!00-00-00!)
					Else 
						$isValid:=False:C215
					End if 
					
				: ($enumerated)  //does our value match a choice
					$col:=$oneField.EnumeratedValues.EnumeratedValuesInfo.distinct("EnumeratedValue")
					$index:=$col.indexOf(Uppercase:C13($value))  //MG values seem to be UPPERCASE
					If ($index>=0)  // --------------- THIS NEEDS TO BE CASE SENSITIVE SO SET TO THE FOUND VALUE------
						OB SET:C1220($parameters; $oneField.Name; $col[$index])
					Else 
						$isValid:=False:C215
					End if 
					
				Else   //string
					If (Length:C16($value)>$maxLength)
						$isValid:=False:C215
					End if 
			End case 
			
		End if 
	End if 
	
	If ($push)
		If ($missing=Null:C1517)
			$missing:=New collection:C1472
		End if 
		$missing.push($oneField)
	End if 
	
	If ($isValid=False:C215)
		If ($formatting=Null:C1517)
			$formatting:=New collection:C1472
		End if 
		$formatting.push($oneField)
		
		If ($forceFormatToMissing) & ($push=False:C215)  // havent already pushed
			If ($missing=Null:C1517)
				$missing:=New collection:C1472
			End if 
			$missing.push($oneField)
		End if 
	End if 
	
	
	
End for each 

$missingAllValidated:=True:C214

If ($missing#Null:C1517)
	
	$0.missing:=$missing  //collection
	$0.formatting:=$formatting  //collection of formatting issues
	$0.success:=False:C215
	$0.accept:=False:C215
	
	
	If ($isSilent)
		Case of 
			: ($0.missing.length>0)
			: ($0.formatting.length>0)
			Else 
				$0.success:=True:C214
				$0.accept:=True:C214
		End case 
		
	Else 
		If ($formMissing=Null:C1517)
			$formMissing:=New object:C1471
		End if 
		$formMissing.missing:=$missing
		$formMissing.required:=$required
		
		$winref:=Open form window:C675("mgFillMissingRequired")
		DIALOG:C40("mgFillMissingRequired"; $formMissing)
		CLOSE WINDOW:C154
		
		
		If (OK=1)
			
			$0.accept:=True:C214
			
			For each ($oneField; $formMissing.missing)
				
				$missingValidated:=False:C215
				
				If ($formMissing[$oneField.Name]#Null:C1517)
					If ($formMissing[$oneField.Name]#"")
						$parameters[$oneField.Name]:=$formMissing[$oneField.Name]
						$missingValidated:=True:C214
					End if 
				End if 
				
				$missingAllValidated:=$missingAllValidated & $missingValidated
				
			End for each 
			
			If ($missingAllValidated)
				$0.success:=True:C214
			Else 
				$0.success:=False:C215
			End if 
		End if 
		
	End if 
	
End if 
