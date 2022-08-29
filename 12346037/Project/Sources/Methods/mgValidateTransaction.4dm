//%attributes = {}
// validates send/receive object using masks in object definition

C_OBJECT:C1216($0; $1; $validateMe; $currencies)
C_COLLECTION:C1488($errors; $countries)
C_LONGINT:C283($i; $minlen; $maxlen; $pos; $testlen; $valueType)
C_BOOLEAN:C305($isEmpty)
C_OBJECT:C1216($validator; $oneProperty)

$0:=New object:C1471
$0.success:=False:C215  // assume the worst

$validateMe:=$1  // transaction object
$errors:=New collection:C1472
$currencies:=mgGetCurrencies
$countries:=mgGetCountryCodes

C_COLLECTION:C1488($mgPropertyCol)
$mgPropertyCol:=mgDefineSendObject(True:C214)

$validator:=New object:C1471
$validator.object:=$validateMe
$validator.mandatory:=New object:C1471
$validator.masks:=New object:C1471
$validator.maxminlen:=New object:C1471

For each ($oneProperty; $mgPropertyCol)
	
	If ($oneProperty.mask#Null:C1517)
		$validator.masks[$oneProperty.name]:=$oneProperty.mask
	End if 
	
	$validator.mandatory[$oneProperty.name]:=False:C215
	If ($oneProperty.required#Null:C1517)
		If ($oneProperty.required="yes")
			$validator.mandatory[$oneProperty.name]:=True:C214
		End if 
	End if 
	
	If ($oneProperty.minmaxlen#Null:C1517)
		$validator.maxminlen[$oneProperty.name]:=$oneProperty.minmaxlen
	End if 
	
	If (False:C215)  // don't add properties to the transactions just validate what is there
		If ($oneProperty.value=Null:C1517)
			If ($validator.object[$oneProperty.name]=Null:C1517)  // set if doesn't exist
				Case of 
					: ($oneProperty.type="string")
						$validator.object[$oneProperty.name]:=""
						
					: ($oneProperty.type="real")
						$validator.object[$oneProperty.name]:=0
						
					: ($oneProperty.type="date")
						$validator.object[$oneProperty.name]:=!00-00-00!
				End case 
			End if 
		Else 
			If ($validator.object[$oneProperty.name]=Null:C1517)  // set if doesn't exist
				$validator.object[$oneProperty.name]:=$oneProperty.value
			End if 
		End if 
	End if 
End for each 


ARRAY TEXT:C222($properties; 0)

OB GET PROPERTY NAMES:C1232($validator.object; $properties)

For ($i; 1; Size of array:C274($properties))
	
	$isEmpty:=False:C215
	
	$valueType:=Value type:C1509($validator.object[$properties{$i}])
	
	Case of 
		: ($valueType=Is real:K8:4)
			$isEmpty:=($validator.object[$properties{$i}]=0)
			
		: ($valueType=Is date:K8:7)
			$isEmpty:=($validator.object[$properties{$i}]=!00-00-00!)
			
		: ($valueType=Is text:K8:3)
			$isEmpty:=($validator.object[$properties{$i}]="")
			
		Else 
			$isEmpty:=False:C215
	End case 
	
	
	If ($isEmpty)
		
		If ($validator.mandatory[$properties{$i}])
			$errors.push(New object:C1471("value"; $validator.object[$properties{$i}]; "propertyName"; $properties{$i}; "mandatory"; "YES"))
		End if 
		
	Else 
		
		If ($validator.masks[$properties{$i}]#Null:C1517)
			
			Case of 
					
				: ($validator.masks[$properties{$i}]="Country code")
					If (mgValidateCountryCode(OB Get:C1224($validator.object; $properties{$i}; Is text:K8:3); $countries))
					Else 
						$errors.push(New object:C1471("value"; $validator.object[$properties{$i}]; "propertyName"; $properties{$i}; "mask"; $validator.masks[$properties{$i}]))
					End if 
					
				: ($validator.masks[$properties{$i}]="Country ID")
					If (mgValidateCountryID(OB Get:C1224($validator.object; $properties{$i}; Is text:K8:3); $countries))
					Else 
						$errors.push(New object:C1471("value"; $validator.object[$properties{$i}]; "propertyName"; $properties{$i}; "mask"; $validator.masks[$properties{$i}]))
					End if 
					
					
				: ($validator.masks[$properties{$i}]="Currency code")
					If (mgValidateCurrencyCode(OB Get:C1224($validator.object; $properties{$i}; Is text:K8:3); $currencies))
					Else 
						$errors.push(New object:C1471("value"; $validator.object[$properties{$i}]; "propertyName"; $properties{$i}; "mask"; $validator.masks[$properties{$i}]))
					End if 
					
				: ($validator.masks[$properties{$i}]="Currency ID")
					If (mgValidateCurrencyID(OB Get:C1224($validator.object; $properties{$i}; Is text:K8:3); $currencies))
					Else 
						$errors.push(New object:C1471("value"; $validator.object[$properties{$i}]; "propertyName"; $properties{$i}; "mask"; $validator.masks[$properties{$i}]))
					End if 
					
				Else 
					
					If ($validator.masks[$properties{$i}]#"")
						
						If (($validator.maxminlen[$properties{$i}]#"") & ($validator.object[$properties{$i}]#""))
							
							$pos:=Position:C15("/"; $validator.maxminlen[$properties{$i}])
							
							If ($pos=0)
								$maxlen:=Num:C11($validator.maxminlen[$properties{$i}])
								$minlen:=0
							Else 
								$maxlen:=Num:C11(Substring:C12($validator.maxminlen[$properties{$i}]; 1; $pos-1))
								$minlen:=Num:C11(Substring:C12($validator.maxminlen[$properties{$i}]; $pos+1))
							End if 
							
							$testlen:=Length:C16($validator.object[$properties{$i}])
							
							If (($testlen<$minlen) | ($testlen>$maxlen))
								$errors.push(New object:C1471("value"; $validator.object[$properties{$i}]; "propertyName"; $properties{$i}; "maxminlen"; String:C10($testlen)+" wrong, excpected "+$validator.maxminlen[$properties{$i}]))
							End if 
							
						End if 
						
						If (mgValidateUsingregex($validator.masks[$properties{$i}]; OB Get:C1224($validator.object; $properties{$i}; Is text:K8:3)))
						Else 
							$errors.push(New object:C1471("value"; $validator.object[$properties{$i}]; "propertyName"; $properties{$i}; "mask"; $validator.masks[$properties{$i}]))
						End if 
						
					End if 
					
			End case 
			
		End if 
		
	End if 
	
End for 

If ($errors.length>0)
	$0.errors:=$errors
Else 
	$0.success:=True:C214
End if 
