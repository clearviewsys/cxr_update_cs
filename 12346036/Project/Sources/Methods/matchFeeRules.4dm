//%attributes = {}
// matchFeeRules ("received/paid";method;submethod;amount;curr;amountLC; ->flatFee;->pctFee;->ruleNamePtr)

C_TEXT:C284($1; $recPaid)
C_TEXT:C284($2; $method)
C_TEXT:C284($3; $subMethod)
C_REAL:C285($4; $amount)
C_TEXT:C284($5; $curr)
C_REAL:C285($6; $amountLC)

C_POINTER:C301($7; $flatFeePtr)
C_POINTER:C301($8; $pctFeePtr)
C_POINTER:C301($9; $ruleNamePtr)
C_TEXT:C284($10; $customerGroup)

C_BOOLEAN:C305($0; $match)
$match:=False:C215  // assume there is no match
$recPaid:=$1
$method:=$2
$subMethod:=$3
$amount:=$4
$curr:=$5
$amountLC:=$6
$flatFeePtr:=$7
$pctFeePtr:=$8
$ruleNamePtr:=$9
$customerGroup:=$10

C_BOOLEAN:C305($preCondition; <>useCommissionRules)

$preCondition:=<>useCommissionRules  // this should be true before we check for other conditions
// the preconditions are sent from the invoice, not from the RULE-based database, therefore they are filled with the values from the invoice
// these are the preconditions (The parameter that should absolutely non-blank, or passed for the rule based system to start working)
$preCondition:=($preCondition & ($recPaid#""))
$preCondition:=($preCondition & ($method#""))
$preCondition:=($preCondition & ($amount#0))
$preCondition:=($preCondition & ($curr#""))
//$preCondition:=($preCondition & ($customerGroup#""))

If ($preCondition)  // first check to see if all necessary parameters are passed
	C_LONGINT:C283($i; $n)
	READ ONLY:C145([FeeRules:59])
	ALL RECORDS:C47([FeeRules:59])
	ORDER BY:C49([FeeRules:59]; [FeeRules:59]RuleNo:1; >)
	
	$n:=Records in selection:C76([FeeRules:59])
	$i:=1
	Repeat 
		GOTO SELECTED RECORD:C245([FeeRules:59]; $i)
		LOAD RECORD:C52([FeeRules:59])
		If (isFeeRuleMatching($recPaid; $method; $subMethod; $amount; $curr; $amountLC; $customerGroup))
			$match:=True:C214
			$flatFeePtr->:=[FeeRules:59]FlatFee:8
			$pctFeePtr->:=[FeeRules:59]PercentFee:9
			If ([FeeRules:59]currencyAlias:17#"")
				setVecCurrency([FeeRules:59]currencyAlias:17; True:C214)
			End if 
			
			If ([FeeRules:59]stopEvaluating:10)
				$i:=$n  // if evaluation needs to be stopped forward the loop to the end
			End if 
			//ALERT("matched with rule "+[FeeRules]RuleName)
			$ruleNamePtr->:=[FeeRules:59]RuleName:11
		End if 
		UNLOAD RECORD:C212([FeeRules:59])
		$i:=$i+1
	Until ($i>$n)
End if 

$0:=$match
