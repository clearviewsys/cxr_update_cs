//%attributes = {}
C_TEXT:C284($0)

READ ONLY:C145([Branches:70])
QUERY:C277([Branches:70]; [Branches:70]BranchID:1=getClientBranchID)  // select this branch
If (Records in selection:C76([Branches:70])=1)
	$0:=env_makeAddressText([Branches:70]Address:3; [Branches:70]City:4; [Branches:70]Province:10; [Branches:70]PostalCode:11; [Branches:70]CountryCode:12)
Else 
	$0:=env_makeAddressText(<>COMPANYADDRESS; <>COMPANYCITY; ""; ""; <>COMPANYCOUNTRY)
End if 