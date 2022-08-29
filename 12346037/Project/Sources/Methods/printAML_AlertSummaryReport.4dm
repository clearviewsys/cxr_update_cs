//%attributes = {}
// printAML_AlertSummaryReport
// written by Tiran on July 15/2021
// This report was originally designed for BOJ
// It prints a summary of invoices that match against a certain rule
// it also print out if there are no matches
// #orda ; #selection ; #needTesting ; 



C_OBJECT:C1216(formObj)
C_DATE:C307(vFromDate; vToDate)
C_LONGINT:C283($i; $n)
C_TEXT:C284($reportName)

ARRAY TEXT:C222($arrRules; 0)
ARRAY TEXT:C222($arrRuleNames; 0)
ARRAY TEXT:C222($arrDescription; 0)
requestDateRange

If (OK=1)
	
	QUERY:C277([AML_AggrRules:150]; [AML_AggrRules:150]isActive:4=True:C214)
	SELECTION TO ARRAY:C260([AML_AggrRules:150]ruleID:53; $arrRules; [AML_AggrRules:150]ruleName:2; $arrRuleNames; [AML_AggrRules:150]description:3; $arrDescription)
	
	$n:=Size of array:C274($arrRules)
	
	formObj:=New object:C1471
	formObj.title:="Summary of Transactions Matching with AML Rules"
	
	If (ds:C1482.CompanyInfo.all()[0]#Null:C1517)
		formObj.logo:=ds:C1482.CompanyInfo.all()[0].Logo
	Else 
		C_PICTURE:C286($picture)
		formObj.logo:=$picture
	End if 
	
	formObj.user:=getApplicationUser
	formObj.printTimeStamp:=String:C10(Current date:C33; Date RFC 1123:K1:11)
	formObj.version:=getCurrentVersion
	
	
	
	PRINT SETTINGS:C106
	If (Ok=1)
		formObj.dateRange:=String:C10(vFromDate)+" to "+String:C10(vToDate)
		$reportName:="rep_Summary"
		
		Print form:C5([AML_Alerts:137]; $reportName; Form header:K43:3)
		
		SORT ARRAY:C229($arrRules; $arrRuleNames; $arrDescription)
		C_LONGINT:C283($matches; $j)
		$j:=0
		
		For ($i; 1; $n)
			QUERY:C277([AML_Alerts:137]; [AML_Alerts:137]ruleID:15=$arrRules{$i})
			
			If (Records in selection:C76([AML_Alerts:137])>0)
				SELECTION TO ARRAY:C260([AML_Alerts:137]recordID:3; $arrInvoices)
				QUERY WITH ARRAY:C644([Invoices:5]InvoiceID:1; $arrInvoices)
				QUERY SELECTION:C341([Invoices:5]; [Invoices:5]invoiceDate:44>=vFromDate; *)
				QUERY SELECTION:C341([Invoices:5]; [Invoices:5]invoiceDate:44<=vToDate)
				
				$matches:=Records in selection:C76([Invoices:5])
				$j:=$j+1
			Else 
				$matches:=0
			End if 
			formObj.matches:=String:C10($matches; "###;0;0")
			formObj.rule:=$arrRules{$i}+" : "+$arrRuleNames{$i}
			formObj.description:=$arrDescription{$i}
			
			Print form:C5([AML_Alerts:137]; $reportName; Form detail:K43:1)
		End for 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		//printFormsTable
		formObj.totalMatches:=String:C10($j)
		formObj.totalRules:=String:C10($n)
		Print form:C5([AML_Alerts:137]; $reportName; Form break0:K43:14)
		
		PAGE BREAK:C6
	End if 
	
Else 
	// cancel was pressed
End if 

CLEAR VARIABLE:C89(formObj)  // cleaning up memory from a large object
