//%attributes = {}
C_REAL:C285($debit; $credit)
getCustomerBalanceDue(vCustomerID; ->$debit; ->$credit; ->vCustomerBalanceDue)
OBJECT SET VISIBLE:C603(*; "customerOws@"; (vCustomerBalanceDue#0))
Case of 
	: (vCustomerBalanceDue>0)
		colourizeObject("customerOws@"; White:K11:1; Red:K11:4)
		
	: (vCustomerBalanceDue<0)
		colourizeObject("customerOws@"; White:K11:1; Blue:K11:7)
End case 