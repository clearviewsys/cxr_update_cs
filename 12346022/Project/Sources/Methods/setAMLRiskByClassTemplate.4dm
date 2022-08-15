//%attributes = {}
//setAMLRiskByClassTemplate(templateID)

C_TEXT:C284($RiskTemplateID; $1)
$RiskTemplateID:=$1
C_POINTER:C301($ObjectPtr; $dialPtr; $ObjectPepPtr)

//queryByID (->[AML_RiskTemplates];$RiskTemplateID)
READ ONLY:C145([AML_RiskTemplates:138])
QUERY:C277([AML_RiskTemplates:138]; [AML_RiskTemplates:138]RiskTemplateID:2=$RiskTemplateID)

If (Records in selection:C76([AML_RiskTemplates:138])>=1)
	[Customers:3]AML_RiskGroup:107:=[AML_RiskTemplates:138]RiskTemplateID:2
	
	[Customers:3]AML_RiskRating:75:=[AML_RiskTemplates:138]RiskRating:4
	$ObjectPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "isHighRisk")
	$dialPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "rulerRiskRating")
	$ObjectPtr->:=[Customers:3]AML_RiskRating:75
	Case of 
		: ($ObjectPtr->=0)  // unchecked
			$dialPtr->:=0
		: (($ObjectPtr->)>=4)  // checked (high risk)
			$dialPtr->:=4
		: (($ObjectPtr->)<=1)  // mixed state (not high risk)
			$dialPtr->:=3
	End case 
	handleHighRiskCheckbox($ObjectPtr)
	handleRiskRatingDial($dialPtr; $ObjectPtr)
	
	Case of 
		: ([AML_RiskTemplates:138]isOnHold:8=1)  // force to set to true
			[Customers:3]isOnHold:52:=True:C214
		: ([AML_RiskTemplates:138]isOnHold:8=2)  // force to set to false
			[Customers:3]isOnHold:52:=False:C215
	End case 
	
	Case of 
		: ([AML_RiskTemplates:138]isSuspicious:9=1)
			[Customers:3]AML_isSuspicious:49:=True:C214
		: ([AML_RiskTemplates:138]isSuspicious:9=2)
			[Customers:3]AML_isSuspicious:49:=False:C215
	End case 
	handleCustomerRedFlagSigns
	
	If ([Customers:3]AML_isPEP:80=0)
		[Customers:3]AML_isPEP:80:=[AML_RiskTemplates:138]isPEP:10
		$ObjectPepPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "isPEP")
		$ObjectPepPtr->:=[AML_RiskTemplates:138]isPEP:10
		handleTristateCheckBox($ObjectPepPtr; ->[Customers:3]AML_isPEP:80; "PEP Determination not done!"; "This customer is a PEP!"; "Customer is not a PEP!"; Dark grey:K11:12; Red:K11:4; Blue:K11:7)
	End if 
	
	If ([Customers:3]AML_SOF_SOW:38="")
		[Customers:3]AML_SOF_SOW:38:=[AML_RiskTemplates:138]SOF:11
	End if 
	
	If ([Customers:3]AML_POT:45="")
		[Customers:3]AML_POT:45:=[AML_RiskTemplates:138]POT:12
	End if 
	
	If ([Customers:3]AML_NatureofBusRelationship:39="")
		[Customers:3]AML_NatureofBusRelationship:39:=[AML_RiskTemplates:138]PIN:13
	End if 
	
End if 
