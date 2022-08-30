//%attributes = {}
//C_TEXT($tRequestType;$1)


C_LONGINT:C283($i; $iBlobCurrSize; $iBlobExpandSize; $iCompressed; $iCount; $iError; $iTable; $iField; $iType)
C_TEXT:C284($tName; $tFilename; $tRequestType; $tMime; $tSearchValue; $tSecurityCode; $tUpdate)
C_TEXT:C284($currOnErr; $requestBag; $responseBag; $tRequestedSiteID; $sFieldName)
C_POINTER:C301($ptrField; $ptrTable)
C_BOOLEAN:C305($bIsAuthorized; $bReadOnly; $useJSON)
C_BLOB:C604($xRequest; $xResponse)

//Case of 
//: (Count parameters=1)
//$endpoint:=$1
//Else 
//assertInvalidNumberOfParams (Current method name;Count parameters)
//End case 

$currOnErr:=Method called on error:C704
ON ERR CALL:C155("onErrCallIgnore")

If (WEB Get body part count:C1211=1)  //blob has been posted
	WEB GET BODY PART:C1212(1; $xRequest; $tName; $tMime; $tFilename)
	
	BLOB PROPERTIES:C536($xRequest; $iCompressed; $iBlobExpandSize; $iBlobCurrSize)
	If ($iCompressed=Is not compressed:K22:11)  //not compress
	Else 
		EXPAND BLOB:C535($xRequest)
	End if 
	
	
	$requestBag:=XB_BlobToBag($xRequest)
	$tRequestType:=XB_GetText($requestBag; "Request_Type")
	$useJSON:=XB_GetBoolean($requestBag; "Request_JSON")
	
	$iTable:=XB_GetLong($requestBag; "Request_Table")
	$iField:=XB_GetLong($requestBag; "Request_Field")
	$tSearchValue:=XB_GetText($requestBag; "Request_SearchValue")  //
	$tSecurityCode:=XB_GetText($requestBag; "Request_SecurityCode")  //
	$tRequestedSiteID:=XB_GetText($requestBag; "Request_Site")
	$tUpdate:=XB_GetText($requestBag; "Request_Update")
	
	$ptrTable:=Table:C252($iTable)
	$bReadOnly:=Read only state:C362($ptrTable->)
	
	$responseBag:=XB_New  //init a return object
	XB_PutBoolean($responseBag; "success"; False:C215)
	XB_PutText($responseBag; "statusText"; "Generic Failure")
	
	Case of 
		: ($tRequestType="STATUS")
			
			$ptrField:=Field:C253($iTable; $iField)
			READ WRITE:C146($ptrTable->)
			
			
			//ADD ANY SECURITY CHECKS HERE FOR SPECIFIC TABLES
			Case of 
				: ($ptrTable=(->[eWires:13]))
					
					QUERY:C277([eWires:13]; [eWires:13]eWireID:1=$tSearchValue)
					
					Case of 
						: (Records in selection:C76([eWires:13])#1)
							$bIsAuthorized:=False:C215
						: ([eWires:13]doTransferToBank:33)
							$bIsAuthorized:=True:C214
						: ([eWires:13]toMOP_Code:114=getKeyValue("ewire.tomop.mobilewallet"; "N-M"))  //mobile wallet
							$bIsAuthorized:=True:C214
						: ([eWires:13]toMOP_Code:114=getKeyValue("ewire.tomop.bank"; "N"))  //bank
							$bIsAuthorized:=True:C214
						: ([eWires:13]securityChallengeCode:75=$tSecurityCode)
							$bIsAuthorized:=True:C214
						Else 
							$bIsAuthorized:=False:C215
					End case 
					
					Case of 
						: (Records in selection:C76([eWires:13])=1) & ($bIsAuthorized=False:C215)  // ([eWires]securityChallengeCode#$tSecurityCode)  //found and security rejected
							XB_PutText($responseBag; "statusText"; "FAIL-SECURITY")
							XB_PutText($responseBag; "requestStatus"; "FAIL-SECURITY")
							
						: (Records in selection:C76([eWires:13])=1) & ($bIsAuthorized)  // ([eWires]securityChallengeCode=$tSecurityCode)  //found and security validated
							XB_PutText($responseBag; "statusText"; "SUCCESS")
							XB_PutText($responseBag; "requestStatus"; "SUCCESS")  //for compatibility
							XB_PutBoolean($responseBag; "success"; True:C214)
							
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]SendDate:2); ->[eWires:13]SendDate:2)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]SenderName:7); ->[eWires:13]SenderName:7)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]BeneficiaryFullName:5); ->[eWires:13]BeneficiaryFullName:5)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]BeneficiaryCellPhone:61); ->[eWires:13]BeneficiaryCellPhone:61)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]BeneficiaryAddress:59); ->[eWires:13]BeneficiaryAddress:59)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]BeneficiaryCity:60); ->[eWires:13]BeneficiaryCity:60)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]PurposeOfTransaction:65); ->[eWires:13]PurposeOfTransaction:65)
							
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]FromAmount:13); ->[eWires:13]FromAmount:13)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]ToAmount:14); ->[eWires:13]ToAmount:14)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]Currency:12); ->[eWires:13]Currency:12)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]fromCountry:9); ->[eWires:13]fromCountry:9)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]toCountry:10); ->[eWires:13]toCountry:10)
							
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]fromCountryCode:111); ->[eWires:13]fromCountryCode:111)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]toCountryCode:112); ->[eWires:13]toCountryCode:112)
							
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]isSettled:23); ->[eWires:13]isSettled:23)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]comments_Visible:48); ->[eWires:13]comments_Visible:48)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]isLocked:79); ->[eWires:13]isLocked:79)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]lockedSite:83); ->[eWires:13]lockedSite:83)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]lockedDate:80); ->[eWires:13]lockedDate:80)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]lockedTime:81); ->[eWires:13]lockedTime:81)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]BeneficiaryAmendedName:119); ->[eWires:13]BeneficiaryAmendedName:119)
							
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]toMOP_Code:114); ->[eWires:13]toMOP_Code:114)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]BeneficiaryBank:124); ->[eWires:13]BeneficiaryBank:124)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]BeneficiaryBankName:76); ->[eWires:13]BeneficiaryBankName:76)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]BeneficiaryBankAccountNo:66); ->[eWires:13]BeneficiaryBankAccountNo:66)
							XB_PutVariable($responseBag; Field name:C257(->[eWires:13]Status:22); ->[eWires:13]Status:22)
							
							
							If ([eWires:13]invoiceID_origin:86#"")  //`only if invoiced on both sides
								XB_PutVariable($responseBag; Field name:C257(->[eWires:13]InvoiceNumber:29); ->[eWires:13]InvoiceNumber:29)
							End if 
							
						: (Records in selection:C76([eWires:13])>1)
							XB_PutText($responseBag; "statusText"; "FAIL-MULTIPLE RECORDS FOUND")
							XB_PutText($responseBag; "requestStatus"; "FAIL-MULTIPLE RECORDS FOUND")
						Else   //not not found
							XB_PutText($responseBag; "statusText"; "FAIL-NOT FOUND")
							
							XB_PutText($responseBag; "requestStatus"; "FAIL-NOT FOUND")
					End case 
					
				Else   //ALL OTHER TABLES
					
					$iType:=Type:C295($ptrField->)
					
					If ($iType=Is longint:K8:6) | ($iType=Is real:K8:4) | ($iType=Is integer:K8:5)  //add other case statements to handle other types
						QUERY:C277($ptrTable->; $ptrField->=Num:C11($tSearchValue))
					Else 
						QUERY:C277($ptrTable->; $ptrField->=$tSearchValue)
					End if 
					
					Case of 
						: (Records in selection:C76($ptrTable->)=1)
							XB_PutText($responseBag; "statusText"; "SUCCESS")
							XB_PutText($responseBag; "requestStatus"; "SUCCESS")  //for compatibility
							XB_PutBoolean($responseBag; "success"; True:C214)
							
							For ($i; 1; 10)
								If (Is field number valid:C1000(Table:C252($ptrTable); $i))
									$ptrField:=Field:C253(Table:C252($ptrTable); $i)
									$sFieldName:=Field name:C257($ptrField)
									
									XB_PutVariable($responseBag; $sFieldName; $ptrField)
								End if 
								
							End for 
							
							
						: (Records in selection:C76($ptrTable->)>1)
							XB_PutText($responseBag; "statusText"; "FAIL-MULTIPLE RECORDS FOUND")
						Else 
							XB_PutText($responseBag; "statusText"; "FAIL-NOT FOUND")
					End case 
					
			End case 
			
			If (XB_GetText($responseBag; "statusText")="SUCCESS@")
			Else 
				UTIL_Log("EWIRE"; "STATUS FAILURE:[EWire]ID: "+$tSearchValue+" - "+XB_GetText($responseBag; "statusText")+" - by: "+WebClientIP+" on "+String:C10(Current date:C33))
			End if 
			
			
		: ($tRequestType="SAVE")
			
			$ptrField:=Field:C253($iTable; $iField)
			
			//add any security checks here for specific tables
			Case of 
				: ($ptrTable=(->[eWires:13]))
					$bIsAuthorized:=True:C214
				Else 
					$bIsAuthorized:=True:C214
			End case 
			
			
			If ($bIsAuthorized)
				
				UNLOAD RECORD:C212($ptrTable->)
				READ WRITE:C146($ptrTable->)
				
				$iType:=Type:C295($ptrField->)
				
				If ($iType=Is longint:K8:6) | ($iType=Is real:K8:4) | ($iType=Is integer:K8:5)  //add other case statements to handle other types
					QUERY:C277($ptrTable->; $ptrField->=Num:C11($tSearchValue))
				Else 
					QUERY:C277($ptrTable->; $ptrField->=$tSearchValue)
				End if 
				
				Case of 
					: (Records in selection:C76($ptrTable->)=0)
						
					: (Records in selection:C76($ptrTable->)=1)
						DELETE RECORD:C58($ptrTable->)
					Else   //found multiple records might be a problem???
						$iError:=-2
				End case 
				
				If ($iError=0)
					CREATE RECORD:C68($ptrTable->)
					XB_GetRecord($requestBag; "Record"; $ptrTable)
					SAVE RECORD:C53($ptrTable->)
				End if 
				
			Else 
				$iError:=-1
			End if 
			
			
		: ($tRequestType="UPDATE")
			$ptrField:=Field:C253($iTable; $iField)
			
			//add any security checks here for specific tables
			Case of 
				: ($ptrTable=(->[eWires:13]))
					$bIsAuthorized:=True:C214
				Else 
					$bIsAuthorized:=True:C214
			End case 
			
			
			If ($bIsAuthorized)
				UNLOAD RECORD:C212($ptrTable->)
				READ WRITE:C146($ptrTable->)
				
				$iType:=Type:C295($ptrField->)
				
				If ($iType=Is longint:K8:6) | ($iType=Is real:K8:4) | ($iType=Is integer:K8:5)  //add other case statements to handle other types
					QUERY:C277($ptrTable->; $ptrField->=Num:C11($tSearchValue))
				Else 
					QUERY:C277($ptrTable->; $ptrField->=$tSearchValue)
				End if 
				
				Case of 
					: (Records in selection:C76($ptrTable->)=0)
						$iError:=-3
					: (Records in selection:C76($ptrTable->)=1)
						JSON TO SELECTION:C1235($ptrTable->; $tUpdate)
						If (Records in set:C195("LockedSet")>0)
							$iError:=-4
						End if 
						
					Else   //found multiple records might be a problem???
						$iError:=-2
				End case 
				
			Else 
				$iError:=-1
			End if 
			
			If ($iError=0)
				XB_PutText($responseBag; "statusText"; "SUCCESS")
				XB_PutText($responseBag; "requestStatus"; "SUCCESS")  //for compatibility
				XB_PutBoolean($responseBag; "success"; True:C214)
			Else 
				XB_PutText($responseBag; "statusText"; "FAILURE: Error "+String:C10($iError))
				XB_PutText($responseBag; "requestStatus"; "FAILURE: Error "+String:C10($iError))  //for compatibility
				XB_PutBoolean($responseBag; "success"; False:C215)
			End if 
			
			
		: ($tRequestType="LOAD")
			
			$ptrField:=Field:C253($iTable; $iField)
			READ WRITE:C146($ptrTable->)
			
			//ADD ANY SECURITY CHECKS HERE FOR SPECIFIC TABLES
			
			Case of 
				: ($ptrTable=(->[eWires:13]))
					
					QUERY:C277([eWires:13]; [eWires:13]eWireID:1=$tSearchValue)
					
					$bIsAuthorized:=False:C215
					
					Case of 
						: (Records in selection:C76([eWires:13])=0)
							XB_PutText($responseBag; "statusText"; "FAIL-RECORD NOT FOUND")
							
						: (Records in selection:C76([eWires:13])>1)
							XB_PutText($responseBag; "statusText"; "FAIL-MULTIPLE RECORDS FOUND")
							
						: ([eWires:13]isSettled:23)  // eWire is settled - PAID already
							XB_PutText($responseBag; "statusText"; "FAIL-EWIRE IS SETTLED")
							XB_PutText($responseBag; "requestStatus"; "FAIL-EWIRE IS SETTLED")  //for compatibility
							
						: ([eWires:13]isCancelled:34)  // eWire is Cancelled
							XB_PutText($responseBag; "statusText"; "FAIL-EWIRE IS CANCELLED")
							XB_PutText($responseBag; "requestStatus"; "FAIL-EWIRE IS CANCELLED")  //for compatibility
							
						: ([eWires:13]isLocked:79) & ([eWires:13]lockedSite:83=$tRequestedSiteID) & ([eWires:13]lockedDate:80=Current date:C33)
							$bIsAuthorized:=True:C214
							
						: ([eWires:13]isLocked:79)  //ewire has already been retrieved
							//5/22/21 added #$tRequestedSiteID and #current date - allows a remote to retry on the same day
							XB_PutText($responseBag; "statusText"; "FAIL-EWIRE IS LOCKED by "+[eWires:13]lockedSite:83+" "+String:C10([eWires:13]lockedDate:80)+" "+String:C10([eWires:13]lockedTime:81))
							XB_PutText($responseBag; "requestStatus"; "FAIL-EWIRE IS LOCKED by "+[eWires:13]lockedSite:83+" "+String:C10([eWires:13]lockedDate:80)+" "+String:C10([eWires:13]lockedTime:81))  //for compatibility"
							
						Else   //unexecpted
							//XB_PutText($responseBag; "statusText"; "FAIL-UNEXPECTED ERROR")
							$bIsAuthorized:=True:C214
					End case 
					
					
					If ($bIsAuthorized)
						If (isRecordLoaded(->[eWires:13]))
							
							Case of 
								: ([eWires:13]doTransferToBank:33)
									$bIsAuthorized:=True:C214
								: ([eWires:13]toMOP_Code:114=getKeyValue("ewire.tomop.mobilewallet"; "N-M"))  //mobile wallet
									$bIsAuthorized:=True:C214
								: ([eWires:13]securityChallengeCode:75=$tSecurityCode)
									$bIsAuthorized:=True:C214
								Else 
									$bIsAuthorized:=False:C215
							End case 
							
							
							If ($bIsAuthorized)  //  //is Authorized so send record
								XB_PutText($responseBag; "statusText"; "SUCCESS")
								XB_PutText($responseBag; "requestStatus"; "SUCCESS")  //for compatibility
								XB_PutBoolean($responseBag; "success"; True:C214)
								
								If ([eWires:13]isLocked:79)  //this is a retry
									[eWires:13]comments_Private:47:="Fetch retry - "+String:C10(Current date:C33)+"at "+String:C10(Current time:C178)+"||"+[eWires:13]comments_Private:47
								End if 
								
								[eWires:13]isLocked:79:=True:C214
								[eWires:13]lockedDate:80:=Current date:C33
								[eWires:13]lockedTime:81:=Current time:C178
								[eWires:13]lockedIP:82:=WebClientIP
								[eWires:13]lockedSite:83:=$tRequestedSiteID
								SAVE RECORD:C53([eWires:13])
								
								XB_PutRecord($responseBag; "record"; $ptrTable)
								
							Else 
								XB_PutText($responseBag; "statusText"; "FAIL-SECURITY")
								XB_PutText($responseBag; "requestStatus"; "FAIL-SECURITY")  //for compatibility
							End if 
						Else 
							XB_PutText($responseBag; "statusText"; "FAIL-RECORD LOCKED BY ANOTHER 4D PROCESS")
							XB_PutText($responseBag; "requestStatus"; "FAIL-RECORD LOCKED BY ANOTHER 4D PROCESS")  //for compatibility
						End if 
						
					End if 
					
					If (XB_GetText($responseBag; "statusText")="SUCCESS@")
						UTIL_Log("EWIRE"; "LOAD SUCCESS:[EWire]ID: "+$tSearchValue+" - "+XB_GetText($responseBag; "statusText")+" - by: "+WebClientIP+" on "+String:C10(Current date:C33))
					Else 
						UTIL_Log("EWIRE"; "LOAD FAILURE:[EWire]ID: "+$tSearchValue+" - "+XB_GetText($responseBag; "statusText")+" - by: "+WebClientIP+" on "+String:C10(Current date:C33))
					End if 
					
				Else   //ALL OTHER TABLES
					
					$iType:=Type:C295($ptrField->)
					
					If ($iType=Is longint:K8:6) | ($iType=Is real:K8:4) | ($iType=Is integer:K8:5)  //add other case statements to handle other types
						QUERY:C277($ptrTable->; $ptrField->=Num:C11($tSearchValue))
					Else 
						QUERY:C277($ptrTable->; $ptrField->=$tSearchValue)
					End if 
					
					Case of 
						: (Records in selection:C76($ptrTable->)=1)
							XB_PutText($responseBag; "statusText"; "SUCCESS")
							XB_PutText($responseBag; "requestStatus"; "SUCCESS")  //for compatibility
							XB_PutBoolean($responseBag; "success"; True:C214)
							XB_PutRecord($responseBag; "record"; $ptrTable)
						: (Records in selection:C76($ptrTable->)>1)
							XB_PutText($responseBag; "statusText"; "FAIL-MULTIPLE RECORDS FOUND")
						Else 
							XB_PutText($responseBag; "statusText"; "FAIL-NOT FOUND")
					End case 
					
					UTIL_Log(Current method name:C684; "Search Value: "+$tSearchValue+" - "+XB_GetText($responseBag; "statusText"))
					
			End case 
			
		: ($tRequestType="LIST")
			
			ARRAY TEXT:C222($atList; 0)
			XB_GetAllItems($requestBag; ->$atList)
			$iCount:=XB_ItemCount($requestBag; "FieldList")
			
			READ WRITE:C146($ptrTable->)
			//ADD ANY SECURITY CHECKS HERE FOR SPECIFIC TABLES
			QUERY BY SQL:C942($ptrTable->; $tSearchValue)
			
			Case of 
				: (Records in selection:C76([eWires:13])>0)
					
					ARRAY LONGINT:C221($aiList; 0)
					ARRAY REAL:C219($arList; 0)
					ARRAY TEXT:C222($atList; 0)
					ARRAY DATE:C224($adList; 0)
					ARRAY BOOLEAN:C223($abList; 0)
					
					If ($tSecurityCode=$tSecurityCode)  //is Authorized so send record
						XB_PutText($responseBag; "statusText"; "SUCCESS")
						XB_PutText($responseBag; "requestStatus"; "SUCCESS")  //for compatibility
						XB_PutBoolean($responseBag; "success"; True:C214)
						XB_PutLong($responseBag; "DataListCount"; $iCount)
						XB_PutBoolean($responseBag; "requestJSON"; $useJSON)
						
						For ($i; 1; $iCount)
							
							XB_GetVariable($requestBag; "FieldList.Field"+String:C10($i); ->$iField)
							$ptrField:=Field:C253($iTable; $iField)
							$iType:=Type:C295($ptrField->)
							
							//<>TODO change to use JSON Stringify array
							//` OR BETTER
							// Selection to JSON ( aTable {; aField}{; aField2 ; ... ; aFieldN}{; template}) -> Function result
							//$useJSON:=False
							Case of 
								: ($iType=Is longint:K8:6) | ($iType=Is integer:K8:5)
									SELECTION TO ARRAY:C260($ptrField->; $aiList)
									If ($useJSON)
										XB_PutText($responseBag; "DataList.List"+String:C10($i); JSON Stringify array:C1228($aiList))  //<-- CONVERT OTHERS TO USE THIS
									Else 
										XB_PutArray($responseBag; "DataList.List"+String:C10($i); ->$aiList)
									End if 
									
								: ($iType=Is real:K8:4)
									SELECTION TO ARRAY:C260($ptrField->; $arList)
									If ($useJSON)
										XB_PutText($responseBag; "DataList.List"+String:C10($i); JSON Stringify array:C1228($arList))
									Else 
										XB_PutArray($responseBag; "DataList.List"+String:C10($i); ->$arList)
									End if 
									
								: ($iType=Is date:K8:7)
									SELECTION TO ARRAY:C260($ptrField->; $adList)
									If ($useJSON)
										XB_PutText($responseBag; "DataList.List"+String:C10($i); JSON Stringify array:C1228($adList))
									Else 
										XB_PutArray($responseBag; "DataList.List"+String:C10($i); ->$adList)
									End if 
									
								: ($iType=Is boolean:K8:9)
									SELECTION TO ARRAY:C260($ptrField->; $abList)
									If ($useJSON)
										XB_PutText($responseBag; "DataList.List"+String:C10($i); JSON Stringify array:C1228($abList))
									Else 
										XB_PutArray($responseBag; "DataList.List"+String:C10($i); ->$abList)
									End if 
									
								: ($iType=Is time:K8:8)  //<-- need to check what this is formated like? might be an issue
									SELECTION TO ARRAY:C260($ptrField->; $aiList)
									If ($useJSON)
										XB_PutText($responseBag; "DataList.List"+String:C10($i); JSON Stringify array:C1228($aiList))
									Else 
										XB_PutArray($responseBag; "DataList.List"+String:C10($i); ->$aiList)
									End if 
									
								: ($iType=Is BLOB:K8:12)
									//not handled
									
								: ($iType=Is picture:K8:10)
									//not handled
									
								Else   //assume text or string
									SELECTION TO ARRAY:C260($ptrField->; $atList)
									If ($useJSON)
										XB_PutText($responseBag; "DataList.List"+String:C10($i); JSON Stringify array:C1228($atList))
									Else 
										XB_PutArray($responseBag; "DataList.List"+String:C10($i); ->$atList)
									End if 
									
							End case 
							
						End for 
						
					Else 
						XB_PutText($responseBag; "statusText"; "FAIL-SECURITY")
						XB_PutText($responseBag; "requestStatus"; "FAIL-SECURITY")  //for compatibility
						XB_PutBoolean($responseBag; "success"; False:C215)
					End if 
					
				Else   //not not found
					XB_PutText($responseBag; "statusText"; "FAIL-NO RECORDS FOUND")
					XB_PutText($responseBag; "requestStatus"; "FAIL-NO RECORDS FOUND")  //for compatibility
					XB_PutBoolean($responseBag; "success"; False:C215)
			End case 
			
			
			//$xList:=XB_BagToBlob ($responseBag)
			//DOM EXPORT TO VAR($responseBag;$tVar)
			//SET TEXT TO PASTEBOARD($tVar)  //for debugging comment out for production
		Else 
			
	End case 
	
	UNLOAD RECORD:C212($ptrTable->)
	REDUCE SELECTION:C351($ptrTable->; 0)
	
	If (Read only state:C362($ptrTable->))  //currently readonly
	Else 
		If ($bReadOnly)  //started as readonly but now read write
			READ ONLY:C145($ptrTable->)
		End if 
	End if 
	
	
	
	XB_Clear($requestBag)
	
	$xResponse:=XB_BagToBlob($responseBag)
	XB_Clear($responseBag)
	
	COMPRESS BLOB:C534($xResponse; GZIP best compression mode:K22:18)
	WEB SEND BLOB:C654($xResponse; "application/x-4DREMOTE")
	
Else 
	
End if 

ON ERR CALL:C155($currOnErr)