//%attributes = {}
C_POINTER:C301($1; $2; $field; $table; $pError)
C_TEXT:C284($3; $4; $setName; $message; $error)
C_BLOB:C604($5; $setBlob)
C_LONGINT:C283($i; $setSize; $errorSize)
ARRAY TEXT:C222($errorArray; 0)
ARRAY BOOLEAN:C223($setArray; 0)
$pError:=->$error

Case of 
	: (Count parameters:C259=5)
		$field:=$1
		$table:=$2
		$setName:=$3
		$message:=$4
		$setBlob:=$5
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

BLOB TO VARIABLE:C533($setBlob; $setArray)
CREATE SELECTION FROM ARRAY:C640($table->; $setArray; $setName)
USE NAMED SELECTION:C332($setName)
C_TEXT:C284($errorString)

$setSize:=Records in selection:C76($table->)
myConfirm("You are about to send "+String:C10($setSize)+" text message(s). Would you like to continue?")
If (OK=1)
	
	While (Not:C34(End selection:C36($table->)))
		
		// Sends SMS and provides status log in Notifications Module
		sendNotificationBySMS($field->; $message)
		
		
		
		// Old send by proccess method
		//twilioSendSMS ($pError;$field->;$message) 
		//If ($error#"")
		//APPEND TO ARRAY($errorArray;$error)
		//$error:=""
		//End if 
		
		NEXT RECORD:C51($table->)
	End while 
	
	
	$errorSize:=Size of array:C274($errorArray)
	
	If ($errorSize>0)
		$errorString:="Errors occured on "+String:C10($errorSize)+"/"+String:C10($setSize)+" messages."+Char:C90(Carriage return:K15:38)
		$errorString:=$errorString+"The following errors were recorded: "+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
		$i:=1
		While ($i<=Size of array:C274($errorArray))
			$errorString:=$errorString+$errorArray{$i}+Char:C90(Carriage return:K15:38)
			$i:=$i+1
		End while 
		myAlert($errorString)
	Else 
		myAlert("Messages have been sent")
	End if 
End if 
