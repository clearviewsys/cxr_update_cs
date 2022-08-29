//%attributes = {}
// ----------------------------------------------------
// User name (OS): viktor
// Date and time: 06/05/21, 20:27:49
// ----------------------------------------------------
// Method: checkBulkEmails
// Description
// This method will start a new process that will check email validity
//
// Parameters
var $settingsObj; $1 : Object
// ----------------------------------------------------
// Variables 
var $process : Integer

Case of 
	: (Count parameters:C259=1)
		$settingsObj:=$1
		//  $settingsObj:= {
		//                    "criteria" : collection
		//                    "countEmails" : integer
		//                    "entitySelection" : Entity Selection
		//                    "tableName" " String
		//                    "fieldNames" : {                     // *Field names NOT values
		//                                      "email": String
		//                                      "isValid": String
		//                                   }
		//                 }
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$process:=New process:C317("checkAllEmailsProcess"; 0; "checkAllEmailsProcess"; $settingsObj)

