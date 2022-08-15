

Case of 
	: (Form event code:C388=On Data Change:K2:15)
		
		C_OBJECT:C1216($entity)
		C_TEXT:C284($tmp; $delim)
		C_LONGINT:C283($pos)
		
		$delim:="  :  "
		
		$entity:=ds:C1482.WireTemplates.query("CustomerID == :1 AND AccountNo == :2"; [Customers:3]CustomerID:1; vAccountNo)
		
		If ($entity.length>0)
			//myAlert ("There is an existing Wire Template for this account.")
			iH_Notify("Alert"; "There is an existing Wire Template for this account."; 5)
			vBankName:=$entity[0].BankName
			vAccountName:=$entity[0].WireTemplateAlias
			vSwift:=$entity[0].SWIFT
			
			
			$tmp:=$entity[0].WireTemplateID+$delim+$entity[0].WireTemplateAlias
			$pos:=Find in array:C230(wtPtr->; $tmp)
			If ($pos>0)
				wtPtr->:=Size of array:C274(wtPtr->)
				USE ENTITY SELECTION:C1513($entity)
				[AccountInOuts:37]Memo:10:=serializeWireTemplate
			End if 
			
		End if 
		
	Else 
		
End case 