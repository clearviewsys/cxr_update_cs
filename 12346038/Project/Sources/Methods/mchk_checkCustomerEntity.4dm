//%attributes = {}
//mchk_scanCustomerEntity($firstName;$lastName;$internalTableID;$internalRecordId;$customer)
//
// Scan a customer through MemberCheck and display a window if match is found.
//
// Paramters
// $customer (Entity C_OBJECT)
//    the customer to scan
//
// Return
//  the status number that can be use in sl_getSanctionListResultMsg and SetSanctionListCheckIcon
C_REAL:C285($0; $status)
C_TEXT:C284($1; $firstName)
C_TEXT:C284($2; $lastName)
C_REAL:C285($3; $internalTableID)
C_TEXT:C284($4; $internalRecordID)
C_OBJECT:C1216($5; $customer)

C_LONGINT:C283($winRef)


Case of 
	: (Count parameters:C259=2)
		$firstName:=$1
		$lastName:=$2
		$internalTableID:=-1
		$internalRecordID:=""
		$customer:=New object:C1471
	: (Count parameters:C259=4)
		$firstName:=$1
		$lastName:=$2
		$internalTableID:=$3
		$internalRecordID:=$4
		$customer:=New object:C1471
	: (Count parameters:C259=5)
		$firstName:=$1
		$lastName:=$2
		$internalTableID:=$3
		$internalRecordID:=$4
		$customer:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_REAL:C285($progressID)
$progressID:=Progress New
Progress SET TITLE($progressID; "Running Member Check...")
Progress SET MESSAGE($progressID; "Setup...")
Progress SET WINDOW VISIBLE(True:C214)

$status:=-1

C_TEXT:C284($mChkStatus)
$mChkStatus:=getKeyValue("MemberCheck.Status")

C_BOOLEAN:C305($isActivited)
$isActivited:=($mChkStatus="demo") | ($mChkStatus="app")

C_BOOLEAN:C305($proccessing)
$proccessing:=$isActivited
If ($proccessing)
	$proccessing:=(Length:C16($firstName)+Length:C16($lastName)+1)>3
End if 

If ($proccessing)
	QUERY:C277([mchk_CheckLog:142]; [mchk_CheckLog:142]InternalTableID:10=$internalTableID; *)
	QUERY:C277([mchk_CheckLog:142]; [mchk_CheckLog:142]InternalRecordID:3=$internalRecordID)
	
	// Force a new check if the check is not last done on today
	ORDER BY:C49([mchk_CheckLog:142]; [mchk_CheckLog:142]ResponseDate:8)
	If (Records in selection:C76([mchk_CheckLog:142])>0)
		If ([mchk_CheckLog:142]ResponseDate:8<Current date:C33(*))
			REDUCE SELECTION:C351([mchk_CheckLog:142]; 0)
		End if 
	End if 
End if 


