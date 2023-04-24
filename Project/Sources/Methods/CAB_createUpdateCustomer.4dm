//%attributes = {}
// createUpdateCustomer

#DECLARE($customer : Object)->$success : Boolean

var $ISODate; $CustNo; $msg : Text
var $CustFull : Object
var $p : Integer
var $names : Collection

READ WRITE:C146([Customers:3])

$CustFull:=OB Get:C1224($customer; "Customer-Full")
$custNo:=String:C10(Num:C11($CustFull.CUSTNO))

If ($custNo#"")
	
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$CustNo)
	
	If (Records in selection:C76([Customers:3])=0)
		CREATE RECORD:C68([Customers:3])
		[Customers:3]CustomerID:1:=$CustNo  //$CustFull.CUSTNO
		$msg:=" NEW Customer: "+$CustNo
	Else 
		$msg:=" UPDATE Customer: "+$CustNo
	End if 
	
	
	
	If ($CustFull.FROZEN="N")
		[Customers:3]isOnHold:52:=False:C215
	Else 
		[Customers:3]isOnHold:52:=True:C214
	End if 
	
	
	Case of 
			
		: ($CustFull.CTYPE="I")
			
			
			[Customers:3]isCompany:41:=False:C215
			[Customers:3]FirstName:3:=$CustFull.Custpersonal.FSTNAME
			
			If (Not:C34(Undefined:C82($CustFull.Custpersonal.MIDNAME)))
				If ($CustFull.Custpersonal.MIDNAME#"")
					[Customers:3]FirstName:3:=$CustFull.Custpersonal.FSTNAME+" "+$CustFull.Custpersonal.MIDNAME
				End if 
			End if 
			[Customers:3]LastName:4:=$CustFull.Custpersonal.LSTNAME
			[Customers:3]FullName:40:=[Customers:3]FirstName:3+" "+[Customers:3]LastName:4
			
			If (([Customers:3]FirstName:3="") & ([Customers:3]LastName:4=""))
				[Customers:3]FullName:40:=$CustFull.FULLNAME
				
				$names:=Split string:C1554([Customers:3]FullName:40; " ")
				If ($names.length>0)
					[Customers:3]FirstName:3:=$names[0]
					If ($names.length>1)
						[Customers:3]LastName:4:=$names[$names.length-1]
					End if 
					
				End if 
				
				
			End if 
			
			$ISODate:=$CustFull.Custpersonal.DOB+"T00:00:00"
			[Customers:3]DOB:5:=Date:C102($ISODate)
			[Customers:3]Gender:120:=$CustFull.Custpersonal.GENDR
			
			[Customers:3]Address:7:=OB Get:C1224($CustFull; "ADDRLN2"; Is text:K8:3)+", "+OB Get:C1224($CustFull; "ADDRLN3"; Is text:K8:3)+", "+OB Get:C1224($CustFull; "ADDRLN4"; Is text:K8:3)
			[Customers:3]CountryOfBirthCode:18:=$CustFull.NLTY
			[Customers:3]Nationality:91:=getCountryNameByCode($CustFull.NLTY)
			
		: ($CustFull.CTYPE="B")  // Bank
			
			[Customers:3]isCompany:41:=True:C214
			[Customers:3]isWholesaler:87:=True:C214
			[Customers:3]FullName:40:=$CustFull.FULLNAME
			[Customers:3]CountryOfBirthCode:18:=$CustFull.NLTY
			[Customers:3]Nationality:91:=getCountryNameByCode($CustFull.NLTY)
			
		: ($CustFull.CTYPE="C")  // Company
			
			[Customers:3]isCompany:41:=True:C214
			[Customers:3]isCompany:41:=True:C214
			[Customers:3]isWholesaler:87:=True:C214
			[Customers:3]CompanyName:42:=$CustFull.Custcorp.CNAME
			[Customers:3]isCompany:41:=True:C214
			[Customers:3]FullName:40:=$CustFull.Custcorp.CNAME
			
			If (Not:C34(Undefined:C82($CustFull.Custpersonal.INCORPDT)))
				$ISODate:=$CustFull.Custpersonal.INCORPDT+"T00:00:00"
				[Customers:3]BusinessIncorporationDate:29:=Date:C102($ISODate)
			End if 
			
			
			If (Not:C34(Undefined:C82($CustFull.Custcorp.INCORPCNTRY)))
				[Customers:3]BusinessIncorporatedInCountry:67:=$CustFull.Custcorp.INCORPCNTRY
			End if 
			
			
			[Customers:3]Address:7:=$CustFull.Custcorp.CADDR1+CRLF+$CustFull.Custcorp.CADDR2+CRLF+$CustFull.Custcorp.CADDR3+CRLF+$CustFull.Custcorp.CADDR4
			
	End case 
	$msg:=$msg+" Full Name: "+[Customers:3]FullName:40
	
	NormalizeCustomerName
	
	// can we get ???
	// email
	// national id???
	// occupation
	// phone ??
	// 
	
	[Customers:3]approvalStatus:146:=0
	
	SAVE RECORD:C53([Customers:3])
	UTIL_Log("customers"; $msg)
	$success:=(ok=1)
End if 


