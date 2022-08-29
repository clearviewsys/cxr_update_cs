//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 10/23/19, 16:38:26
// ----------------------------------------------------
// Method: exportBOMEFT_Wires
// Description
// 
//   For CanAm Currency Exchange
//   Bank Of Montreal EFT Format


//File creation date cannot be more than one(1)week(7 calendar days)prior to the Bank's run date.
//For FTF transmissions, the records must be limited by means of a carriage return (“OD”). 
//Under no circumstances should a line feed character be used to delimit records, either by itself 
//or in conjunction with a carriage return character.

// Batch = BOM's Electronic Funds Transfer (EFT) service is an electronic funds transfer system which 
//enables clients (originators) to submit batches of debit or credit payment transactions to the Bank for processing.

// Parameters
// ----------------------------------------------------




C_TEXT:C284($1; $tPath)
C_DATE:C307($2; $dFrom)
C_DATE:C307($3; $dTo)

C_TEXT:C284($tAddress; $tPath; $tRecord)
C_TEXT:C284($fileName; $tPayeePayorAcct; $tPayeePayorName; $tSundryInfo)
C_TEXT:C284($space; $zero; $tCRDR; $tAFT_FileCreationNumName; $tCrossRef; $tCurrCurrency; $tCurrency)
C_TEXT:C284($tDestination; $tInstitutionID; $tOrigAcct; $tOriginatorID; $tOrigInstitutionalID; $tOrigLongName; $tOrigShortName)
C_TIME:C306($hDocRef)
C_LONGINT:C283($i; $iCreditCount; $iDebitCount; $iFileNumber; $ii; $iii; $iRecordCount)
C_BOOLEAN:C305($isOutgoingWire; $bOK; $bReadOnly)
C_REAL:C285($rAmt; $rCredit; $rDebit)
C_DATE:C307($dDate)


//

If (Count parameters:C259>=1)
	$tPath:=$1
End if 

