//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): viktor
// Date and time: 06/05/21, 19:49:24
// ----------------------------------------------------
// Method: openEmailValidationCriteria
// Description
// 
//
// Parameters
var $table; $1 : Pointer
var $emailProperyName; $2 : Text
var $isValidProperyName; $3 : Text
// ----------------------------------------------------

// Variable Decleration
var $oForm; $entitySelection : Object
var $winRef; $setSize : Integer
var $tableName; $setName; $emailVerApplicationID; $email_FieldName; $isValidEmail_FieldName : Text

// Initialization
$oForm:=New object:C1471()

Case of 
	: (Count parameters:C259=3)
		$table:=$1
		$email_FieldName:=$2
		$isValidEmail_FieldName:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$emailVerApplicationID:="CXW.EmailVer"

If (RAL2_isLicenseValid($emailVerApplicationID))
	// Create a SET with selected records
	$tableName:=Table name:C256($table)
	$setName:="$"+$tableName+"_LBSet"
	$setSize:=Records in set:C195($setName)
	
	If (Application type:C494#4D Server:K5:6)
		If ($setSize>0)
			USE SET:C118($setName)
			$oForm.setSize:=$setSize
			$oForm.tableName:=$tableName
			$oForm.entitySelection:=Create entity selection:C1512($table->)
			$oForm.entitySelectionNonValid:=$oForm.entitySelection.query($isValidEmail_FieldName+"#1")
			$oForm.fieldNames:=New object:C1471()
			$oForm.fieldNames.email:=$email_FieldName
			$oForm.fieldNames.isValid:=$isValidEmail_FieldName
			$oForm.hitsLeft:=RAL2_getCurrentAvailableHits($emailVerApplicationID)
			
			$winRef:=Open form window:C675("emailVerificationCriteria"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
			DIALOG:C40("emailVerificationCriteria"; $oForm)
			CLOSE WINDOW:C154($winRef)
		Else 
			myAlert("Please highlight some records first")
		End if 
	End if 
Else 
	alertInvalidEmailLicense()
End if 

