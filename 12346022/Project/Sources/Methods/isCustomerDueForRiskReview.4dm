//%attributes = {}
// isCustomerDueForReview : boolean
// return true if customer is due for risk review
// PRE: Customer profile must be loaded
// note: Customer must be in a business relationship with us (in Canada only) - current not taking in 
// last risk review of the customer is long time 

C_BOOLEAN:C305($0)
$0:=False:C215

C_DATE:C307($reviewDate; $lastReviewDate)

If (([Customers:3]isAccount:34) | ([Customers:3]AML_ignoreKYC:35) | ([Customers:3]isWalkin:36) | ([Customers:3]isCompany:41))
	$0:=False:C215
Else 
	
	If ((<>reviewCustomerAfterNDays>0) & (isCustomerNotSelfNOrWalkin([Customers:3]CustomerID:1)))
		// find the last review 
		//[AML_ReviewLog]ReviewDate
		C_DATE:C307($lastReviewDate; $nextReviewDate)
		C_OBJECT:C1216($lastReview)
		
		// #ORDA
		$lastReview:=ds:C1482.AML_ReviewLog.query("CustomerID = :1 order by ReviewDate asc"; [Customers:3]CustomerID:1).first()
		
		If ($lastReview=Null:C1517)
			// this record has never had a risk review done on it
			// so check when the record was created
			// or if we are in a business relationship
			$lastReviewDate:=[Customers:3]CreationDate:54  // this may need to be changed to if customer is in business relationship
		Else 
			$lastReviewDate:=$lastReview.ReviewDate
		End if 
		
		$nextReviewDate:=Add to date:C393($lastReviewDate; 0; 0; <>reviewCustomerAfterNDays)  // add n days to last review date
		
		If ($nextReviewDate<=Current date:C33)  // if the next review date is in the past then it's time for review
			$0:=True:C214
		End if 
		
	Else 
		$0:=False:C215
	End if 
	
End if 
