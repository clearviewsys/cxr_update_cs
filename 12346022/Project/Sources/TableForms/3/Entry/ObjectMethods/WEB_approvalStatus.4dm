
C_LONGINT:C283($ref)
C_TEXT:C284($text)

var $entity : Object

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (Records in table:C83([WebUsers:14])=0)
		Else   //assume we have data we need to eval
			$entity:=ds:C1482.WebUsers.query("Email IS :1"; [Customers:3]Email:17)
			Case of 
				: ($entity.length=0)
					OBJECT SET ENABLED:C1123(Self:C308->; False:C215)
					OBJECT Get pointer:C1124(Object named:K67:5; "APPROVE_helpText")->:="No [WebUser] Account"
				: ($entity.length>1)
					OBJECT SET ENABLED:C1123(Self:C308->; False:C215)
					OBJECT Get pointer:C1124(Object named:K67:5; "APPROVE_helpText")->:="Multiple [WebUser] Accounts Foud"
				: ($entity.first().isTokenConfirmed=False:C215)
					OBJECT SET ENABLED:C1123(Self:C308->; False:C215)
					OBJECT Get pointer:C1124(Object named:K67:5; "APPROVE_helpText")->:="[WebUser] Must Confirm Token"
				Else 
					OBJECT SET ENABLED:C1123(Self:C308->; True:C214)
					OBJECT Get pointer:C1124(Object named:K67:5; "APPROVE_helpText")->:=""
			End case 
		End if 
		
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