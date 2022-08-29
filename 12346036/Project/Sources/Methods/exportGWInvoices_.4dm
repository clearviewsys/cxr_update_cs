//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 02/09/13, 19:50:34
// ----------------------------------------------------
// Method: exportGWInvoices (filePath
// Description
//    Exports Invoices for use in GlobalWare
//    based on Galileo International -GlobalWare version 3.50
//
// Parameters
// ----------------------------------------------------

// This method was modified by Tiran on March 30th, 2013


C_TEXT:C284($1; $tPath)
C_TEXT:C284($TB; $CR)
C_TEXT:C284($tAddress; $tPath; $tRecord)
C_TEXT:C284($fileName)

$fileName:="IMPINV.dat"
$TB:=Char:C90(Tab:K15:37)
$CR:=Char:C90(Carriage return:K15:38)
//
//If (Count parameters>=1)
//$tPath:=$1
//Else 
//$tPath:=getFilePathByID ("GlobalWareExportPath")
//End if 
//
//If ($tPath="")
//$tPath:=Select folder("Select a destination folder";System folder(Desktop))
//End if 

$tPath:=$1

If (Test path name:C476($tPath)=Is a folder:K24:2)
	$tPath:=$tPath+$fileName
Else 
	$tPath:=$fileName
End if 

//
//QUERY([Invoices];[Invoices]CreationDate>=$dStart;*)
//QUERY([Invoices]; & ;[Invoices]CreationDate<=$dEnd)
//
//CREATE SET([Invoices];"$CreateSet")
//
//QUERY([Invoices];[Invoices]ModificationDate>=$dStart;*)  //<---- NOT SURE WE WHOULD BE DOING THIS
//QUERY([Invoices]; & ;[Invoices]ModificationDate<=$dEnd)
//
//CREATE SET([Invoices];"$ModifySet")
//
//UNION("$CreateSet";"$ModifySet";"$CreateSet")
//
//USE SET("$CreateSet")
//
//CLEAR SET("$CreateSet")
//CLEAR SET("$ModifySet")