If ($tPath="")
	$tPath:=Select folder:C670("Select a location to save the export. [NEW]")
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
	$bOK:=True:C214
	
	CREATE SET:C116([Wires:8]; "$BaseSet")
	
	
	$bReadOnly:=Read only state:C362([Wires:8])
	READ WRITE:C146([Wires:8])
	
	If (Records in selection:C76([Wires:8])>0)
		
		If (True:C214)  //lock records
			//<>TODO lock the record selection prior to exporting and updating - omit locked records
			
			ARRAY TEXT:C222($atIDs; 0)
			SELECTION TO ARRAY:C260([Wires:8]CXR_WireID:1; $atIDs)
			
			START TRANSACTION:C239
			
			OK:=1  //init
			SET QUERY AND LOCK:C661(True:C214)
			QUERY WITH ARRAY:C644([Wires:8]CXR_WireID:1; $atIDs)
			
			If (OK=1)  //we have a lock OK to continue
				$bOK:=True:C214
			Else   //there are locked records and we can't continue
				$bOK:=False:C215
				//check locked set and let the user know
				If (Records in set:C195("LockedSet")>0)
					USE SET:C118("LockedSet")
					myAlert("The "+String:C10(Records in set:C195("LockedSet"))+" listed record(s) are locked. Please clear and try again.")
				End if 
				SET QUERY AND LOCK:C661(False:C215)
				CANCEL TRANSACTION:C241
			End if 
			
		End if 
		
		If ($bOK)  //6/22/19 we locked the record above
			myConfirm("Ready to export "+String:C10(Records in selection:C76([Wires:8]))+" records?")
			
			If (OK=1)
				
				
				
				If (In transaction:C397)  //don't start another one
				Else 
					START TRANSACTION:C239
				End if 
				
				ARRAY TEXT:C222($atCurrency; 0)
				//DISTINCT VALUES([Wires]Currency;$atCurrency)
				
				ORDER BY:C49([Wires:8]; [Wires:8]Currency:15; >; [Wires:8]isOutgoingWire:16; >)
				FIRST RECORD:C50([Wires:8])
				
				
				
				
				
				// Each Currency DR and CR have a unique Originator ID and are a separate BATCH
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
					
					$fileName:="Wires-BOM-EFT-"+$atCurrency{$i}+"-"+Substring:C12(String:C10(Current date:C33; ISO date GMT:K1:10); 1; 10)+".txt"
					$hDocRef:=Create document:C266($tPath+$fileName)
					
					If (OK=1)  //document was created
						
						$iRecordCount:=1  // START AT 1 FOR THE A LOGICAL RECORDS
						$rCredit:=0
						$iCreditCount:=0
						$rDebit:=0
						$iDebitCount:=0
						
						$tCurrency:=$atCurrency{$i}
						
						$tOrigShortName:=keyValue_getValue("eft.bom.OriginatorShortName."+$tCurrency; "")
						$tOrigLongName:=keyValue_getValue("eft.bom.OriginatorLongName."+$tCurrency; "")
						$tOrigAcct:=keyValue_getValue("eft.bom.OriginatorAccount."+$tCurrency; "")
						$tOrigInstitutionalID:=keyValue_getValue("eft.bom.OriginatorInstitutionalID."+$tCurrency; "")
						$tOriginatorID:=keyValue_getValue("eft.bom.OriginatorID."+$tCurrency; "")
						$tDestination:=keyValue_getValue("eft.bom.DestinationID."+$tCurrency; "")
						
						//------- GET CURRENT CURRENCY --------
						Case of 
							: ($tCurrency="@-CR")  //[Wires]isOutgoingWire=True
								$tCurrCurrency:=Replace string:C233($tCurrency; "-CR"; "")
								$isOutgoingWire:=True:C214
								
							: ($tCurrency="@-DR")  //[Wires]isOutgoingWire=False
								$tCurrCurrency:=Replace string:C233($tCurrency; "-DR"; "")
								$isOutgoingWire:=False:C215
								
							Else 
								//error
								$tCurrCurrency:=""  //query should find no records
								$isOutgoingWire:=False:C215
						End case 
						
						USE SET:C118("$BaseSet")
						QUERY SELECTION:C341([Wires:8]; [Wires:8]Currency:15=$tCurrCurrency; *)
						QUERY SELECTION:C341([Wires:8];  & ; [Wires:8]isOutgoingWire:16=$isOutgoingWire)
						
						//$tAFT_FileCreationNumName:="eft.bom.FileCreationNumber."+$tOriginatorID
						//$iFileNumber:=Num(keyValue_getValue ("eft.bom.FileCreationNumber."+$tOriginatorID;""))
						$iFileNumber:=Num:C11(keyValue_getValue("eft.bom.FileCreationNumber."+$tCurrency; ""))
						$iFileNumber:=$iFileNumber+1  //set next nubmer
						
						ORDER BY:C49([Wires:8]; [Wires:8]isOutgoingWire:16; >)  //probably not necessary
						
						If (True:C214)  //--- BUILD THE EDI FILE -------
							
							//---- FILE HEADER -- A RECORD HEADER -------
							If (True:C214)
								//01 Logical Record Type ID
								$tRecord:="A"
								
								//02 Originator's ID - The 10-digit identification number unique to each Originator (e.g. 8090012300). Assigned by BOM - key/value table
								$tRecord:=$tRecord+stringToFixedWidth($tOriginatorID; 10; Character code:C91($zero); False:C215)
								
								//03 File Creation Number-Assigned sequentially for each file, starting at 0001 and rolling over at 9999. - key/value table
								$tRecord:=$tRecord+stringToFixedWidth(String:C10($iFileNumber; "0000"); 4; Character code:C91($zero); False:C215)
								
								//04 Creation Date- Date file was created. Julian format 0YYDDD: YY = last 2 digits of the year DDD=Julian day number of year.
								$tRecord:=$tRecord+stringToFixedWidth("0"+Substring:C12(String:C10(Year of:C25(Current date:C33)); 3; 2)+String:C10(Current date:C33-Date:C102("01/01/"+String:C10(Year of:C25(Current date:C33)))+1; "000"); 6; Character code:C91($zero); False:C215)
								
								//05 Destination Data Centre-Unique number identifying Central 1. 86900 (for Originators in BC and the Atlantic region) 86920(for Originators in Ontario) - key/value table
								$tRecord:=$tRecord+stringToFixedWidth($tDestination; 5; Character code:C91($zero); False:C215)
								
								//06 Filler - 54 spaces
								$tRecord:=$tRecord+stringToFixedWidth(" "; 54; Character code:C91($space); False:C215)
								$tRecord:=$tRecord+Char:C90(Carriage return:K15:38)
								SEND PACKET:C103($hDocRef; $tRecord)
							End if 
							
							//------- BATCH HEADER - RECORD TYPE X --------- ALL C or ALL D
							If (True:C214)
								//01 Logical Record Type ID
								$tRecord:="X"
								
								$isOutgoingWire:=[Wires:8]isOutgoingWire:16
								
								If ($isOutgoingWire)  //<--- credit
									//02 - Batch payment type of C or D
									$tRecord:=$tRecord+stringToFixedWidth("C"; 1; Character code:C91($zero); False:C215)
									
									//03 -- Transaction Type Code -For a list of valid codes, see appendix B If code is invalid, transaction will reject.
									$tRecord:=$tRecord+stringToFixedWidth("450"; 3; Character code:C91($space); False:C215)  //450=misc payment
								Else   // Direct debit
									//02 - Batch payment type of C or D
									$tRecord:=$tRecord+stringToFixedWidth("D"; 1; Character code:C91($zero); False:C215)
									
									//03 -- Transaction Type Code -For a list of valid codes, see appendix B If code is invalid, transaction will reject.
									$tRecord:=$tRecord+stringToFixedWidth("730"; 3; Character code:C91($space); False:C215)  //730=PAD - preapproved debit
								End if 
								
								//04 Creation Date- Date file was created. Julian format 0YYDDD: YY = last 2 digits of the year DDD=Julian day number of year.
								$tRecord:=$tRecord+stringToFixedWidth("0"+Substring:C12(String:C10(Year of:C25(Current date:C33)); 3; 2)+String:C10(Current date:C33-Date:C102("01/01/"+String:C10(Year of:C25(Current date:C33)))+1; "000"); 6; Character code:C91($zero); False:C215)
								
								//05 Originator's Short Name-15-Short name for the Originator, abbreviated as necessary.
								$tRecord:=$tRecord+stringToFixedWidth($tOrigShortName; 15; Character code:C91($space); True:C214)
								
								//06 Originator's Long Name-30- Long name of the Originator company.
								$tRecord:=$tRecord+stringToFixedWidth($tOrigLongName; 30; Character code:C91($space); True:C214)
								
								//07 - Institution ID for returns where 0=Constant, BBB=Bank, TTTT=Branch Trnsit Num ie. 0BBBTTTTT
								$tRecord:=$tRecord+stringToFixedWidth($tOrigInstitutionalID; 9; Character code:C91($space); True:C214)  //<>TODO
								
								//08 - Account num for returns - left justified blank filled no embedded blanks or dashes
								$tRecord:=$tRecord+stringToFixedWidth($tOrigAcct; 12; Character code:C91($space); True:C214)  //<>TODO
								
								
								//09 Filler - 3 spaces
								$tRecord:=$tRecord+stringToFixedWidth(" "; 3; Character code:C91($space); False:C215)
								$tRecord:=$tRecord+Char:C90(Carriage return:K15:38)
								SEND PACKET:C103($hDocRef; $tRecord)
							End if 
							
							$iRecordCount:=Records in selection:C76([Wires:8])
							$rCredit:=0
							$rDebit:=0
							
							//------- DETAIL RECORD - C OR D -------
							FIRST RECORD:C50([Wires:8])
							For ($ii; 1; Records in selection:C76([Wires:8]))  //loop through all
								//Repeat   //LOOP THROUGH [WIRES]
								//------ TRANSACTION INFO -------
								$rAmt:=Abs:C99([Wires:8]Amount:14)
								$dDate:=[Wires:8]EstimatedValueDate:18
								//$isOutgoingWire:=[Wires]isOutgoingWire -- see above
								
								//$tInstitutionID:="0"+stringToFixedWidth (UTIL_removeHighASCII ([Wires]BeneficiaryInstitutionNo);3;Character code($zero);False)+stringToFixedWidth (UTIL_removeHighASCII ([Wires]BeneficiaryBranchTransitNo);5;Character code($zero);False)
								$tInstitutionID:="0"+stringToFixedWidth(UTIL_removeHighASCII(String:C10(Num:C11([Wires:8]BeneficiaryInstitutionNo:7))); 3; Character code:C91($zero); False:C215)+stringToFixedWidth(UTIL_removeHighASCII([Wires:8]BeneficiaryBranchTransitNo:8); 5; Character code:C91($zero); False:C215)
								
								$tPayeePayorName:=UTIL_removeHighASCII([Wires:8]BeneficiaryFullName:10)
								$tPayeePayorAcct:=UTIL_removeHighASCII([Wires:8]BeneficiaryAccountNo:9)
								$tCrossRef:=[Wires:8]CXR_WireID:1
								$tSundryInfo:=[Wires:8]CustomerID:2  //[Wires]AML_PurposeOfTransaction
								
								If ($isOutgoingWire)  //<--- credit
									$rCredit:=$rCredit+$rAmt
									$iCreditCount:=$iCreditCount+1
								Else 
									$rDebit:=$rDebit+$rAmt
									$iDebitCount:=$iDebitCount+1
								End if 
								
								// ---- DETAIL RECORD --------
								If (True:C214)
									//01 Logical Record Type ID
									
									If ($isOutgoingWire)  //<--- credit
										$tRecord:="C"  //- Direct credit
									Else 
										$tRecord:="D"  // Direct debit
									End if 
									
									//02 - Amount - 2 decimal places understood
									$tRecord:=$tRecord+stringToFixedWidth(Replace string:C233(String:C10($rAmt; "#########0.00"); "."; ""); 10; Character code:C91($zero); False:C215)
									
									//03 - Payee/Payor Instition ID - 0=Constant, BBB=Bank, TTTTT=Brand Transit Num
									$tRecord:=$tRecord+stringToFixedWidth($tInstitutionID; 9; Character code:C91($space); False:C215)
									
									//04 - Payee/Payor Account Num - left justified, blank filled, no embedded blanks or dashes 
									$tRecord:=$tRecord+stringToFixedWidth($tPayeePayorAcct; 12; Character code:C91($space); True:C214)
									
									//05 - Payee/Payor Name
									$tRecord:=$tRecord+stringToFixedWidth($tPayeePayorName; 29; Character code:C91($space); True:C214)
									
									//06 - Cross ref num - Custom ID to reference item ie. employee sin number
									$tRecord:=$tRecord+stringToFixedWidth($tCrossRef; 15; Character code:C91($space); False:C215)  //really 19 but limied to 15 for D records
									
									$tRecord:=$tRecord+stringToFixedWidth(" "; 4; Character code:C91($space); False:C215)  //treat C and D the same
									$tRecord:=$tRecord+Char:C90(Carriage return:K15:38)
									SEND PACKET:C103($hDocRef; $tRecord)
								End if 
								
								If (False:C215)
									[Wires:8]WireNo:48:=Replace string:C233($fileName; ".txt"; "")+"- File No: "+String:C10($iFileNumber; "####")  //strip .txt
									SAVE RECORD:C53([Wires:8])
									// customer authorization flag for PAD agreement ... can we add to [customers] table
									//vincent asking about a "sent" flag
									//only BMO custoemrs???
									//ck and release columns? should they be check
									// how to automate the $0.01 test - it would need to be via an invoice - or other verification process
									// should we filter out [wires] with a WireNo already
								End if 
								
								
								NEXT RECORD:C51([Wires:8])
							End for 
							
							// ------- BATCH CONTROL - RECORD TYPE Y ---------
							If (True:C214)
								$tRecord:="Y"  //01 Logical Record Type ID
								
								//02 - Batch payemtn type -- C or D
								If ($isOutgoingWire)  //<--- credit
									$tRecord:=$tRecord+"C"  //- Direct credit
									
									//03 - Batch Record Count
									$tRecord:=$tRecord+stringToFixedWidth(String:C10($iCreditCount); 8; Character code:C91($zero); False:C215)
									
									//04 - Batch Amount - 2 decimal places understood
									$tRecord:=$tRecord+stringToFixedWidth(Replace string:C233(String:C10($rCredit; "#########0.00"); "."; ""); 14; Character code:C91($zero); False:C215)
								Else 
									$tRecord:=$tRecord+"D"  // Direct debit
									
									//03 - Batch Record Count
									$tRecord:=$tRecord+stringToFixedWidth(String:C10($iDebitCount); 8; Character code:C91($zero); False:C215)
									
									//04 - Batch Amount - 2 decimal places understood
									$tRecord:=$tRecord+stringToFixedWidth(Replace string:C233(String:C10($rDebit; "#########0.00"); "."; ""); 14; Character code:C91($zero); False:C215)
								End if 
								
								//05 Zero Filler-56-
								$tRecord:=$tRecord+stringToFixedWidth("0"; 56; Character code:C91($zero); False:C215)  //09 Filler - 8 zeros
								
								$tRecord:=$tRecord+Char:C90(Carriage return:K15:38)
								SEND PACKET:C103($hDocRef; $tRecord)
							End if 
							
							
							//---------- FILE CONTROL RECORD - TYPE Z RECORD -------------
							If (True:C214)  //
								$tRecord:="Z"  //01 Logical Record Type ID
								
								//02 Total Dollar Value of Debit Transactions-Decimal is assumed. For example, enter $4456.00 as “445600.”
								$tRecord:=$tRecord+stringToFixedWidth(Replace string:C233(String:C10($rDebit; "#########0.00"); "."; ""); 14; Character code:C91($zero); False:C215)
								
								//03 Total Number of Debit Transactions- Total for this batch.
								$tRecord:=$tRecord+stringToFixedWidth(String:C10($iDebitCount); 5; Character code:C91($zero); False:C215)
								
								//04 Total Dollar Value of Credit Transactions-Decimal is assumed. For example, enter $4456.00 as “445600.”
								$tRecord:=$tRecord+stringToFixedWidth(Replace string:C233(String:C10($rCredit; "#########0.00"); "."; ""); 14; Character code:C91($zero); False:C215)
								
								//05 Total Number of Credit Transactions- Total for this batch.
								$tRecord:=$tRecord+stringToFixedWidth(String:C10($iCreditCount); 5; Character code:C91($zero); False:C215)
								
								//06 spaces Filler-41-
								$tRecord:=$tRecord+stringToFixedWidth(" "; 41; Character code:C91($space); False:C215)  //09 Filler - 1352 space
								
								$tRecord:=$tRecord+Char:C90(Carriage return:K15:38)
								SEND PACKET:C103($hDocRef; $tRecord)
							End if 
							
							
							If (OK=1)
								myAlert($fileName+" exported.")
							End if 
							
						End if 
						
						If (True:C214)
							keyValue_setValue($tAFT_FileCreationNumName; String:C10($iFileNumber))  //update
						End if 
						
						CLOSE DOCUMENT:C267($hDocRef)
						
					End if 
					
				End for 
				
				
				
				myConfirm("Was everything exported correctly? If yes we will update originator sequence numbers.")
				If (OK=1)
					If (In transaction:C397)
						SET QUERY AND LOCK:C661(False:C215)
						VALIDATE TRANSACTION:C240
					End if 
					
					MOVE DOCUMENT:C540($tPath+$fileName; $tPath+Replace string:C233($fileName; ".txt"; "")+"-"+String:C10($iFileNumber; "00000")+".txt")
					
				Else 
					If (In transaction:C397)
						CANCEL TRANSACTION:C241
					End if 
				End if 
				
				
			Else   //user cancelled the export
				If (In transaction:C397)
					CANCEL TRANSACTION:C241
				End if 
			End if 
			
		End if 
	Else 
		myAlert("No Journal records to export.")
	End if 
	
	//SET QUERY AND LOCK(False)
	If ($bReadOnly)
		UNLOAD RECORD:C212([Wires:8])
		READ ONLY:C145([Wires:8])
	End if 
	
	
	If (Records in set:C195("LockedSet")>0)  //don't change the selection - let user review
	Else 
		USE SET:C118("$BaseSet")
	End if 
	CLEAR SET:C117("$BaseSet")
	
End if 