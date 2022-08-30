//%attributes = {}
// hasCustomSearchForm (->[table]) -> true or false

C_POINTER:C301($tablePtr; $1)
C_BOOLEAN:C305($0)
$tablePtr:=$1
C_LONGINT:C283($tableNum)
$tableNum:=Table:C252($tablePtr)

Case of 
	: ($tableNum=Table:C252(->[Accounts:9]))
		$0:=True:C214
		
	: ($tableNum=Table:C252(->[Bookings:50]))
		$0:=True:C214
		
	: ($tableNum=Table:C252(->[Invoices:5]))
		$0:=True:C214
		
	: ($tableNum=Table:C252(->[Registers:10]))
		$0:=True:C214
		
	: ($tableNum=Table:C252(->[RegistersAuditTrail:88]))
		$0:=True:C214
		
		
	: ($tableNum=Table:C252(->[Customers:3]))
		$0:=True:C214
		
	: ($tableNum=Table:C252(->[Cheques:1]))
		$0:=True:C214
		
	: ($tableNum=Table:C252(->[eWires:13]))
		$0:=True:C214
		
	: ($tableNum=Table:C252(->[Wires:8]))
		$0:=True:C214
		
	: ($tableNum=Table:C252(->[IC_FailedRecords:49]))
		$0:=True:C214
		
	: ($tableNum=Table:C252(->[WireTemplates:42]))
		$0:=True:C214
		
	: ($tableNum=Table:C252(->[Mailboxes:56]))
		$0:=True:C214
		
	: ($tableNum=Table:C252(->[ExceptionsLog:75]))
		$0:=True:C214
		
	Else 
		$0:=False:C215
End case 