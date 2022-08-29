//%attributes = {}


C_BOOLEAN:C305($0; $isAllowed)

$isAllowed:=False:C215


Case of 
	: (Choose:C955(getKeyValue("web.customers.module.quotes.moneygram.group")=[Customers:3]GroupName:90; True:C214; False:C215))
		$isAllowed:=True:C214
	: (Choose:C955(getKeyValue("web.customers.module.quotes.moneygram.group")="*"; True:C214; False:C215))
		$isAllowed:=True:C214
	: (Choose:C955(getKeyValue("web.customers.module.quotes.moneygram.group")=""; True:C214; False:C215))
		$isAllowed:=True:C214
	Else 
		$isAllowed:=False:C215
End case 

$0:=$isAllowed