C_OBJECT:C1216($formInput)
If ($proccessing)
	$formInput:=New object:C1471
	$path:="/api/v1/member-scans/single"
	If (Records in selection:C76([mchk_CheckLog:142])=0)
		C_OBJECT:C1216($body)
		$body:=New object:C1471
		
		$body.matchType:=getKeyValue("MemberCheck.MatchType"; "Close")
		C_COLLECTION:C1488($possibleValues)
		$possibleValues:=New collection:C1472("Close"; "Exact")
		If ($possibleValues.indexOf($body.matchType)=-1)
			$body.matchType:="Close"
		End if 
		
		$body.whitelist:=getKeyValue("MemberCheck.ApplyWhitelist"; "Apply")
		$possibleValues:=New collection:C1472("Apply"; "Ignore")
		If ($possibleValues.indexOf($body.whitelist)=-1)
			$body.whitelist:="Apply"
		End if 
		
		C_TEXT:C284($path)
		$body.residence:=getKeyValue("MemberCheck.ApplyResidence"; "ApplyAll")
		$possibleValues:=New collection:C1472("ApplyPEP"; "ApplyAll"; "Ignore"; "ApplySIP"; "ApplyRCA")
		If ($possibleValues.indexOf($body.residence)=-1)
			$body.whitelist:="ApplyAll"
		End if 
		
		$body.pepJurisdiction:=getKeyValue("MemberCheck.ApplyPEPJurisdiction"; "ApplyBoth")
		$possibleValues:=New collection:C1472("ApplyResidence"; "ApplyCitizenship"; "ApplyBoth"; "Ignore"; "ApplyJurisdiction"; "Apply")
		If ($possibleValues.indexOf($body.pepJurisdiction)=-1)
			$body.pepJurisdiction:="ApplyBoth"
		End if 
		
		$body.memberNumber:=$internalRecordID
		$body.firstName:=$firstName
		$body.lastName:=$lastName
		
		If (OB Is defined:C1231($customer; "Gender"))
			Case of   //Gender 
				: ($customer.Gender="M")
					$body.gender:="Male"
				: ($customer.Gender="F")
					$body.gender:="Female"
				: ($customer.Gender="")
					$body.gender:=""
			End case 
		End if 
		
		If (OB Is defined:C1231($customer; "DOB"))
			C_DATE:C307($DOB)
			$DOB:=Date:C102($customer.DOB)
			If ($DOB#!00-00-00!)
				$body.dob:=String:C10(Day of:C23($DOB))
				$body.dob:=$body.dob+"/"+String:C10(Month of:C24($DOB))
				$body.dob:=$body.dob+"/"+String:C10(Year of:C25($DOB))
			End if 
		End if 
		
		$body.closeMatchRateThreshold:=Num:C11(getKeyValue("MemberCheck.CloseMatchRateThreshold"; "0"))
		
		$body.address:=""
		If (OB Is defined:C1231($customer; "Address"))
			$body.address:=$body.address+$customer.Address+"\n"
		End if 
		If (OB Is defined:C1231($customer; "City"))
			$body.address:=$body.address+$customer.City+"\n"
		End if 
		If (OB Is defined:C1231($customer; "Province"))
			$body.address:=$body.address+$customer.Province+"\n"
		End if 
		If (OB Is defined:C1231($customer; "PostalCode"))
			$body.address:=$body.address+$customer.PostalCode+"\n"
		End if 
		If (OB Is defined:C1231($customer; "CountryCode"))
			$body.address:=$body.address+$customer.CountryCode+"\n"
		End if 
		Progress SET MESSAGE($progressID; "Sending a HTTP request")
		C_OBJECT:C1216($data)
		$data:=mchk_httpRequestMemberCheck(HTTP POST method:K71:2; $path; $body)
		If ($data.status<400)
			Progress SET MESSAGE($progressID; "Saving MemberCheck results.")
			
			READ WRITE:C146([mchk_CheckLog:142])
			CREATE RECORD:C68([mchk_CheckLog:142])
			[mchk_CheckLog:142]InternalTableID:10:=$internalTableID
			[mchk_CheckLog:142]InternalRecordID:3:=$internalRecordID
			[mchk_CheckLog:142]MemberCheckID:1:=String:C10($data.returned.scanId)
			[mchk_CheckLog:142]Size:4:=$data.returned.matchedNumber
			[mchk_CheckLog:142]Enviornment:7:=$mChkStatus
			[mchk_CheckLog:142]ResponseDate:8:=Current date:C33(*)
			[mchk_CheckLog:142]isCompany:9:=False:C215
			SAVE RECORD:C53([mchk_CheckLog:142])
			UNLOAD RECORD:C212([mchk_CheckLog:142])
			
			$formInput:=New object:C1471
			$formInput.scanParam:=$body
			$formInput.scanResult:=$data.returned
		End if 
	Else 
		Progress SET MESSAGE($progressID; "Sending a HTTP request")
		
		$path:=$path+"/"+[mchk_CheckLog:142]MemberCheckID:1
		$data:=mchk_httpRequestMemberCheck(HTTP GET method:K71:1; $path)
		$formInput:=$data.returned
	End if 
	If ($data.status>=300)
		$status:=-1
		$proccessing:=False:C215
	End if 
End if 

Progress SET MESSAGE($progressID; "Clean up...")
If ($isActivited & $proccessing)
	If ($formInput.scanResult.matchedNumber=0)
		$proccessing:=False:C215
		$status:=0
	Else 
		$status:=1
		C_OBJECT:C1216($entity)
		For each ($entity; $formInput.scanResult.matchedEntities) While ($status=1)
			If ($entity.matchRate=100)
				$status:=2
			End if 
		End for each 
	End if 
	
End if 



Progress SET WINDOW VISIBLE(False:C215)
Progress QUIT($progressID)

If ($isActivited & $proccessing)
	$formInput.page:=0
	$winRef:=Open form window:C675("mchk_ScanPersonResult")
	DIALOG:C40("mchk_ScanPersonResult"; $formInput)
	CLOSE WINDOW:C154($winRef)
End if 

$0:=$status