//%attributes = {}
// matchAMLRules ("received/paid";method;submethod;amount;curr;isamountLC): boolean

C_TEXT:C284($1; $recPaid)
C_TEXT:C284($2; $method)
C_TEXT:C284($3; $subMethod)
C_REAL:C285($4; $amount)
C_TEXT:C284($5; $curr)
C_REAL:C285($6; $amountLC)


C_BOOLEAN:C305($0; $match)
$match:=False:C215  // assume there is no match

$recPaid:=$1
$method:=$2
$subMethod:=$3
$amount:=$4
$curr:=$5
$amountLC:=$6


C_BOOLEAN:C305($preCondition; <>useAMLRules)

// these are the preconditions (The parameter that should absolutely non-blank, or passed for the rule based system to start working)
$preCondition:=<>useAMLRules  // this should be true before we check for other conditions
$preCondition:=($preCondition & ($recPaid#""))
$preCondition:=($preCondition & ($method#""))
$preCondition:=($preCondition & ($amount#0))
$preCondition:=($preCondition & ($curr#""))
//$preCondition:=($preCondition & ($customerID#""))

If ($preCondition)  // first check to see if all necessary parameters are passed
	C_LONGINT:C283($i; $n)
	READ ONLY:C145([AMLRules:74])
	READ ONLY:C145([Customers:3])
	
	ALL RECORDS:C47([AMLRules:74])
	ORDER BY:C49([AMLRules:74]; [AMLRules:74]RuleNo:9; >)
	
	$n:=Records in selection:C76([AMLRules:74])
	$i:=1
	
	Repeat 
		GOTO SELECTED RECORD:C245([AMLRules:74]; $i)
		LOAD RECORD:C52([AMLRules:74])
		
		If (isAMLRuleMatching($recPaid; $method; $subMethod; $amount; $curr; $amountLC))
			$match:=True:C214
			notifyUser("AML Rule"+[AMLRules:74]RuleName:1+" matched"; True:C214)
			checkKYCRequirements
			
			// make the mutations (SETTERS) here
			// **********************************************************
			// this should be changed in the future to keep the lines that need to be applied in an array and then after 
			// this loop is done, apply the changes to the lines one by one... some of the setter may be unessary if the 
			// user decides to cancel or change the transaction (eg. a reportable flag should only be set if no more errors exist)
			
			If (Not:C34(checkErrorExist))
				
				If ([AMLRules:74]thenSetReportable:15)
					[Invoices:5]AMLReportName:75:=[AMLRules:74]thenSetReportName:30
					[Registers:10]AML_reportName:49:=[AMLRules:74]thenSetReportName:30
					If ([AMLRules:74]thenMustReportAfterDays:53>0)  // set the deadline for reporting if any deadline is assigned
						C_DATE:C307($deadline; vInvoiceDate)
						$deadline:=Add to date:C393(vInvoiceDate; 0; 0; [AMLRules:74]thenMustReportAfterDays:53)
						[Invoices:5]AMLmustReportBeforeDate:78:=minDate($deadline; [Invoices:5]AMLmustReportBeforeDate:78)
						[Registers:10]AML_mustReportBefore:51:=$deadline
						
					End if 
				End if 
				// set invoices AML fields - these rules will only work if the left hand side is true, otherwise they won't affect the fields...
				// therefore if someone manually clicked the 'isreportable' in the invoice, it won't take it off even if the AML condition doesn't apply
				
				// set invoice AML fields
				setBooleanIf([AMLRules:74]thenSetReportable:15; ->[Invoices:5]isAMLReportable:46)
				setBooleanIf([AMLRules:74]thenSetAsLCT:44; ->[Invoices:5]isLCT:76)
				setBooleanIf([AMLRules:74]thenSetAsEFT:45; ->[Invoices:5]isEFT:77)
				setBooleanIf([AMLRules:74]thenSetAsSTR:46; ->[Invoices:5]isSuspicious:30)
				setBooleanIf([AMLRules:74]thenSetFlagged:21; ->[Invoices:5]isFlagged:41)
				
				// set registers AML 
				setBooleanIf([AMLRules:74]thenSetReportable:15; ->[Registers:10]isAML_Reportable:45)
				setBooleanIf([AMLRules:74]thenSetAsLCT:44; ->[Registers:10]isAML_LCT:46)
				setBooleanIf([AMLRules:74]thenSetAsEFT:45; ->[Registers:10]isAML_EFT:47)
				setBooleanIf([AMLRules:74]thenSetAsSTR:46; ->[Registers:10]isAML_STR:48)
				setBooleanIf([AMLRules:74]thenSetFlagged:21; ->[Registers:10]isFlagged:11)
				
			End if 
			// **********************************************************
			
			
			If ([AMLRules:74]thenExecuteMethod:59)
				setErrorTrap([AMLRules:74]executeMethod:60; "Problem executing method "+[AMLRules:74]executeMethod:60)
				EXECUTE METHOD:C1007([AMLRules:74]executeMethod:60)
				endErrorTrap
			End if 
			
			If ([AMLRules:74]stopEvaluating:22)
				$i:=$n  // if evaluation needs to be stopped forward the loop to the end
			End if 
			//$ruleNamePtr->:=[AMLRules]RuleName
		End if 
		UNLOAD RECORD:C212([AMLRules:74])
		$i:=$i+1
	Until ($i>$n)
End if 

$0:=$match