// Commented the queries above and replaced with below by: Tiran Behrouz (3/30/13)
C_TIME:C306($hDocRef)
C_LONGINT:C283($i)
If (Records in selection:C76([Registers:10])>0)
	
	$hDocRef:=Create document:C266($tPath)
	
	If (OK=1)  //document was created
		
		FIRST RECORD:C50([Customers:3])
		For ($i; 1; Records in selection:C76([Customers:3]))  //loop through all selected customers and export
			
			$tRecord:="01"  //ImpRecordType -- 2
			$tRecord:=$tRecord+"0020"+$TB  //ImpBranch -- 4
			$tRecord:=$tRecord+[Registers:10]InvoiceNumber:10+$TB  //ImpInvoiceNumber  -- 9
			$tRecord:=$tRecord+String:C10([Registers:10]RegisterDate:2; System date long:K1:3)+$TB  //ImpInvoiceDate  -- 10
			$tRecord:=$tRecord+Substring:C12([Registers:10]CustomerID:5; 6; Length:C16([Registers:10]CustomerID:5))+$TB  //ImpCustomerAccount -- 10
			$tRecord:=$tRecord+"0020"+$TB  //ImpSTP  -- 4
			$tRecord:=$tRecord+"I"+$TB  //ImpSettle  -- 1
			$tRecord:=$tRecord+"1"+$TB  //ImpRevenueType  -- 1
			
			QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Registers:10]CustomerID:5)
			$tRecord:=$tRecord+Substring:C12([Customers:3]FullName:40; 1; 20)+$TB  //ImpTraveler  -- 20
			
			$tRecord:=$tRecord+"A"+$TB  //ImpFOP  -- 1
			$tRecord:=$tRecord+"N"+$TB  //ImpPrevBilled  -- 1
			
			If ([Registers:10]DebitLocal:23>0)
				$tRecord:=$tRecord+String:C10([Registers:10]DebitLocal:23)  //ImpBaseRate -- 15
			Else 
				$tRecord:=$tRecord+String:C10([Registers:10]CreditLocal:24*-1)  //ImpBaseRate -- 15
			End if 
			
			$tRecord:=$tRecord+String:C10(0)  //ImpCommPercent -- 15
			$tRecord:=$tRecord+String:C10(0)  //ImpCommAmt -- 15
			
			$tRecord:=$tRecord+""+$TB  //ImpAirline/Chain  -- 3
			$tRecord:=$tRecord+"FOREX"+$TB  //ImpProvider  -- 10
			$tRecord:=$tRecord+[Registers:10]InvoiceNumber:10+$TB  //ImpTicket/Confirm  -- 20
			$tRecord:=$tRecord+String:C10([Registers:10]RegisterDate:2; System date long:K1:3)+$TB  //ImpDepartDate  -- 10
			$tRecord:=$tRecord+String:C10([Registers:10]RegisterDate:2; System date long:K1:3)+$TB  //ImpReturnDate  -- 10
			
			$tRecord:=$tRecord+Substring:C12([Registers:10]CreatedByUserID:16; 1; 3)+$TB  //ImpBkAgt -- 3
			$tRecord:=$tRecord+Substring:C12([Registers:10]CreatedByUserID:16; 1; 3)+$TB  //ImpTktAgt -- 3
			$tRecord:=$tRecord+Substring:C12([Registers:10]CreatedByUserID:16; 1; 3)+$TB  //ImpSellAgt -- 3
			
			$tRecord:=$tRecord+""+$TB  //ImpDocType  -- 3
			$tRecord:=$tRecord+""+$TB  //ImpTicketType  -- 1
			$tRecord:=$tRecord+""+$TB  //ImpConjunct  -- 2
			$tRecord:=$tRecord+""+$TB  //ImpPnrLocator  -- 6
			$tRecord:=$tRecord+""+$TB  //ImpResSystem  -- 2
			$tRecord:=$tRecord+"I"+$TB  //ImpDomint  -- 1
			$tRecord:=$tRecord+"0020"+$TB  //ImpReportToId -- 4
			
			$tRecord:=$tRecord+""+$TB  //ImpMaxFare  -- 15
			$tRecord:=$tRecord+""+$TB  //ImpSavingCode  -- 3
			$tRecord:=$tRecord+""+$TB  //ImpLowFare  -- 15
			$tRecord:=$tRecord+""+$TB  //ImpLostSavingsCode  -- 3
			$tRecord:=$tRecord+""+$TB  //ImpSavingComment  -- 24
			$tRecord:=$tRecord+""+$TB  //ImpSort1  -- 30
			$tRecord:=$tRecord+""+$TB  //ImpSort2  -- 30
			$tRecord:=$tRecord+""+$TB  //ImpSort3  -- 30
			$tRecord:=$tRecord+""+$TB  //ImpSort4  -- 30
			$tRecord:=$tRecord+"P"+$TB  //ImpCustType  -- 1
			$tRecord:=$tRecord+""+$TB  //ImpTax1  -- 15
			$tRecord:=$tRecord+""+$TB  //ImpTax2  -- 15
			$tRecord:=$tRecord+""+$TB  //ImpTax3  -- 15
			$tRecord:=$tRecord+""+$TB  //ImpTax4  -- 15
			
			$tRecord:=$tRecord+""+$TB  //ImpMiscCharge  -- 15   <---------- WHAT IS THIS 
			$tRecord:=$tRecord+""+$TB  //ImpDiscount/Markup  -- 15
			$tRecord:=$tRecord+""+$TB  //ImpExchange  -- 15
			$tRecord:=$tRecord+"1"+$TB  //ImpBookedUnits  -- 15
			$tRecord:=$tRecord+""+$TB  //ImpSaleNumber  -- 4
			$tRecord:=$tRecord+""+$TB  //ImpCCCompany  -- 2
			$tRecord:=$tRecord+""+$TB  //ImpCCNumber  --20
			$tRecord:=$tRecord+""+$TB  //ImpCCExpDate  -- 5
			$tRecord:=$tRecord+""+$TB  //ImpCCApprovalCode  -- 8
			
			If ([Registers:10]CreditLocal:24>0)  // we sell, client buys
				$tRecord:=$tRecord+"Client Buy"+$TB  //ImpItinerary/ProvName  -- 24
			Else 
				$tRecord:=$tRecord+"Client Sell"+$TB  //ImpItinerary/ProvName  -- 24
			End if 
			
			$tRecord:=$tRecord+"WPL"+$TB  //ImpDestination  -- 3
			$tRecord:=$tRecord+""+$TB  //ImpProperty  -- 10
			
			$tRecord:=$tRecord+String:C10([Registers:10]RegisterDate:2; System date long:K1:3)+$TB  //ImpCustDueDate  -- 10
			$tRecord:=$tRecord+""+$TB  //ImpProvDueDate  -- 10
			$tRecord:=$tRecord+""+$TB  //ImpGroupID  -- 10
			$tRecord:=$tRecord+""+$TB  //ImpPartyID  -- 10
			$tRecord:=$tRecord+String:C10([Registers:10]RegisterDate:2; System date long:K1:3)+$TB  //ImpBookDate  -- 10
			
			$tRecord:=$tRecord+"O"+$TB  //ImpStatus  -- 1
			$tRecord:=$tRecord+""+$TB  //ImpCTStatusReason  -- 1
			$tRecord:=$tRecord+Substring:C12([Registers:10]CustomerID:5; 6; Length:C16([Registers:10]CustomerID:5))+$TB  //ImpMarketID -- 10
			
			$tRecord:=$tRecord+$CR
			SEND PACKET:C103($hDocRef; $tRecord)
			NEXT RECORD:C51([Invoices:5])
		End for 
		
		CLOSE DOCUMENT:C267($hDocRef)
		myAlert($fileName+" exported.")
		
	End if 
	
Else 
	myAlert("No Journal records to export.")
End if 