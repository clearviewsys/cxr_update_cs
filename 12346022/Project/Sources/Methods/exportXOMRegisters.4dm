//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 08/03/16, 14:40:46
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: exportXOMRegisters
// Description
// 
//
// Parameters
// ----------------------------------------------------





C_TEXT:C284($1; $tPath)
C_DATE:C307($2; $dFrom)
C_DATE:C307($3; $dTo)

C_TEXT:C284($tAddress; $tPath; $tRecord)
C_TEXT:C284($fileName)
C_TIME:C306($hDocRef)
C_LONGINT:C283($i)

$fileName:="Registers--"+Substring:C12(String:C10(Current date:C33; ISO date GMT:K1:10); 1; 10)+".csv"

//

If (Count parameters:C259>=1)
	$tPath:=$1
End if 

If ($tPath="")
	$tPath:=Select folder:C670("Select a location to save the export.")
Else 
	OK:=1
End if 


If (OK=1)  //continue processing
	
	If (Count parameters:C259>=2)
		$dFrom:=$2
	Else 
		$dFrom:=Current date:C33
	End if 
	
	If (Count parameters:C259>=3)
		$dTo:=$3
	Else 
		$dTo:=Current date:C33
	End if 
	
	If (Test path name:C476($tPath)=Is a folder:K24:2)
		$tPath:=$tPath+$fileName
	Else 
		$tPath:=$fileName
	End if 
	
	
	If (Count parameters:C259>1)  //do the query based on dates passed
		QUERY:C277([Registers:10]; [Registers:10]Currency:19#<>BASECURRENCY; *)
		QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2>=$dFrom; *)
		QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=$dTo)
	Else 
		QUERY SELECTION:C341([Registers:10]; [Registers:10]Currency:19#<>BASECURRENCY)
	End if 
	
	
	
	
	If (Records in selection:C76([Registers:10])>0)
		
		$hDocRef:=Create document:C266($tPath)
		
		If (OK=1)  //document was created
			
			$tRecord:="Customer Name,Trans Date,Receipt Number,Currency Given,Amt Given,Currency Received,Amt Received,"
			$tRecord:=$tRecord+"Rate of Exchange,Trans Fee,Customer Address,Customer City,Customer State,Customer Zip,Customer Tax ID,ID Number,"
			$tRecord:=$tRecord+"Country of Issuance,Customer DOB,Customer Photo ID Number,Customer ID Type,Customer Phote ID State,Customer Photo ID State/Country,"
			$tRecord:=$tRecord+"Name of person on whose behalf,Address of person on whose behalf,FEIN of person on whose behalf,Location of office where trans conducted,"
			$tRecord:=$tRecord+"Identifier of employee effecting trans,comments,Order number,Address currency delivered,City currency delivered,State currency deliveried,"
			$tRecord:=$tRecord+"Zip currency delivered,Date funds received,Date funds verified,Date cash shipped,Date of delivery,Method of payment,Comments"
			$tRecord:=$tRecord+Char:C90(Carriage return:K15:38)
			SEND PACKET:C103($hDocRef; $tRecord)
			
			
			FIRST RECORD:C50([Registers:10])
			For ($i; 1; Records in selection:C76([Registers:10]))  //loop through all selected customers and export
				
				RELATE ONE:C42([Registers:10]CustomerID:5)
				If (Records in selection:C76([Customers:3])=1)
					
					QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[Registers:10]InvoiceNumber:10)  //get related invoice
					
					
					$tRecord:=stringToCSV([Customers:3]FullName:40)  //customer name
					$tRecord:=$tRecord+stringToCSV(DATE_formatAsString([Registers:10]RegisterDate:2))  //trans date
					//$tRecord:=$tRecord+stringToCSV (String([Registers]InvoiceNumber))  //invoice number -- NOT IN SAMPLE FILE
					$tRecord:=$tRecord+stringToCSV(String:C10([Registers:10]InvoiceNumber:10))  //trans reciept number
					
					
					Case of 
						: ([Registers:10]Debit:8>0)  //buy === we get foriegn curr (goods) and paying out USD
							$tRecord:=$tRecord+stringToCSV((<>BASECURRENCY))  //currency given 
							$tRecord:=$tRecord+stringToCSV(String:C10([Registers:10]DebitLocal:23))  //amount given
							$tRecord:=$tRecord+stringToCSV(([Registers:10]Currency:19))  //currency received 
							$tRecord:=$tRecord+stringToCSV(String:C10([Registers:10]Debit:8))  //amount received
							
						: ([Registers:10]Credit:7>0)  // sell  === we give foriegn curr (goods) and recieve USD
							$tRecord:=$tRecord+stringToCSV(([Registers:10]Currency:19))  //currency given 
							$tRecord:=$tRecord+stringToCSV(String:C10([Registers:10]Credit:7))  //amount given
							$tRecord:=$tRecord+stringToCSV((<>BASECURRENCY))  //currency received 
							$tRecord:=$tRecord+stringToCSV(String:C10([Registers:10]CreditLocal:24))  //amount received
							
						Else 
							//error
					End case 
					
					$tRecord:=$tRecord+stringToCSV(String:C10([Registers:10]OurRate:25))  //rate of exchange
					$tRecord:=$tRecord+stringToCSV(String:C10([Registers:10]totalFees:30))  //trans fee
					
					
					$tRecord:=$tRecord+stringToCSV([Customers:3]Address:7)  //cust address
					$tRecord:=$tRecord+stringToCSV([Customers:3]City:8)  //cust city
					$tRecord:=$tRecord+stringToCSV([Customers:3]Province:9)  //cust state/province
					$tRecord:=$tRecord+stringToCSV([Customers:3]PostalCode:10)  //cust zip
					$tRecord:=$tRecord+stringToCSV([Customers:3]SIN_No:14)  //cust ssn or tax id
					$tRecord:=$tRecord+stringToCSV([Customers:3]PictureID_Number:69)  //passport number or id number
					$tRecord:=$tRecord+stringToCSV([Customers:3]PictureID_IssueState:72)  //country of issuance
					$tRecord:=$tRecord+stringToCSV(DATE_formatAsString([Customers:3]DOB:5))  //customer dob
					$tRecord:=$tRecord+stringToCSV([Customers:3]PictureID_Number:69)  //cust photo id number
					$tRecord:=$tRecord+stringToCSV([Customers:3]PictureID_Type:70)  //cust id type
					$tRecord:=$tRecord+stringToCSV([Customers:3]PictureID_IssueState:72)  //cust photo id state
					$tRecord:=$tRecord+stringToCSV([Customers:3]PictureID_IssueCountry:73)  //cust photo id state/country of issuance
					
					
					$tRecord:=$tRecord+stringToCSV([Invoices:5]ThirdPartyName:29)  //name of person on whose behalf trans conducted
					$tRecord:=$tRecord+stringToCSV([Invoices:5]ThirdPartyAddress:90)  //address of person on whose behalf trans conducted
					$tRecord:=$tRecord+stringToCSV("N/A")  //fein or ssn of person on whose behalf trns conducted
					$tRecord:=$tRecord+stringToCSV([Invoices:5]BranchID:53)  //location of office where trans is conducted
					$tRecord:=$tRecord+stringToCSV([Registers:10]CreatedByUserID:16)  //identifier of employee effecting trans
					$tRecord:=$tRecord+stringToCSV([Invoices:5]comments:43)  //comments
					$tRecord:=$tRecord+stringToCSV(String:C10([Registers:10]InvoiceNumber:10))  //order number
					
					//always their branch address??? -- yes per Blake
					QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[Registers:10]BranchID:39)
					
					$tRecord:=$tRecord+stringToCSV([Branches:70]Address:3)  //address currency was delievered
					$tRecord:=$tRecord+stringToCSV([Branches:70]City:4)  //city currency was delivered
					$tRecord:=$tRecord+stringToCSV([Branches:70]Province:10)  //state currencey was delivered
					$tRecord:=$tRecord+stringToCSV([Branches:70]PostalCode:11)  //zip currency was delivered
					
					//need to confirm with blake/tiran
					$tRecord:=$tRecord+stringToCSV(DATE_formatAsString([Registers:10]RegisterDate:2))  //date funds received
					$tRecord:=$tRecord+stringToCSV(DATE_formatAsString([Registers:10]RegisterDate:2))  //date funds verified
					$tRecord:=$tRecord+stringToCSV(DATE_formatAsString([Registers:10]RegisterDate:2))  //date cash/product shipped
					$tRecord:=$tRecord+stringToCSV(DATE_formatAsString([Registers:10]RegisterDate:2))  //date of delivery
					
					//QUERY([Accounts];[Accounts]AccountID=[Registers]AccountID)
					//If ([Accounts]isCashAccount)
					//$tRecord:=$tRecord+stringToCSV ("Cash";True)  //method of payment
					//Else 
					//$tRecord:=$tRecord+stringToCSV ([Accounts]AccountCode;True)  //method of payment
					//End if 
					
					$tRecord:=$tRecord+stringToCSV([Registers:10]AccountID:6)  //method of payment
					$tRecord:=$tRecord+stringToCSV([Registers:10]Comments:9; True:C214)  //comments of payment
					
					
					$tRecord:=$tRecord+Char:C90(Carriage return:K15:38)
					SEND PACKET:C103($hDocRef; $tRecord)
					
					
				Else   //didn't find customer
					//log error here
				End if 
				
				NEXT RECORD:C51([Registers:10])
				
			End for 
			
			CLOSE DOCUMENT:C267($hDocRef)
			myAlert($fileName+" exported.")
			
		End if 
		
	Else 
		myAlert("No Journal records to export.")
	End if 
	
End if 