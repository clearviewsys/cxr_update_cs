//%attributes = {}
// handleDD_RiskRating
// controller method that handles the dropdown menu for Risk Rating queries in the Customers.ListBox form
// #classic ; requires proper #unittesting

C_POINTER:C301($self; $1)  // added by @tiran
C_BOOLEAN:C305($inSelection; $2)
C_LONGINT:C283($formEvent; $3)
C_LONGINT:C283($selectedRow)
C_DATE:C307($fromDate; $toDate)
C_LONGINT:C283($riskRating)

$inSelection:=False:C215
$formEvent:=Form event code:C388

Case of 
	: (Count parameters:C259=0)
		$self:=Self:C308
		
	: (Count parameters:C259=1)
		$self:=$1
		
	: (Count parameters:C259=2)
		$self:=$1
		$inSelection:=$2
		
	: (Count parameters:C259=3)
		$self:=$1
		$inSelection:=$2
		$formEvent:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If ($formEvent=On Load:K2:1)
	ARRAY TEXT:C222($self->; 0)
	APPEND TO ARRAY:C911($self->; "Risk...")
	APPEND TO ARRAY:C911($self->; "Not Rated ❓")
	APPEND TO ARRAY:C911($self->; "Lowest Risk")
	APPEND TO ARRAY:C911($self->; "Low Risk ")
	APPEND TO ARRAY:C911($self->; "⚫ Moderate Risk ")
	APPEND TO ARRAY:C911($self->; " > High Risk ⚡")
	APPEND TO ARRAY:C911($self->; " > Highest Risk ⚡⚡")
	APPEND TO ARRAY:C911($self->; "- Checked Non-high-risk")
	APPEND TO ARRAY:C911($self->; "- Checked High Risk")
	APPEND TO ARRAY:C911($self->; "Suspicious Customers")
	
	$self->:=1  // select the first item 
End if 

If ($formEvent=On Clicked:K2:4)
	$selectedRow:=$self->
	Case of 
		: ($selectedRow=0)
			
		: ($selectedRow=1)
			//allRecordsCustomers 
			
		: ($selectedRow=2)  // unassigned risk
			If ($inSelection)
				QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_RiskRating:75=0; *)
				QUERY SELECTION:C341([Customers:3];  | ; [Customers:3]AML_HighRisk:24=0)
			Else 
				QUERY:C277([Customers:3]; [Customers:3]AML_RiskRating:75=0; *)
				QUERY:C277([Customers:3];  | ; [Customers:3]AML_HighRisk:24=0)
			End if 
			
		: ($selectedRow=3)  // lowest
			queryCustomersByRiskRating(1; $inSelection)
			
		: ($selectedRow=4)  // low risk
			queryCustomersByRiskRating(2; $inSelection)
			
		: ($selectedRow=5)  // medium risk
			queryCustomersByRiskRating(3; $inSelection)
			
		: ($selectedRow=6)  // high risk
			queryCustomersByRiskRating(4; $inSelection)
			
		: ($selectedRow=7)  // highest risk
			queryCustomersByRiskRating(5; $inSelection)
			
		: ($selectedRow=8)  // non high risk (based on the checkbox only)
			If ($inSelection)
				QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_HighRisk:24=2)
			Else 
				QUERY:C277([Customers:3]; [Customers:3]AML_HighRisk:24=2)
			End if 
			
		: ($selectedRow=9)  // high risk based on the checkbox only
			If ($inSelection)
				QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_HighRisk:24=1)
			Else 
				QUERY:C277([Customers:3]; [Customers:3]AML_HighRisk:24=1)
			End if 
			
		: ($selectedRow=10)  // suspicious
			If ($inSelection)
				QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_isSuspicious:49=True:C214)
			Else 
				QUERY:C277([Customers:3]; [Customers:3]AML_isSuspicious:49=True:C214)
			End if 
		Else 
			myAlert("Invalid selection")
	End case 
	
	POST OUTSIDE CALL:C329(Current process:C322)
End if 