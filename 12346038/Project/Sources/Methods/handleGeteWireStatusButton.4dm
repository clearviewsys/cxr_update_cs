//%attributes = {}
C_TEXT:C284(veWireID; vSecurityCode)
C_DATE:C307(vDate)
C_TEXT:C284(vSenderName)
C_TEXT:C284(vBeneficiaryName)
C_REAL:C285(vFromAmount)
C_REAL:C285(vToAmount)
C_TEXT:C284(vFromCountryCode)
C_TEXT:C284(vToCountryCode)


C_TEXT:C284(vCurrency)
C_BOOLEAN:C305(vIsSettled)
C_TEXT:C284(vComments)
C_BOOLEAN:C305(vIsFetched)
C_DATE:C307(vFetchDate)
C_TEXT:C284(vFetchLocation)
C_TEXT:C284(vBeneficiaryAmendedName)
C_BLOB:C604($xRecord)
C_LONGINT:C283($iError; $iTable; $iField)
C_TEXT:C284($tXML)
C_BOOLEAN:C305($allowFetch)


If (getKeyValue("ewire.getstatus.mode"; "1")="0")  //òld method
	geteWireStatusRemotely(veWireID; vSecurityCode; ->vDate; ->vSenderName; ->vBeneficiaryName; ->vFromAmount; ->vToAmount; ->vCurrency; ->vFromCountryCode; ->vToCountryCode; ->vIsSettled; ->vComments; ->vIsFetched; ->vFetchDate; ->vFetchLocation; ->vBeneficiaryAmendedName)
	//openFormWindow (->[eWires];"eWireStatus")
Else 
	$iTable:=Table:C252(->[eWires:13])
	$iField:=Field:C253(->[eWires:13]eWireID:1)
	
	$iError:=WS_Remote_Record_Status($iTable; $iField; veWireID; ""; vSecurityCode; <>eWireServerURL; ->$xRecord)
	
	
	Case of 
		: ($iError=0)
			$tXML:=XB_BlobToBag($xRecord)
			
			vDate:=XB_GetDate($tXML; Field name:C257(->[eWires:13]SendDate:2))  // sent date
			vSenderName:=XB_GetText($tXML; Field name:C257(->[eWires:13]SenderName:7))  // sent by
			vBeneficiaryName:=XB_GetText($tXML; Field name:C257(->[eWires:13]BeneficiaryFullName:5))  // beneficiary full name 
			vBeneficiaryAddress:=XB_GetText($tXML; Field name:C257(->[eWires:13]BeneficiaryAddress:59))
			vBeneficiaryAddress:=vBeneficiaryAddress+", "+XB_GetText($tXML; Field name:C257(->[eWires:13]BeneficiaryCity:60))
			vBeneficiaryCell:=XB_GetText($tXML; Field name:C257(->[eWires:13]BeneficiaryCellPhone:61))
			vPurpose:=XB_GetText($tXML; Field name:C257(->[eWires:13]PurposeOfTransaction:65))
			
			
			vBankName:=XB_GetText($tXML; Field name:C257(->[eWires:13]BeneficiaryBankName:76))
			vBankAccount:=XB_GetText($tXML; Field name:C257(->[eWires:13]BeneficiaryBankAccountNo:66))
			vInvoiceNum:=XB_GetText($tXML; Field name:C257(->[eWires:13]InvoiceNumber:29))
			
			vFromAmount:=XB_GetReal($tXML; Field name:C257(->[eWires:13]FromAmount:13))  // from Amount
			vToAmount:=XB_GetReal($tXML; Field name:C257(->[eWires:13]ToAmount:14))  // to Amount
			vCurrency:=XB_GetText($tXML; Field name:C257(->[eWires:13]Currency:12))  // currency
			vToMOPCode:=XB_GetText($tXML; Field name:C257(->[eWires:13]toMOP_Code:114))
			vToMOP:=getPaymentTypeFromCode(vToMOPCode)
			
			vFromCountryCode:=XB_GetText($tXML; Field name:C257(->[eWires:13]fromCountryCode:111))  // fromCountry
			vToCountryCode:=XB_GetText($tXML; Field name:C257(->[eWires:13]toCountryCode:112))  // toCountry
			vIsSettled:=XB_GetBoolean($tXML; Field name:C257(->[eWires:13]isSettled:23))  // isSettled
			vComments:=XB_GetText($tXML; Field name:C257(->[eWires:13]comments_Visible:48))  // comments
			
			vIsFetched:=XB_GetBoolean($tXML; Field name:C257(->[eWires:13]isLocked:79))  // isFetched
			vFetchDate:=XB_GetDate($tXML; Field name:C257(->[eWires:13]lockedDate:80))  // fetch Date
			vFetchLocation:=XB_GetText($tXML; Field name:C257(->[eWires:13]lockedSite:83))  // fetchedSite
			
			vBeneficiaryAmendedName:=XB_GetText($tXML; Field name:C257(->[eWires:13]BeneficiaryAmendedName:119))  // beneficiary full name 
			vStatus:=XB_GetText($tXML; Field name:C257(->[eWires:13]Status:22))
			
		: ($iError=-1)
			myAlert("Failed to Fetch- Security Code Incorrect")
		: ($iError=-2)
			myAlert("Failed to Fetch- eWire not found on server")
			
		: ($iError=-3)
			myAlert("Failed to Fetch- Several records with conflicting IDs found on server.")
			
		: ($iError=-20)
			myAlert("Failed to Fetch- eWire is already fetched.")
			
		Else   //unknown error
			myAlert("Failed to Fetch- Unknown Error Code.")
			
	End case 
	
	Case of 
		: (vIsSettled)
			$allowFetch:=False:C215
		: (vToMOPCode=getKeyValue("ewire.tomop.cash"; "D"))  //cash trans"
			$allowFetch:=True:C214
		: (vToMOPCode=getKeyValue("ewire.tomop.bank"; "N")) & (getKeyValue("ewire.fetch.bank"; "false")="true")
			$allowFetch:=True:C214
		: (vToMOPCode=getKeyValue("ewire.tomop.mobilewallet"; "N-M")) & (getKeyValue("ewire.fetch.mobilewallet"; "false")="true")
			$allowFetch:=True:C214
		Else 
			$allowFetch:=False:C215
	End case 
	
	If ($allowFetch)
		OBJECT SET ENTERABLE:C238(*; "FETCH_PickCustomer@"; True:C214)
		OBJECT SET ENABLED:C1123(*; "FETCH_PickCustomer@"; True:C214)
		OBJECT SET ENABLED:C1123(*; "FETCH_FetcheWire@"; True:C214)
		
		C_PICTURE:C286($pic)
		OBJECT Get pointer:C1124(Object named:K67:5; "FETCH_Status")->:=$pic
		
	Else 
		OBJECT SET ENTERABLE:C238(*; "FETCH_PickCustomer@"; False:C215)
		OBJECT SET ENABLED:C1123(*; "FETCH_PickCustomer@"; False:C215)
		OBJECT SET ENABLED:C1123(*; "FETCH_FetcheWire@"; False:C215)
		
		stampText("FETCH_Status"; "Fetch NOT Authorized"; "red")
	End if 
	
End if 