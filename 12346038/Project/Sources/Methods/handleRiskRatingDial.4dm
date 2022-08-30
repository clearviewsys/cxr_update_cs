//%attributes = {}
// handleRiskRatingDial (dialObjectPtr;->intField)
// TB 

C_LONGINT:C283(cust_vRiskRating)  // Jan 17, 2012 13:39:30 -- I.Barclay Berry 
C_POINTER:C301($objectPtr; $riskRatingFieldPtr; $highRiskFieldPtr; $1; $2; $3)
C_LONGINT:C283($highRisk)
C_TEXT:C284($objectName)

Case of 
	: (Count parameters:C259=0)
		$objectPtr:=->cust_vRiskRating
		$riskRatingFieldPtr:=->[Customers:3]AML_RiskRating:75
		$highRiskFieldPtr:=->$highRisk
		
	: (Count parameters:C259=2)
		$objectPtr:=$1
		$riskRatingFieldPtr:=$2
		$highRiskFieldPtr:=->$highRisk
		
	: (Count parameters:C259=3)
		$objectPtr:=$1
		$riskRatingFieldPtr:=$2
		$highRiskFieldPtr:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		$objectPtr->:=$riskRatingFieldPtr->  // assign the value of the dial to the field
	: (Form event code:C388#On Load:K2:1)
		$riskRatingFieldPtr->:=$objectPtr->  // assign the value of the field to the dial object
End case 
C_LONGINT:C283($risk)
$risk:=$riskRatingFieldPtr->

$objectName:="RiskRatingLabel"

OBJECT SET TITLE:C194(*; $objectName; getRiskRatingString($risk))
Case of 
	: ($risk=0)  // unassigned Risk
		// _O_OBJECT SET COLOR(*;"RiskRatingLabel";-(Black+(256*Light grey)))
		OBJECT SET RGB COLORS:C628(*; $objectName; convPalleteColourToRGB(Black:K11:16); convPalleteColourToRGB(Light grey:K11:13))
		
	: ($risk=1)  // Unknown Risk
		// _O_OBJECT SET COLOR(*;"RiskRatingLabel";-(Dark grey+(256*Light grey)))
		OBJECT SET RGB COLORS:C628(*; $objectName; convPalleteColourToRGB(Dark grey:K11:12); convPalleteColourToRGB(Light grey:K11:13))
		
	: ($risk=2)  // Fair Risk
		// _O_OBJECT SET COLOR(*;"RiskRatingLabel";-(Blue+(256*Light grey)))
		OBJECT SET RGB COLORS:C628(*; $objectName; convPalleteColourToRGB(Blue:K11:7); convPalleteColourToRGB(Light grey:K11:13))
		$highRiskFieldPtr->:=-1
		
	: ($risk=3)  // moderate risk | DD
		// _O_OBJECT SET COLOR(*;"RiskRatingLabel";-(Orange+(256*Light grey)))
		OBJECT SET RGB COLORS:C628(*; $objectName; convPalleteColourToRGB(Orange:K11:3); convPalleteColourToRGB(Light grey:K11:13))
		$highRiskFieldPtr->:=-1
		
	: ($risk=4)  // high risk - | EDD
		// _O_OBJECT SET COLOR(*;"RiskRatingLabel";-(Red+(256*Light grey)))
		OBJECT SET RGB COLORS:C628(*; $objectName; convPalleteColourToRGB(Red:K11:4); convPalleteColourToRGB(Light grey:K11:13))
		$highRiskFieldPtr->:=1
		
	: ($risk=5)  // high risk - high certainty
		// _O_OBJECT SET COLOR(*;"RiskRatingLabel";-(Red+(256*Black)))
		OBJECT SET RGB COLORS:C628(*; $objectName; convPalleteColourToRGB(Red:K11:4); convPalleteColourToRGB(Black:K11:16))
		$highRiskFieldPtr->:=1
		
End case 

