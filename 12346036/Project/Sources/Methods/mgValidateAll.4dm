//%attributes = {}
// validates send/receive object using masks in object definition

C_OBJECT:C1216($0; $1; $validateMe; $currencies)
C_COLLECTION:C1488($errors; $countries)
C_LONGINT:C283($i; $minlen; $maxlen; $pos; $testlen; $valueType)
C_BOOLEAN:C305($isEmpty)

$0:=New object:C1471
$0.success:=False:C215  // assume the worst

$validateMe:=$1  // transaction object
$errors:=New collection:C1472
$currencies:=mgGetCurrencies
$countries:=mgGetCountryCodes

ARRAY TEXT:C222($properties; 0)

OB GET PROPERTY NAMES:C1232($validateMe.object; $properties)

For ($i; 1; Size of array:C274($properties))
	
	$isEmpty:=False:C215
	
	$valueType:=Value type:C1509($validateMe.object[$properties{$i}])
	
	Case of 
			
			
		: ($valueType=Is real:K8:4)
			
			$isEmpty:=($validateMe.object[$properties{$i}]=0)
			
			
		: ($valueType=Is date:K8:7)
			
			$isEmpty:=($validateMe.object[$properties{$i}]=!00-00-00!)
			
			
		: ($valueType=Is text:K8:3)
			
			$isEmpty:=($validateMe.object[$properties{$i}]="")
			
			
		Else 
			
			$isEmpty:=False:C215
			
	End case 
	
	
	If ($isEmpty)
		
		If ($validateMe.mandatory[$properties{$i}])
			$errors.push(New object:C1471("value"; $validateMe.object[$properties{$i}]; "propertyName"; $properties{$i}; "mandatory"; "YES"))
		End if 
		
	Else 
		
		If ($validateMe.masks[$properties{$i}]#Null:C1517)
			
			
			Case of 
					
				: ($validateMe.masks[$properties{$i}]="Country code")
					
					
					If (mgValidateCountryCode($validateMe.object[$properties{$i}]; $countries))
					Else 
						$errors.push(New object:C1471("value"; $validateMe.object[$properties{$i}]; "propertyName"; $properties{$i}; "mask"; $validateMe.masks[$properties{$i}]))
					End if 
					
					
					
				: ($validateMe.masks[$properties{$i}]="Currency code")
					
					If (mgValidateCurrencyCode($validateMe.object[$properties{$i}]; $currencies))
					Else 
						$errors.push(New object:C1471("value"; $validateMe.object[$properties{$i}]; "propertyName"; $properties{$i}; "mask"; $validateMe.masks[$properties{$i}]))
					End if 
					
				Else 
					
					If ($validateMe.masks[$properties{$i}]#"")
						
						If (($validateMe.maxminlen[$properties{$i}]#"") & ($validateMe.object[$properties{$i}]#""))
							
							$pos:=Position:C15("/"; $validateMe.maxminlen[$properties{$i}])
							
							If ($pos=0)
								$maxlen:=Num:C11($validateMe.maxminlen[$properties{$i}])
								$minlen:=0
							Else 
								$maxlen:=Num:C11(Substring:C12($validateMe.maxminlen[$properties{$i}]; 1; $pos-1))
								$minlen:=Num:C11(Substring:C12($validateMe.maxminlen[$properties{$i}]; $pos+1))
							End if 
							
							$testlen:=Length:C16($validateMe.object[$properties{$i}])
							
							If (($testlen<$minlen) | ($testlen>$maxlen))
								$errors.push(New object:C1471("value"; $validateMe.object[$properties{$i}]; "propertyName"; $properties{$i}; "maxminlen"; String:C10($testlen)+" wrong, excpected "+$validateMe.maxminlen[$properties{$i}]))
							End if 
							
						End if 
						
						If (mgValidateUsingregex($validateMe.masks[$properties{$i}]; $validateMe.object[$properties{$i}]))
						Else 
							$errors.push(New object:C1471("value"; $validateMe.object[$properties{$i}]; "propertyName"; $properties{$i}; "mask"; $validateMe.masks[$properties{$i}]))
						End if 
						
					End if 
					
			End case 
			
		End if 
		
	End if 
	
End for 

If ($errors.length>0)
	$0.errors:=$errors  //collection of errors
Else 
	$0.success:=True:C214
End if 
