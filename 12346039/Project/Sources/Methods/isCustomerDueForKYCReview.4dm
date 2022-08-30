//%attributes = {}
// isCustomerDueForReview 
// return true if customer is due for review
// PRE: Customer profile must be loaded


C_BOOLEAN:C305($0)
$0:=False:C215

C_DATE:C307($reviewDate; $lastReviewDate)

If (([Customers:3]isAccount:34) | ([Customers:3]AML_ignoreKYC:35) | ([Customers:3]isWalkin:36) | ([Customers:3]isCompany:41))
	$0:=False:C215
Else 
	
	If ((<>reviewCustomerAfterNDays>0) & (isCustomerNotSelfNOrWalkin([Customers:3]CustomerID:1)))
		
		If ([Customers:3]ReviewDate:97=!00-00-00!)
			
			If ([Customers:3]CreationDate:54=!00-00-00!)  // new customer
				$lastReviewDate:=Current date:C33
			Else 
				$lastReviewDate:=[Customers:3]CreationDate:54
			End if 
			
		Else 
			$lastReviewDate:=[Customers:3]ReviewDate:97
		End if 
		
		Case of 
			: (([Customers:3]AML_RiskRating:75>3) | ([Customers:3]AML_HighRisk:24=1))  // high risk 4,5
				$reviewDate:=Add to date:C393($lastReviewDate; 0; 0; <>ReviewHighRiskAfterNDays)
				
			Else 
				$reviewDate:=Add to date:C393($lastReviewDate; 0; 0; <>reviewCustomerAfterNDays)
		End case 
		
		If ($reviewDate<Current date:C33)  // don't change to <= or else new customers will require validation
			$0:=True:C214
		Else 
			$0:=False:C215
		End if 
		
	Else 
		$0:=False:C215
	End if 
	
End if 
