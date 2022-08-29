//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 05/29/18, 15:28:42
// ----------------------------------------------------
// Method: exportCentral1AFT_WIres
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
C_TEXT:C284($space; $zero)
C_LONGINT:C283($i; $iCreditCount; $iDebitCount; $iFileNumber; $ii; $iii; $iRecordCount)
C_BOOLEAN:C305($isOutgoingWire)
C_BOOLEAN:C305($bReadOnly)
C_TEXT:C284($tCRDR; $tCRDR)

C_TEXT:C284($tAFT_FileCreationNumName; $tTransType)

C_REAL:C285($rAmt)
C_DATE:C307($dDate)
C_TEXT:C284($tPayeePayorName; $tPayeePayorAcct; $tCrossRef; $tSundryInfo; $tInstitutionID)
C_TIME:C306($hDocRef)



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
	
	If (Test path name:C476($tPath)=Is a folder:K24:2)  //all good
	Else 
		$tPath:=Select folder:C670("Select a location to save the export.")
	End if 
	
	$space:=" "
	$zero:="0"
	
	
	CREATE SET:C116([Wires:8]; "$BaseSet")
	
	If (Records in selection:C76([Wires:8])>0)
		
		myConfirm("Ready to export "+String:C10(Records in selection:C76([Wires:8]))+" records?")
		
		If (OK=1)
			
			START TRANSACTION:C239
			
			$bReadOnly:=Read only state:C362([Wires:8])
			READ WRITE:C146([Wires:8])
			
			READ WRITE:C146([FilePaths:83])
			
			ARRAY TEXT:C222($atCurrency; 0)
			//DISTINCT VALUES([Wires]Currency;$atCurrency)
			
			ORDER BY:C49([Wires:8]; [Wires:8]Currency:15; >; [Wires:8]isOutgoingWire:16; >)
			FIRST RECORD:C50([Wires:8])
			
			For ($i; 1; Records in selection:C76([Wires:8]))
				If ($i=1)
					
					If ([Wires:8]isOutgoingWire:16)  //CR
						$tCRDR:="CR"
					Else 
						$tCRDR:="DR"
					End if 
					
					APPEND TO ARRAY:C911($atCurrency; [Wires:8]Currency:15+"-"+$tCRDR)
					
				Else 
					If ([Wires:8]isOutgoingWire:16)  //CR
						$tCRDR:="CR"
					Else 
						$tCRDR:="DR"
					End if 
					
					If ($atCurrency{Size of array:C274($atCurrency)}=([Wires:8]Currency:15+"-"+$tCRDR))  //no change
					Else 
						APPEND TO ARRAY:C911($atCurrency; [Wires:8]Currency:15+"-"+$tCRDR)
					End if 
				End if 
				
				NEXT RECORD:C51([Wires:8])
			End for 
			
			
			
			For ($i; 1; Size of array:C274($atCurrency))
				
				$fileName:="Wires-"+$atCurrency{$i}+"-"+Substring:C12(String:C10(Current date:C33; ISO date GMT:K1:10); 1; 10)+".txt"
				
				$hDocRef:=Create document:C266($tPath+$fileName)
				
				If (OK=1)  //document was created
					
					C_REAL:C285($rCredit; $rDebit)
					C_TEXT:C284($tOrigShortName; $tOrigLongName; $tOrigAcct; $tOrigInstitutionalID; $tCentral1ID; $tOriginatorID)
					$iRecordCount:=1  // START AT 1 FOR THE A LOGICAL RECORDS
					$rCredit:=0
					$iCreditCount:=0
					$rDebit:=0
					$iDebitCount:=0
					
					USE SET:C118("$BaseSet")
					//QUERY SELECTION([Wires];[Wires]Currency=$atCurrency{$i})
					
					
					Case of 
						: ($atCurrency{$i}="CAD-CR")
							$tOrigShortName:="MONEYWAY"  //keyValue_getValue ("AFT_OriginatorShortName";"OrigShortName")
							$tOrigLongName:="MONEYWAY-CDN CR"  //keyValue_getValue ("AFT_OriginatorLongName";"OriginatorLongName")
							$tOrigAcct:="100009892324"  //keyValue_getValue ("AFT_OriginatorAccount";"999999999999")
							$tOrigInstitutionalID:="080903630"  //keyValue_getValue ("AFT_OriginatorInstitutionalID";"080912310")
							$tCentral1ID:="86900"
							
							$tOriginatorID:="8090003632"  //keyValue_getValue ("AFT_OriginatorID";"8090012300")
							QUERY SELECTION:C341([Wires:8]; [Wires:8]Currency:15="CAD"; *)
							QUERY SELECTION:C341([Wires:8];  & ; [Wires:8]isOutgoingWire:16=True:C214)
							
							$iFileNumber:=1246-1
							
						: ($atCurrency{$i}="CAD-DR")
							$tOrigShortName:="MONEYWAY"  //keyValue_getValue ("AFT_OriginatorShortName";"OrigShortName")
							$tOrigLongName:="MONEYWAY-CDN DR"  //keyValue_getValue ("AFT_OriginatorLongName";"OriginatorLongName")
							$tOrigAcct:="100009892324"  //keyValue_getValue ("AFT_OriginatorAccount";"999999999999")
							$tOrigInstitutionalID:="080903630"  //keyValue_getValue ("AFT_OriginatorInstitutionalID";"080912310")
							$tCentral1ID:="86900"
							
							$tOriginatorID:="8090003631"
							QUERY SELECTION:C341([Wires:8]; [Wires:8]Currency:15="CAD"; *)
							QUERY SELECTION:C341([Wires:8];  & ; [Wires:8]isOutgoingWire:16=False:C215)
							
							$iFileNumber:=780-1
							
						: ($atCurrency{$i}="USD-CR")
							$tOrigShortName:="MONEYWAY"  //keyValue_getValue ("AFT_OriginatorShortName";"OrigShortName")
							$tOrigLongName:="MONEYWAY-USD CR"  //keyValue_getValue ("AFT_OriginatorLongName";"OriginatorLongName")
							$tOrigAcct:="100009894460"  //keyValue_getValue ("AFT_OriginatorAccount";"999999999999")
							$tOrigInstitutionalID:="080903630"  //keyValue_getValue ("AFT_OriginatorInstitutionalID";"080912310")
							$tCentral1ID:="86900"
							
							$tOriginatorID:="8090003633"
							
							QUERY SELECTION:C341([Wires:8]; [Wires:8]Currency:15="USD"; *)
							QUERY SELECTION:C341([Wires:8];  & ; [Wires:8]isOutgoingWire:16=True:C214)
							
							$iFileNumber:=660-1
							
						: ($atCurrency{$i}="USD-DR")
							$tOrigShortName:="MONEYWAY"  //keyValue_getValue ("AFT_OriginatorShortName";"OrigShortName")
							$tOrigLongName:="MONEYWAY-USD DR"  //keyValue_getValue ("AFT_OriginatorLongName";"OriginatorLongName")
							$tOrigAcct:="100009894460"  //keyValue_getValue ("AFT_OriginatorAccount";"999999999999")
							$tOrigInstitutionalID:="080903630"  //keyValue_getValue ("AFT_OriginatorInstitutionalID";"080912310")
							$tCentral1ID:="86900"
							
							$tOriginatorID:="8090003634"
							QUERY SELECTION:C341([Wires:8]; [Wires:8]Currency:15="USD"; *)
							QUERY SELECTION:C341([Wires:8];  & ; [Wires:8]isOutgoingWire:16=False:C215)
							
							$iFileNumber:=712-1
							
						Else 
							$tOriginatorID:="INVALIDID"
					End case 
					
					$tAFT_FileCreationNumName:="AFT_FileCreationNumber-"+$tOriginatorID
					QUERY:C277([FilePaths:83]; [FilePaths:83]FileName:2=$tAFT_FileCreationNumName)
					If (Records in selection:C76([FilePaths:83])=1)  //all good
						$iFileNumber:=Num:C11([FilePaths:83]FolderPath:3)  //Num(keyValue_getValue ("AFT_FileCreationNumber";"1"))
					Else 
						CREATE RECORD:C68([FilePaths:83])
						[FilePaths:83]FilePathID:1:=createSerializedID(->[FilePaths:83]; 1000)
						[FilePaths:83]FileName:2:=$tAFT_FileCreationNumName
						[FilePaths:83]FolderPath:3:=String:C10($iFileNumber)
						SAVE RECORD:C53([FilePaths:83])
						$iFileNumber:=Num:C11([FilePaths:83]FolderPath:3)
					End if 
					
					$iFileNumber:=$iFileNumber+1  //set next nubmer
					
					ORDER BY:C49([Wires:8]; [Wires:8]isOutgoingWire:16; >)
					
					
					//---- A RECORD HEADER -------
					//01 Logical Record Type ID
					$tRecord:="A"
					
					//02 Logical Record Count-Assign sequentially for each logical record, starting at 000000001 for record “A.”
					$tRecord:=$tRecord+stringToFixedWidth(String:C10($iRecordCount); 9; Character code:C91($zero); False:C215)
					
					//03 Originator's ID - The 10-digit identification number unique to each Originator (e.g. 8090012300). Assigned by Central - key/value table
					$tRecord:=$tRecord+stringToFixedWidth($tOriginatorID; 10; Character code:C91($zero); False:C215)
					
					//04 File Creation Number-Assigned sequentially for each file, starting at 0001 and rolling over at 9999. - key/value table
					$tRecord:=$tRecord+stringToFixedWidth(String:C10($iFileNumber; "0000"); 4; Character code:C91($zero); False:C215)
					
					//05 Creation Date- Date file was created. Julian format 0YYDDD: YY = last 2 digits of the year DDD=Julian day number of year.
					$tRecord:=$tRecord+stringToFixedWidth("0"+Substring:C12(String:C10(Year of:C25(Current date:C33)); 3; 2)+String:C10(Current date:C33-Date:C102("01/01/"+String:C10(Year of:C25(Current date:C33)))+1; "000"); 6; Character code:C91($zero); False:C215)
					
					//06 Destination Data Centre-Unique number identifying Central 1. 86900 (for Originators in BC and the Atlantic region) 86920(for Originators in Ontario) - key/value table
					$tRecord:=$tRecord+stringToFixedWidth($tCentral1ID; 5; Character code:C91($zero); False:C215)
					
					//07 Blank - 20 spaces
					$tRecord:=$tRecord+stringToFixedWidth(" "; 20; Character code:C91($space); False:C215)
					
					//08 Currency Code Identifier- “CAD” for Canadian dollar AFT transactions or “USD” for US dollar AFT transactio
					$tRecord:=$tRecord+stringToFixedWidth($atCurrency{$i}; 3; Character code:C91($space); False:C215)
					
					//09 Filler - 1406 spaces
					$tRecord:=$tRecord+stringToFixedWidth(" "; 1406; Character code:C91($space); False:C215)
					$tRecord:=$tRecord+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
					SEND PACKET:C103($hDocRef; $tRecord)
					
					
					
					
					FIRST RECORD:C50([Wires:8])
					//For ($ii;1;Records in selection([Wires]))  //loop through all selected customers and export
					Repeat   //LOOP THROUGH [WIRES]
						
						// ---- LOGICAL RECORD ---------
						$iRecordCount:=$iRecordCount+1
						
						// ---- DETAIL RECORD --------
						
						If (True:C214)  //--- SEGMENT 1 --------
							//01 Logical Record Type ID
							$isOutgoingWire:=[Wires:8]isOutgoingWire:16
							
							If ($isOutgoingWire)  //<--- credit
								$tRecord:="C"  //- Direct credit
							Else 
								$tRecord:="D"  // Direct debit
							End if 
							
							//02 Logical Record Count-Assign sequentially for each logical record, starting at 000000001 for record “A.”
							$tRecord:=$tRecord+stringToFixedWidth(String:C10($iRecordCount); 9; Character code:C91($zero); False:C215)
							
							//03 Origination Control Data- Combination of data elements 03 and 04 in “A” record.
							$tRecord:=$tRecord+stringToFixedWidth($tOriginatorID+String:C10($iFileNumber; "0000"); 14; Character code:C91($zero); False:C215)
						End if 
						
						
						If (True:C214)  // -------- SEGMENT 2 - 6 ------------
							
							For ($iii; 1; 6)
								
								//------ TRANSACTION INFO -------
								$rAmt:=Abs:C99([Wires:8]Amount:14)
								$dDate:=[Wires:8]EstimatedValueDate:18
								
								$tInstitutionID:="0"+stringToFixedWidth(UTIL_removeHighASCII([Wires:8]BeneficiaryInstitutionNo:7); 3; Character code:C91($zero); False:C215)+stringToFixedWidth(UTIL_removeHighASCII([Wires:8]BeneficiaryBranchTransitNo:8); 5; Character code:C91($zero); False:C215)
								$tPayeePayorName:=UTIL_removeHighASCII([Wires:8]BeneficiaryFullName:10)
								$tPayeePayorAcct:=UTIL_removeHighASCII([Wires:8]BeneficiaryAccountNo:9)
								$tCrossRef:=[Wires:8]CXR_WireID:1
								$tSundryInfo:=[Wires:8]CustomerID:2  //[Wires]AML_PurposeOfTransaction
								
								
								If ($isOutgoingWire)  //<--- credit
									$rCredit:=$rCredit+$rAmt
									$iCreditCount:=$iCreditCount+1
									$tTransType:="450"  //keyValue_getValue ("AFT_CPATransactionCodeOutgoing";"460")  //CPA AFT Transaction Codes - 450=misc payment
								Else 
									$rDebit:=$rDebit+$rAmt
									$iDebitCount:=$iDebitCount+1
									$tTransType:="730"  //keyValue_getValue ("AFT_CPATransactionCodeIncoming";"700")  //CPA AFT Transaction Codes - 730=PAD - preapproved debit
								End if 
								
								//NEED TO ADD CPA TRANS CODE TO THE [WIRES]
								
								
								
								//04 Transaction Type-For a list of valid codes, see Introduction to AFT Part, Chapter 9, CPA AFT Transaction Codes. If code is invalid, transaction will reject.
								$tRecord:=$tRecord+stringToFixedWidth($tTransType; 3; Character code:C91($space); False:C215)
								
								//05 Amount-Omit commas and decimal points. For example, enter $4456.00 as “445600.” Right justified.
								$tRecord:=$tRecord+stringToFixedWidth(Replace string:C233(String:C10($rAmt; "#########0.00"); "."; ""); 10; Character code:C91($zero); False:C215)
								
								//06 Due Date or Date Funds to be Available- Date file was created. Julian format 0YYDDD: YY = last 2 digits of the year DDD=Julian day number of year.
								$tRecord:=$tRecord+stringToFixedWidth("0"+Substring:C12(String:C10(Year of:C25($dDate)); 3; 2)+String:C10($dDate-Date:C102("01/01/"+String:C10(Year of:C25($dDate)))+1; "000"); 6; Character code:C91($zero); False:C215)
								
								//???? NEED TO VERIFY THIS IS CORRECT --------
								//07 Institutional ID Number-The financial institution to be debited or credited.
								$tRecord:=$tRecord+stringToFixedWidth($tInstitutionID; 9; Character code:C91($space); False:C215)
								//Format 1 222 33333 where
								//1=0
								//2=Transit institution number(e.g. 809 for BC and 828 for ON)
								//3=Charter/branch number of the financial institution and centre where item will clear.
								
								
								//08 Payee/Payor Account Number-12-Account to be debited or credited. Omit embedded blanks and dashes. Left justified.
								$tRecord:=$tRecord+stringToFixedWidth($tPayeePayorAcct; 12; Character code:C91($space); True:C214)
								
								//09 Item Trace Number - Enter zeros or spaces. For Central 1’s use.
								$tRecord:=$tRecord+stringToFixedWidth("0"; 22; Character code:C91($zero); False:C215)
								
								//10 Stored Transaction Type -  Zero fill.
								$tRecord:=$tRecord+stringToFixedWidth("0"; 3; Character code:C91($zero); False:C215)
								
								//11 Originator's Short Name-15-Short name for the Originator, abbreviated as necessary.
								$tRecord:=$tRecord+stringToFixedWidth($tOrigShortName; 15; Character code:C91($space); True:C214)
								
								//12 Payee/Payor's Name--30-- Name of account to be debited or credited.
								$tRecord:=$tRecord+stringToFixedWidth($tPayeePayorName; 30; Character code:C91($space); True:C214)
								
								//13 Originator's Long Name-30- Long name of the Originator company.
								$tRecord:=$tRecord+stringToFixedWidth($tOrigLongName; 30; Character code:C91($space); True:C214)
								
								//14 Originating Direct Clearer's User ID--10--Same as data element 03 in “A” record.
								$tRecord:=$tRecord+stringToFixedWidth($tOriginatorID; 10; Character code:C91($space); True:C214)
								
								//15 Originator's Cross Reference-19- 19 characters for the internal cross reference for this transaction, if any (for example, employee number, policy number).
								$tRecord:=$tRecord+stringToFixedWidth($tCrossRef; 19; Character code:C91($space); False:C215)
								
								//16 Institutional ID Number for Returns--9--Your credit union branch.
								$tRecord:=$tRecord+stringToFixedWidth($tOrigInstitutionalID; 9; Character code:C91($space); False:C215)
								
								//17 Account Number for Returns-12- Originator’s account number at the branch identified in data element 16. Returns
								$tRecord:=$tRecord+stringToFixedWidth($tOrigAcct; 12; Character code:C91($space); False:C215)
								
								//18 Originator's Sundry Information-15-Enter information to further identify the transaction to the recipient (e.g. enter pay period, insurance policy #).
								$tRecord:=$tRecord+stringToFixedWidth($tSundryInfo; 15; Character code:C91($space); False:C215)
								
								//19 Filler-22-Enter spaces.
								$tRecord:=$tRecord+stringToFixedWidth(" "; 22; Character code:C91($space); False:C215)
								
								//20 Originator Direct Clearer Settlement Code-2-Enter spaces.
								$tRecord:=$tRecord+stringToFixedWidth(" "; 2; Character code:C91($space); False:C215)
								
								//21 Invalid Data Element ID-11- Must contain zeros. If other data present, transaction will reject.
								$tRecord:=$tRecord+stringToFixedWidth("0"; 11; Character code:C91($zero); False:C215)
								
								
								//7/24/18
								[Wires:8]WireNo:48:=Replace string:C233($fileName; ".txt"; "")+"- File No: "+String:C10($iFileNumber; "####")  //strip .txt
								SAVE RECORD:C53([Wires:8])
								
								NEXT RECORD:C51([Wires:8])
								
								If (End selection:C36([Wires:8]))  // ([Wires]isOutgoingWire=$isOutgoingWire)  //no change
									//Else 
									$tRecord:=stringToFixedWidth($tRecord; 1464; Character code:C91($space); True:C214)  //fill with spaces for remaining segments
									$iii:=7  //bail out of loop
								End if 
								
							End for 
							
						End if 
						
						
						$tRecord:=$tRecord+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
						SEND PACKET:C103($hDocRef; $tRecord)
						
					Until (End selection:C36([Wires:8]))
					//End for 
					
					
					//---------- Z RECORD -------------
					$tRecord:="Z"  //01 Logical Record Type ID
					$tRecord:=$tRecord+stringToFixedWidth(String:C10($iRecordCount+1); 9; Character code:C91($zero); False:C215)  //02 Logical Record Count-Assign sequentially for each logical record, starting at 000000001 for record “A.”
					
					//03 Origination Control Data- Combination of data elements 03 and 04 in “A” record.
					$tRecord:=$tRecord+stringToFixedWidth($tOriginatorID+String:C10($iFileNumber; "0000"); 14; Character code:C91($zero); False:C215)
					
					//04 Total Dollar Value of Debit Transactions-Decimal is assumed. For example, enter $4456.00 as “445600.”
					$tRecord:=$tRecord+stringToFixedWidth(Replace string:C233(String:C10($rDebit; "#########0.00"); "."; ""); 14; Character code:C91($zero); False:C215)
					
					//05 Total Number of Debit Transactions- Total for this batch.
					$tRecord:=$tRecord+stringToFixedWidth(String:C10($iDebitCount); 8; Character code:C91($zero); False:C215)
					
					//06 Total Dollar Value of Credit Transactions-Decimal is assumed. For example, enter $4456.00 as “445600.”
					$tRecord:=$tRecord+stringToFixedWidth(Replace string:C233(String:C10($rCredit; "#########0.00"); "."; ""); 14; Character code:C91($zero); False:C215)
					
					//07 Total Number of Credit Transactions- Total for this batch.
					$tRecord:=$tRecord+stringToFixedWidth(String:C10($iCreditCount); 8; Character code:C91($zero); False:C215)
					
					//08 Zero Filler-14-
					$tRecord:=$tRecord+stringToFixedWidth("0"; 14; Character code:C91($zero); False:C215)  //09 Filler - 14 zeros
					
					//09 Zero Filler-8-
					$tRecord:=$tRecord+stringToFixedWidth("0"; 8; Character code:C91($zero); False:C215)  //09 Filler - 8 zeros
					
					//10 Zero Filler-14-
					$tRecord:=$tRecord+stringToFixedWidth("0"; 14; Character code:C91($zero); False:C215)  //09 Filler - 14 zeros
					
					//11 Zero Filler-8-
					$tRecord:=$tRecord+stringToFixedWidth("0"; 8; Character code:C91($zero); False:C215)  //09 Filler - 8 zeros
					
					//12 spaces Filler-1352-
					$tRecord:=$tRecord+stringToFixedWidth(" "; 1352; Character code:C91($space); False:C215)  //09 Filler - 1352 space
					
					$tRecord:=$tRecord+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
					SEND PACKET:C103($hDocRef; $tRecord)
					
					CLOSE DOCUMENT:C267($hDocRef)
					
					If (OK=1)
						//keyValue_setValue ("AFT_FileCreationNumber";String($iFileNumber+1))
						myAlert($fileName+" exported.")
					End if 
					
				End if 
				
				
				READ WRITE:C146([FilePaths:83])
				QUERY:C277([FilePaths:83]; [FilePaths:83]FileName:2=$tAFT_FileCreationNumName)
				
				If (Records in selection:C76([FilePaths:83])=1)
					[FilePaths:83]FolderPath:3:=String:C10($iFileNumber)
					SAVE RECORD:C53([FilePaths:83])
				End if 
				
				
			End for 
			
			If ($bReadOnly)
				UNLOAD RECORD:C212([Wires:8])
				READ ONLY:C145([Wires:8])
			End if 
			
			myConfirm("Was everything exported correctly? If yes we will update originator sequence numbers.")
			If (OK=1)
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
			End if 
			
		End if 
		
	Else 
		myAlert("No Journal records to export.")
	End if 
	
	
	UNLOAD RECORD:C212([FilePaths:83])
	READ ONLY:C145([FilePaths:83])
	REDUCE SELECTION:C351([FilePaths:83]; 0)
	
	
	USE SET:C118("$BaseSet")
	CLEAR SET:C117("$BaseSet")
	
End if 