//%attributes = {}
//mchk_scanCustomerEntity($customer)
// #Deprecated use mchk_checkCustomerEntity instead
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
C_OBJECT:C1216($1; $customer)
Case of 
	: (Count parameters:C259=1)
		$customer:=$1
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
	If ($customer.isCompany)
		$proccessing:=Length:C16($customer.CompanyName)>3
	Else 
		$proccessing:=(Length:C16($customer.FirstName)+Length:C16($customer.LastName))>3
	End if 
End if 


C_OBJECT:C1216($formInput)
If ($proccessing)
	$formInput:=New object:C1471
	If ($customer.isCompany)
		$path:="/api/v1/corp-scans/single"
	Else 
		$path:="/api/v1/member-scans/single"
	End if 
	
	QUERY:C277([mchk_CheckLog:142]; [mchk_CheckLog:142]InternalRecordID:3=$customer.CustomerID; *)
	QUERY:C277([mchk_CheckLog:142]; [mchk_CheckLog:142]InternalTableID:10=Table:C252(->[Customers:3]))
	
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
		If ($customer.isCompany)
			$body.companyName:=$customer.CompanyName
			$body.entityNumber:=$customer.CustomerID
		Else 
			
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
			
			
			$body.memberNumber:=$customer.CustomerID
			$body.firstName:=$customer.FirstName
			$body.lastName:=$customer.LastName
			Case of 
				: ($customer.Gender="M")
					$body.gender:="Male"
				: ($customer.Gender="F")
					$body.gender:="Female"
				: ($customer.Gender="")
					$body.gender:=""
			End case 
			
			If ($customer.DOB#!00-00-00!)
				$body.dob:=String:C10(Day of:C23($customer.DOB))
				$body.dob:=$body.dob+"/"+String:C10(Month of:C24($customer.DOB))
				$body.dob:=$body.dob+"/"+String:C10(Year of:C25($customer.DOB))
			End if 
			$body.closeMatchRateThreshold:=Num:C11(getKeyValue("MemberCheck.CloseMatchRateThreshold"; "0"))
		End if 
		$body.address:=$customer.Address
		$body.address:=$body.address+"\n"+$customer.City
		$body.address:=$body.address+" "+$customer.Province
		$body.address:=$body.address+"\n"+$customer.PostalCode
		$body.address:=$body.address+"\n"+$customer.CountryCode
		Progress SET MESSAGE($progressID; "Sending a HTTP request")
		C_OBJECT:C1216($data)
		$data:=mchk_httpRequestMemberCheck(HTTP POST method:K71:2; $path; $body)
		If ($data.status<400)
			Progress SET MESSAGE($progressID; "Saving MemberCheck results.")
			
			READ WRITE:C146([mchk_CheckLog:142])
			CREATE RECORD:C68([mchk_CheckLog:142])
			[mchk_CheckLog:142]InternalTableID:10:=Table:C252(->[Customers:3])
			[mchk_CheckLog:142]InternalRecordID:3:=$customer.CustomerID
			[mchk_CheckLog:142]MemberCheckID:1:=String:C10($data.returned.scanId)
			[mchk_CheckLog:142]Size:4:=$data.returned.matchedNumber
			[mchk_CheckLog:142]Enviornment:7:=$mChkStatus
			[mchk_CheckLog:142]ResponseDate:8:=Current date:C33(*)
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
	C_LONGINT:C283($winRef)
	If ($customer.isCompany)
		$winRef:=Open form window:C675("mchk_ScanCompanyResult")
		DIALOG:C40("mchk_ScanCompanyResult"; $formInput)
		CLOSE WINDOW:C154($winRef)
	Else 
		$winRef:=Open form window:C675("mchk_ScanPersonResult")
		DIALOG:C40("mchk_ScanPersonResult"; $formInput)
		CLOSE WINDOW:C154($winRef)
	End if 
End if 

$0:=$status