//%attributes = {}
// createSelfCustomer


C_LONGINT:C283($i)
C_BOOLEAN:C305($bSave)
C_POINTER:C301($fieldPtr)

$bSave:=False:C215

QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=getSelfCustomerID)
// create the self customer
READ WRITE:C146([Customers:3])

If (Records in selection:C76([Customers:3])=0)
	CREATE RECORD:C68([Customers:3])
Else 
	LOAD RECORD:C52([Customers:3])
End if 

[Customers:3]CustomerID:1:=getSelfCustomerID
[Customers:3]isCompany:41:=True:C214
[Customers:3]CompanyName:42:=<>CompanyName
[Customers:3]Address:7:=<>CompanyAddress
[Customers:3]WorkTel:12:=<>CompanyTel1
[Customers:3]City:8:=<>companyCity
[Customers:3]Country_obs:11:=<>companyCountry
[Customers:3]Comments:43:=<>CompanyWebAddress
[Customers:3]isInsider:102:=True:C214


For ($i; 1; Get last field number:C255(->[Customers:3]))
	If (Is field number valid:C1000(->[Customers:3]; $i))
		$fieldPtr:=Field:C253(Table:C252(->[Customers:3]); $i)
		
		If (Type:C295($fieldPtr->)=Is picture:K8:10) | (Type:C295($fieldPtr->)=Is BLOB:K8:12)
			//don't eval these
		Else 
			If (Old:C35($fieldPtr->)#$fieldPtr->)
				$bSave:=True:C214
				$i:=9999  //bail out
			End if 
			
		End if 
	End if 
End for 


If ($bSave)
	SAVE RECORD:C53([Customers:3])
End if 

UNLOAD RECORD:C212([Customers:3])
READ ONLY:C145([Customers:3])


