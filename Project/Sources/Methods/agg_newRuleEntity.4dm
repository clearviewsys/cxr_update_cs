//%attributes = {}
// agg_newRuleEntity
// this constructor will make a new AggrRule entity but won't save it. 
//[AML_AggrRules];"match"
//[AML_AggrRules];"ListBox")
// see also : agg_thenApplyAMLRuleActions()

C_OBJECT:C1216($entity; $0)
C_LONGINT:C283($row)

$entity:=ds:C1482.AML_AggrRules.new()

$entity.UUID:=Generate UUID:C1066
$row:=ds:C1482.AML_AggrRules.all().length+1  // $row
$entity.ruleName:="Rule "+String:C10($row)
$entity.rowNo:=$row
$entity.isActive:=False:C215

$entity.ifObj:=New object:C1471
$entity.thenObj:=New object:C1471
$entity.whenObj:=New object:C1471

$entity.whenObj.events:=New collection:C1472  // e.g. In Background, Manual, Before, During, After, Customer, etc.

$entity.ifObj.purposeOfTransactions:=New collection:C1472
$entity.ifObj.sourceOfFunds:=New collection:C1472
$entity.ifObj.typeOfTransactions:=New collection:C1472
$entity.ifObj.currencies:=New collection:C1472
$entity.ifObj.destinationCountries:=New collection:C1472

$entity.ifObj.highRiskCountriesCountGTOE:=0
$entity.ifObj.highRiskPOTsCountGTOE:=0
$entity.ifObj.highRiskSOFsCountGTOE:=0

$entity.ifObj.isPEP:=0  // threestate checkbox
$entity.ifObj.invoiceCountGTOE:=0

$entity.ifObj.province:=""  // province of residence
$entity.ifObj.countryCode:=""  // country of residence
$entity.ifObj.isCheque:=0  // threestate checkbox
$entity.ifObj.isBank:=0  // threestate checkbox


// then ----------------------------------------------------------


//$entity.ruleID:=makeAMLRuleID  // not sure why this isn't working 

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

$entity.thenObj.setCustomerRiskRating:=0
$entity.thenObj.setCustomerNextReviewDate:=0  // number of days to the next review (1 means next day)

$entity.thenObj.setCustomerOnHold:=False:C215
$entity.thenObj.setCustomerAsSuspicious:=False:C215
$entity.thenObj.setCustomerRiskRating:=0
$entity.thenObj.setCustomerNextReviewInDays:=0
$entity.thenObj.setCustomerBusinessRelationship:=False:C215

$0:=$entity