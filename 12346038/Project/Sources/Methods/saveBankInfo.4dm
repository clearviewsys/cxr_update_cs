//%attributes = {}
C_TEXT:C284($delim; $action)
C_BOOLEAN:C305($duplicate; $exists)
C_TEXT:C284($tmp)
C_LONGINT:C283($pos)

$exists:=False:C215
$action:=""
$delim:="  :  "

QUERY:C277([WireTemplates:42]; [WireTemplates:42]CustomerID:2=[Customers:3]CustomerID:1; *)
QUERY:C277([WireTemplates:42];  & ; [WireTemplates:42]AccountNo:6=vAccountNo)

If (Records in selection:C76([WireTemplates:42])>0)
	$tmp:=[WireTemplates:42]WireTemplateID:1+$delim+[WireTemplates:42]WireTemplateAlias:14
	
	If (updatewt)
		//myConfirm ("Wire template for this account already exists. Do you want to update it?";"Yes";"No")
		iH_Notify("Alert"; "Wire template for this account already exists. Existing wire template will be auto-selected"; 5)
		$action:="update"
		OK:=0
	Else 
		
		iH_Notify("Alert"; "Wire template for this account already exists. Existing wire template will be auto-selected"; 5)
		//myAlert ("Wire template for this account already exists. Auto selecting Wire template.")
		[AccountInOuts:37]Memo:10:=serializeWireTemplate
		$action:="duplicate"
		OK:=0
	End if 
	
	
Else 
	myConfirm("This action will create a new wire template for the customer. Are you sure?"; "Yes"; "No")
	$action:="create"
End if 

If (Ok=1)
	
	READ WRITE:C146([WireTemplates:42])
	READ WRITE:C146([AccountInOuts:37])
	
	Case of 
		: ($action="create")
			CREATE RECORD:C68([WireTemplates:42])
			
		: ($action="duplicate")
			CREATE RECORD:C68([WireTemplates:42])
			
	End case 
	
	
	[WireTemplates:42]WireTemplateID:1:=makeWireTemplateID
	[WireTemplates:42]BeneficiaryFullName:9:=vAccountName
	[WireTemplates:42]WireTemplateAlias:14:=vAccountName+":"+vBankName
	[WireTemplates:42]AccountNo:6:=vAccountNo
	
	[WireTemplates:42]BankName:3:=vBankName
	[WireTemplates:42]SWIFT:8:=vSwift
	[WireTemplates:42]BankName:3:=vBankName
	[WireTemplates:42]CustomerID:2:=[Customers:3]CustomerID:1
	
	[WireTemplates:42]Currency:36:=[Registers:10]Currency:19
	[AccountInOuts:37]WireTemplateID:27:=[WireTemplates:42]WireTemplateID:1
	[AccountInOuts:37]Memo:10:=serializeWireTemplate
	
	SAVE RECORD:C53([WireTemplates:42])
	SAVE RECORD:C53([AccountInOuts:37])
	
	If ($action="create")
		APPEND TO ARRAY:C911(wtPtr->; [WireTemplates:42]WireTemplateID:1+$delim+[WireTemplates:42]WireTemplateAlias:14)
		wtPtr->:=Size of array:C274(wtPtr->)
	End if 
Else 
	
	If ($action="update")
		$pos:=Find in array:C230(wtPtr->; $tmp)
		If ($pos>0)
			wtPtr->:=Size of array:C274(wtPtr->)
			[AccountInOuts:37]Memo:10:=serializeWireTemplate
		End if 
		
	End if 
	
	
End if 




