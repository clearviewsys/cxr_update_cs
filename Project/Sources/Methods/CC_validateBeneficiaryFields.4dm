//%attributes = {}
C_POINTER:C301($1; $pError)
C_OBJECT:C1216($2; $beneficiary; $requiredDetailsObject; $requiredDetailsLineObject; $retObject)
C_TEXT:C284($0; $3; $authKey; $entityType; $acceptedPairings; $priorityText; $missingProperties)
C_BOOLEAN:C305($4; $priority; $curr; $bank; $ben)
C_LONGINT:C283($i)
ARRAY TEXT:C222($objectProperties; 0)
$retObject:=New object:C1471()

Case of 
	: (Count parameters:C259=4)
		$pError:=$1
		$beneficiary:=$2
		$authKey:=$3
		$priority:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
$curr:=OB Is defined:C1231($beneficiary; "currency")
$bank:=OB Is defined:C1231($beneficiary; "bank_country")
$ben:=OB Is defined:C1231($beneficiary; "beneficiary_country")
If (($curr=False:C215) | ($bank=False:C215) | ($ben=False:C215))
	$0:="The beneficiary is missing a currency, country, or bank country. Please check the beneficiary fields"
Else 
	
	//Get an object containing all the required details for teh given currency and countries
	$requiredDetailsObject:=CC_getRequiredDetails(\
		$pError; \
		$beneficiary.currency; \
		$beneficiary.bank_country; \
		$beneficiary.beneficiary_country; \
		$authKey)
	
	//If there is an error in the query, the returned object will have an 'errorCode' property
	If (OB Is defined:C1231($requiredDetailsObject; "errorCode"))
		$retObject.errorCode:=$requiredDetailsObject.errorCode
	Else 
		
		//Setting the correct text based on the boolean input
		If ($priority=True:C214)
			$priorityText:="priority"
		Else 
			$priorityText:="regular"
		End if 
		
		//Iterate through the response object and get all pairings of priority and entity type
		//Eg 'priority & entity','priority & individual','regular & enttitiy'...
		$i:=0
		While ($i<$requiredDetailsObject.details.length)
			$acceptedPairings:=$acceptedPairings+\
				$requiredDetailsObject.details[$i].beneficiary_entity_type+", "+\
				$requiredDetailsObject.details[$i].payment_type+Char:C90(Carriage return:K15:38)
			
			//if any of the pairings match our current pairing, grab that object
			If (($requiredDetailsObject.details[$i].payment_type=$priorityText) & \
				($requiredDetailsObject.details[$i].beneficiary_entity_type=$beneficiary.beneficiary_entity_type))
				$requiredDetailsLineObject:=$requiredDetailsObject.details[$i]
			End if 
			$i:=$i+1
		End while 
		
		//If none of teh pairings match, throw an error with a list of the accepted pairings
		If ($requiredDetailsLineObject=Null:C1517)
			$acceptedPairings:="Beneficiary cannot be created for an "+\
				$beneficiary.beneficiary_entity_type+\
				" with a "+$priorityText+" payment"+Char:C90(Carriage return:K15:38)+\
				"Accepted pairings are:"+Char:C90(Carriage return:K15:38)+$acceptedPairings
			$0:=$acceptedPairings
		Else 
			//The field names are stored in the property names
			//The values are the regex for accepted values, but we aren't checking those here, just having the correct properties
			OB GET PROPERTY NAMES:C1232($requiredDetailsLineObject; $objectProperties)
			
			//Loop through and add any missing properties to a string to be returned.
			$i:=1
			While ($i<Size of array:C274($objectProperties))
				If (Not:C34(OB Is defined:C1231($beneficiary; $objectProperties{$i})))
					If ((($objectProperties{$i}="acct_number") & (OB Is defined:C1231($beneficiary; "account_number"))) | ($objectProperties{$i}="payment_type"))
						//There is a property name mismatch in the API
					Else 
						$missingProperties:=$missingProperties+$objectProperties{$i}+Char:C90(Carriage return:K15:38)
					End if 
				End if 
				$i:=$i+1
			End while 
			If ($missingProperties#"")
				$missingProperties:="The following properties are missing and required for this beneficiary: "+$missingProperties
				$0:=$missingProperties
			Else 
				$0:="200"
			End if 
		End if 
		
	End if 
End if 


