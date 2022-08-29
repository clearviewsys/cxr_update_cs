
C_LONGINT:C283($ref)
C_TEXT:C284($text)

Case of 
	: (Form event code:C388=On Load:K2:1)
		SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->; [Customers:3]approvalStatus:146)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		GET LIST ITEM:C378(Self:C308->; Selected list items:C379(Self:C308->); $ref; $text)
		[Customers:3]approvalStatus:146:=$ref
		
	Else 
		
		
End case 

If ([Customers:3]approvalStatus:146=1)  //approved
	OBJECT SET ENTERABLE:C238(*; "WEB_allowInternetAccess"; True:C214)
	[Customers:3]isAllowedInternetAccess:50:=True:C214
	
	If ([Customers:3]isOnHold:52)
		[Customers:3]isOnHold:52:=False:C215  //assume we can take off hold
		[Customers:3]AML_OnHoldNotes:127:="Approved for web access"
	End if 
Else 
	OBJECT SET ENTERABLE:C238(*; "WEB_allowInternetAccess"; False:C215)
	[Customers:3]isAllowedInternetAccess:50:=False:C215
End if 