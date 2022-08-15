C_LONGINT:C283(vNum)

If (Form event code:C388=On Header:K2:17)
	
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	If (Mod:C98(vNum; 2)=0)
		OBJECT SET VISIBLE:C603(*; "DetailBackground"; False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*; "DetailBackground"; True:C214)
	End if 
	
	
	If (vNum<=1)  //hide the line
		OBJECT SET VISIBLE:C603(*; "CurrencySeparatorLine"; True:C214)
	Else 
		If (vCurrency="")
			OBJECT SET VISIBLE:C603(*; "CurrencySeparatorLine"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "CurrencySeparatorLine"; True:C214)
		End if 
	End if 
End if 

If (Form event code:C388=On Printing Break:K2:19)
	
End if 


If (Form event code:C388=On Printing Footer:K2:20)
	//TRACE
	//vPageNum:=String(Printing page;"- ####0 -")
End if 