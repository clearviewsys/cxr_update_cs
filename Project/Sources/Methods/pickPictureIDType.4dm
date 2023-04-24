//%attributes = {}
// pickPictureIDType (->templateID; ->pictureIDNumber; ->IDType; ->countryCode;->state;->authority; ->issueDate; -> expiryDate; ->govCode)
// this method will pick from a list of pictureID types and will automatically fill in the default country, state, and city (if provided)

C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9)
C_BOOLEAN:C305($10; $isForced)

C_POINTER:C301($abbrPtr; $pid_No_ObjectPtr; $pictureIDTypePtr; $countryPtr; $IssuingStatePtr; $AuthorityPtr; $issueDatePtr; $expiryDatePtr; $govCodePtr)

$abbrPtr:=$1  // abbrPtr
$pid_No_ObjectPtr:=$2
$pictureIDTypePtr:=$3
$countryPtr:=$4
$IssuingStatePtr:=$5
$AuthorityPtr:=$6  // could be used as city
$issueDatePtr:=$7
$expiryDatePtr:=$8
$govCodePtr:=$9

Case of 
	: (Count parameters:C259=9)
		$isForced:=False:C215
	: (Count parameters:C259=10)
		$isForced:=$10
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

pickPictureIDTypes($abbrPtr; $isForced)  // pick the record from [pictureIDTypes]

If (OK=1)
	// set the values from the template
	setIfNotNullString($pictureIDTypePtr; [PictureIDTypes:92]PictureIDType:5)
	setIfNotNullString($countryPtr; [PictureIDTypes:92]CountryCode:4)
	setIfNotNullString($IssuingStatePtr; [PictureIDTypes:92]State:3)
	setIfNotNullString($AuthorityPtr; [PictureIDTypes:92]Authority:2)
	setIfNotNullString($govCodePtr; [PictureIDTypes:92]GovernmentCode:15)
	
	// the following lines will change the behavior of a UI object (entry field)
	If (Not:C34(Is nil pointer:C315($pictureIDTypePtr)))
		OBJECT SET FILTER:C235($pid_No_ObjectPtr->; [PictureIDTypes:92]EntryFilter:11)
		OBJECT SET FORMAT:C236($pid_No_ObjectPtr->; [PictureIDTypes:92]DisplayFormat:13)
	End if 
	// [PictureIDTypes] 
	// ([customers];"Entry")
	
	setFieldLookAsMandatory($pictureIDTypePtr; True:C214)  // always required
	setFieldLookAsMandatory($pid_No_ObjectPtr; True:C214)  // always required
	
	setFieldLookAsMandatory($issueDatePtr; [PictureIDTypes:92]isIssuingDateMandatory:20)
	setFieldLookAsMandatory($expiryDatePtr; [PictureIDTypes:92]isExpiryDateMandatory:16)
	setFieldLookAsMandatory($countryPtr; [PictureIDTypes:92]isIssuingCountryMandatory:18)
	setFieldLookAsMandatory($IssuingStatePtr; [PictureIDTypes:92]isIssuingStateMandatory:17)
	setFieldLookAsMandatory($AuthorityPtr; [PictureIDTypes:92]isIssuingAuthMand:19)
	
End if 

