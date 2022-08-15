//%attributes = {}
// handleDD_AML (Self: pointer; inSelection: boolean ; formEvent: longint)
// this method is called from the misc pulldown menu in the Customers.Listbox form
// this menu has a multi-purpose function 
// PRE: 
// POST: the current seletion of records in Customers table will be affected
// Unit-test No complete yet: ut_handleDD_CustomerAML
// @tiran

C_POINTER:C301($self; $1)  // added by @tiran
C_BOOLEAN:C305($inSelection; $2)
C_LONGINT:C283($formEvent; $3)
C_LONGINT:C283($selectedRow)
C_DATE:C307($fromDate; $toDate)

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
	
	APPEND TO ARRAY:C911($self->; "AML Fiters:")
	APPEND TO ARRAY:C911($self->; "On HOLD")
	
	APPEND TO ARRAY:C911($self->; "Due for KYC Review")
	APPEND TO ARRAY:C911($self->; "Due for Risk Review")
	
	APPEND TO ARRAY:C911($self->; "Expired Picture IDs")
	APPEND TO ARRAY:C911($self->; "Missing KYC Info")
	APPEND TO ARRAY:C911($self->; "Not recently checked against sanction lists")
	APPEND TO ARRAY:C911($self->; "With Large Picture IDs")
	APPEND TO ARRAY:C911($self->; "Name Matched on Sanction List")
	APPEND TO ARRAY:C911($self->; "PEP")
	APPEND TO ARRAY:C911($self->; "HIO")
	
	APPEND TO ARRAY:C911($self->; "Business relationship not assigned")
	APPEND TO ARRAY:C911($self->; "In a business relationship")
	APPEND TO ARRAY:C911($self->; "Business relationship terminated")
	
	APPEND TO ARRAY:C911($self->; "Suspicous Customers")
	APPEND TO ARRAY:C911($self->; "Insiders Only (self)")
	APPEND TO ARRAY:C911($self->; "Whitelisted")
	APPEND TO ARRAY:C911($self->; "KYC Ignored")
	APPEND TO ARRAY:C911($self->; "External Accounts")
	APPEND TO ARRAY:C911($self->; "Walkin Customers Only")
	
	$self->:=1  // select the first item 
End if 


C_TEXT:C284($selection)

If ($formEvent=On Clicked:K2:4)
	$selectedRow:=$self->
	$selection:=$Self->{$selectedRow}
	
	READ ONLY:C145([Customers:3])
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	If ($inSelection=False:C215)  // query in selection
		ALL RECORDS:C47([Customers:3])
	End if 
	
	Case of 
		: ($selectedRow=0)
			
		: ($selectedRow=1)  // 
			
		: ($selectedRow=2)  // on hold 
			QUERY SELECTION:C341([Customers:3]; [Customers:3]isOnHold:52=True:C214)
			
		: ($selectedRow=3)  // due for review
			QUERY SELECTION BY FORMULA:C207([Customers:3]; isCustomerDueForKYCReview=True:C214)
			
		: ($selectedRow=4)  // due for risk Review
			QUERY SELECTION BY FORMULA:C207([Customers:3]; isCustomerDueForRiskReview=True:C214)
			
		: ($selectedRow=5)  // expired ID
			QUERY SELECTION:C341([Customers:3]; [Customers:3]PictureID_ExpiryDate:71<=Current date:C33; *)
			QUERY SELECTION:C341([Customers:3];  & ; [Customers:3]PictureID_ExpiryDate:71>!00-00-00!)
			
		: ($selectedRow=6)  // Missing KYC Info
			C_LONGINT:C283($WinRef)
			$winRef:=openFormWindow(->[Customers:3]; "KYCQuery")
			BRING TO FRONT:C326($winRef)
			
		: ($selectedRow=7)  // Sanction list check is old
			C_TEXT:C284($answer)
			C_LONGINT:C283($month)
			$month:=6
			$answer:=myRequest("How many months?"; String:C10($month))
			QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_LastSanctionListCheckDate:99<=(Add to date:C393(Current date:C33; 0; ($month*-1); 0)))
			
		: ($selectedRow=8)  // large picture IDs
			
			C_LONGINT:C283($size)
			$size:=Num:C11(Request:C163("Find picture IDs larger than (KB)"))*1000
			If (OK=1)
				QUERY SELECTION BY FORMULA:C207([Customers:3]; Picture size:C356([Customers:3]PictureID_Image:53)>$size)
			Else 
				REDUCE SELECTION:C351([Customers:3]; 0)
			End if 
			
		: ($selectedRow=9)  // matched on Sanction List
			QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_hasPositiveMatchOnSL:92=True:C214)
			// [Customers];"review_AML"
			
		: ($selectedRow=10)  // PEP
			QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_isPEP:80=1)
			
		: ($selectedRow=11)  // HIO
			QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_isHIO:124=1)
			
		: ($selectedRow=12)  // Business Relationship undefined
			QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_isInBusinessRelation:115=0)
			
		: ($selectedRow=13)  // Business Relationship started
			QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_isInBusinessRelation:115=1)
			
		: ($selectedRow=14)  // Business Relationship stoped
			QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_isInBusinessRelation:115=2)
			
		: ($selectedRow=15)  // Suspicious
			QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_isSuspicious:49=True:C214)
			
		: ($selectedRow=16)  // Insiders
			QUERY SELECTION:C341([Customers:3]; [Customers:3]isInsider:102=True:C214)
			
		: ($selectedRow=17)  // Whitelisted
			QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_isWhitelisted:131=True:C214)
			
		: ($selectedRow=18)  // ignored KYC
			QUERY SELECTION:C341([Customers:3]; [Customers:3]AML_ignoreKYC:35=True:C214)
			
		: ($selectedRow=19)  // Accounts
			QUERY SELECTION:C341([Customers:3]; [Customers:3]isAccount:34=True:C214)
			
		: ($selectedRow=20)  // Walkin Customers Only
			QUERY SELECTION:C341([Customers:3]; [Customers:3]isWalkin:36=True:C214)
		Else 
			myAlert("Invalid selection")
	End case 
	POST OUTSIDE CALL:C329(Current process:C322)
	
/*
C_LONGINT($n)
$n:=Records in selection([Customers])
If ($n>0)
myAlert("Found <X> records matching <Y>";"Found";String($n);$selection)
//orderbyCustomers
Else 
myAlert("No records found matching "+$selection)
End if 
*/
End if 

