//%attributes = {}
// newAML_AggrRule
// this constructor will make a new entity but won't save it. 
//[AML_AggrRules];"match"

C_OBJECT:C1216($entity; $0)
C_LONGINT:C283($row)

$entity:=ds:C1482.AML_AggrRules.new()
$entity.UUID:=Generate UUID:C1066
//$entity.ruleID:=makeAMLRuleID  // not sure why this isn't working 
$row:=ds:C1482.AML_AggrRules.all().length+1  // $row
$entity.ruleName:="New Blank Rule "+String:C10($row)
$entity.rowNo:=$row
$entity.isActive:=False:C215

$entity.thenRequireKYC:=New object:C1471
$entity.thenRequireKYC.pictureID:=0
$entity.thenRequireKYC.occupation:=0
$entity.thenRequireKYC.DOB:=0
$entity.thenRequireKYC.SIN:=0
$entity.thenRequireKYC.address:=0
$entity.thenRequireKYC.countryCode:=0
$entity.thenRequireKYC.nationality:=0
$entity.thenRequireKYC.citizenship:=0
$entity.thenRequireKYC.PIN:=0
$entity.thenRequireKYC.phone:=0
$entity.thenRequireKYC.cell:=0
$entity.thenRequireKYC.email:=0
$entity.thenRequireKYC.optInEmail:=0
$entity.thenRequireKYC.optInSMS:=0

// EDD Requirements
$entity.thenEDD:=False:C215
$entity.thenRequirePOT:=False:C215
$entity.thenRequireSOF:=False:C215
$entity.thenRequireTPD:=False:C215
$entity.thenRequirePEP:=False:C215

// Actions
$entity.thenReject:=False:C215
$entity.thenAML_Alert:=True:C214
$entity.thenSetFlag:=False:C215
$entity.thenSetLCT:=False:C215
$entity.thenSetEFT:=False:C215
$entity.thenSetSTR:=False:C215
$entity.thenWarn:=False:C215
$entity.WarningMessage:=""
$entity.thenSetReportable:=False:C215
$entity.thenRequireApproval:=False:C215

$entity.thenReportInDays:=0
$entity.thenStop:=False:C215

$entity.thenAddTag:=""
$entity.thenExecuteMethod:=""

$0:=$entity