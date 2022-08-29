//%attributes = {}
// createSMSNotification

C_TEXT:C284($1; $toNumber)
C_TEXT:C284($2; $message)
C_TEXT:C284($3; $toNumberCountryCode)
C_TEXT:C284($4; $fromNumber)
C_LONGINT:C283($areaCodeLen)

Case of 
	: (Count parameters:C259=2)
		$toNumber:=$1
		$message:=$2
		//If no code specified, use internal
		$toNumberCountryCode:=<>CountryCode
		
	: (Count parameters:C259=3)
		$toNumber:=$1
		$message:=$2
		$toNumberCountryCode:=$3
		// what happens to $fromNumbeR?  // @tiran if the fromNumber is not sent? what's the default value? 
		
	: (Count parameters:C259=4)
		$toNumber:=$1
		$message:=$2
		$toNumberCountryCode:=$3
		$fromNumber:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_OBJECT:C1216($notification)
C_TEXT:C284($cusAreaCode; $numWithAreaCode)
C_BOOLEAN:C305($sendMessage; $areaCodeAlreadyPrepended; $hasAreaCode)


//------------------------------------------------
// Prepending an area code for number to be compatible with Twilio
$sendMessage:=False:C215
//CHECK IF CUSTOMER HAS A CELL NUMBER ON RECORD
If ($toNumber#"")
	//CHECK TO SEE IF CUSTOMER HAS COUNTRY CODE ON RECORD, USE CONTRY CODE TO FIND AREA CODE
	If (($toNumberCountryCode#""))
		$cusAreaCode:=getCountryAreaCodeByCountryCode($toNumberCountryCode)
		$sendMessage:=True:C214
	End if 
End if 

$hasAreaCode:=$cusAreaCode#""

If (($sendMessage) & ($hasAreaCode))
	$areaCodeLen:=Length:C16($cusAreaCode)
	$areaCodeAlreadyPrepended:=((Substring:C12($toNumber; 1; $areaCodeLen)=$cusAreaCode) | ((Substring:C12($toNumber; 1; $areaCodeLen+1)=("+"+$cusAreaCode))))
	If ($areaCodeAlreadyPrepended)
		$numWithAreaCode:=$toNumber
	Else 
		$numWithAreaCode:=$cusAreaCode+$toNumber
	End if 
	
	//Countries like NZ need a zero after the area code
	C_COLLECTION:C1488($countriesNeedZero)
	$countriesNeedZero:=New collection:C1472
	//------------------------------------
	// Add other counties that require '0' before area code $countriesNeedZero.push("NZ";"RS";"CA";"US"; etc.)
	$countriesNeedZero.push("NZ")
	//------------------------------------
	//Check if number is NZ number to make sure it has a 0 (+640.....)
	If (($countriesNeedZero.indexOf($toNumberCountryCode)#-1) & ($sendMessage))
		
		If ((Substring:C12($numWithAreaCode; 1; $areaCodeLen+2)=("+"+$cusAreaCode+"0")) | (Substring:C12($numWithAreaCode; 1; $areaCodeLen+1)=($cusAreaCode+"0")))
			// DO NOTHING Number is ready to send
		Else 
			Case of 
				: (Substring:C12($numWithAreaCode; 1; $areaCodeLen+1)=("+"+$cusAreaCode))
					$numWithAreaCode:=$cusAreaCode+"0"+Substring:C12($numWithAreaCode; $areaCodeLen+2)
					
				: (Substring:C12($numWithAreaCode; 1; $areaCodeLen)=$cusAreaCode)
					$numWithAreaCode:=$cusAreaCode+"0"+Substring:C12($numWithAreaCode; $areaCodeLen+1)
			End case 
			
		End if 
		
	End if 
	
	//  //------------------
	//  // !!!!!!!!!!!!!!FOR TESTING ONLY!!!!!!!!!!!!!!
	//C_TEXT($testMessage)
	//$testMessage:=$message+"\n \nNumber passed as parameter: "+$toNumber+", number used to send with Twilio: "+$numWithAreaCode+"\n Country Code: "+$toNumberCountryCode
	//ALERT($testMessage)
	//  //------------------
	//  //!!!!!UNCOMMENT SECTION BELOW AND DELETE TESTING SECTION ABOVE FOR PRODUCTION!!!!!!
	
	
	//------------------------------------------------
	// Sending the message
	$notification:=ds:C1482.Notifications.new()
	$notification.ID:=makeNotificationsID
	$notification.UUID:=Generate UUID:C1066
	$notification.type:=2  //SMS
	$notification.status:=0  //Pending
	$notification.creationDate:=Current date:C33(*)
	
	C_OBJECT:C1216($messagedetails)
	$messagedetails:=New object:C1471
	$messagedetails.message:=$message
	$messagedetails.to:=$numWithAreaCode
	$messagedetails.from:=$fromNumber
	$messagedetails.messageType:="sms"
	$messagedetails.createByUser:=getSystemUserName
	$messagedetails.creationDate:=Current date:C33(*)
	$messagedetails.creationTime:=Current time:C178(*)
	$messagedetails.subject:=$message
	$notification.message:=$messagedetails
	
	C_OBJECT:C1216($response)
	$response:=New object:C1471
	OBJ_newResponse(->$response)
	$notification.response:=$response
	$notification.response.failedAttempts:=0
	$notification.response.code:=0
	
	$notification.save()
	
Else 
	// What to do if the number does not have an area code to prepend?
	
End if 


