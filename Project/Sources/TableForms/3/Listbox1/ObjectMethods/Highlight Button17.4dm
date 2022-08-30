//C_DATE($date)
//If (<>reviewCustomerAfterNDays>0)
//$reviewDate:=Add to date(Current date;0;0;-1*<>reviewCustomerAfterNDays)
//
//SET QUERY DESTINATION(Into set;"$ReviewDueSet")
//  // review dates are older but were reviewed at some point in the past
//QUERY([Customers];[Customers]LastProfileValidationDate<=$reviewDate;*)
//QUERY([Customers]; & ;[Customers]LastProfileValidationDate#!00/00/0000!;*)
//QUERY([Customers]; & ;[Customers]isCompany=False;*)
//QUERY([Customers]; & ;[Customers]isSelf=False)
//
//SET QUERY DESTINATION(Into set;"$NeverReviewedSet")
//  // creation dates are old and never reviewed in the past
//QUERY([Customers];[Customers]CreationDate<=$reviewDate;*)
//QUERY([Customers]; & ;[Customers]LastProfileValidationDate=!00/00/0000!;*)
//QUERY([Customers]; & ;[Customers]isCompany=False;*)
//QUERY([Customers]; & ;[Customers]isSelf=False)
//
//UNION("$ReviewDueSet";"$NeverReviewedSet";"$ReviewDueSet")
//USE SET("$ReviewDueSet")
//CLEAR SET("$ReviewDueSet")
//CLEAR SET("$NeverReviewedSet")
//SET QUERY DESTINATION(Into current selection)
//
//End if
C_LONGINT:C283(cbQuerySelection)
If (cbQuerySelection=1)
	QUERY SELECTION BY FORMULA:C207([Customers:3]; isCustomerDueForKYCReview=True:C214)
	
Else 
	QUERY BY FORMULA:C48([Customers:3]; isCustomerDueForKYCReview=True:C214)
End if 