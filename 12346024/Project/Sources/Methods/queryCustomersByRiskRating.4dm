//%attributes = {}
// queryCustomersByRiskRating (Risk: {0=5} ; inSelection: bool)
// queries the Customers table based on the risk rating of the customer
// POST: will change the current selection of records in Customers ; this will affect the sort order of customers
// this method needs a proper unit testing

// given risk Rating 1 ; should expect 1 only ; lowest risk
// given risk Rating 2 ; should expect 1 or 2 ; low risk
// given risk Rating 3 ; should expect 3  ; moderate risk
// given risk Rating 4 ; should export 4 or 5 ; high risk
// given risk Rating 5 ; should expect 5 only ; highest Risk

C_LONGINT:C283($riskRating; $1)
C_BOOLEAN:C305($inSelection; $2)

$riskRating:=0
$inSelection:=False:C215

Case of 
	: (Count parameters:C259=0)
		
	: (Count parameters:C259=1)
		$riskRating:=$1
		
	: (Count parameters:C259=2)
		$riskRating:=$1
		$inSelection:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($inSelection)
	
	Case of 
		: ($riskRating=2)  // low risk should also show lowest risk
			QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_RiskRating:75=2; *)
			QUERY SELECTION:C341([Customers:3];  | ; [Customers:3]AML_RiskRating:75=1; *)
			QUERY SELECTION:C341([Customers:3];  | ; [Customers:3]AML_HighRisk:24=2)  // not high risk
			
		: ($riskRating=4)  // high risk should also find highest risk
			C_LONGINT:C283($max)
			$max:=calcMax(4; $riskRating)
			QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_RiskRating:75>=$max; *)
			QUERY SELECTION:C341([Customers:3];  | ; [Customers:3]AML_HighRisk:24=1)  // high risk
			
		Else   // {0 , 1, 3, 5}
			QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_RiskRating:75=$riskRating)
	End case 
	
Else 
	
	Case of 
		: ($riskRating=2)  // low risk should also show lowest risk
			QUERY:C277([Customers:3]; [Customers:3]AML_RiskRating:75=2; *)
			QUERY:C277([Customers:3];  | ; [Customers:3]AML_RiskRating:75=1; *)
			QUERY:C277([Customers:3];  | ; [Customers:3]AML_HighRisk:24=2)  // not high risk
			
		: ($riskRating=4)  // high risk should also find highest risk
			C_LONGINT:C283($max)
			$max:=calcMax(4; $riskRating)
			QUERY:C277([Customers:3]; [Customers:3]AML_RiskRating:75>=$max; *)
			QUERY:C277([Customers:3];  | ; [Customers:3]AML_HighRisk:24=1)  // high risk
			
		Else   // {0 , 1, 3, 5}
			QUERY:C277([Customers:3]; [Customers:3]AML_RiskRating:75=$riskRating)
	End case 
	
End if 