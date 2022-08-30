If ((vRowNumber%2)=0)
	//colourizeObject ("backStripe";White ;White )
	OBJECT SET VISIBLE:C603(*; "backStripe"; True:C214)
Else 
	//colourizeObject ("backStripe";White ;Light Grey )
	OBJECT SET VISIBLE:C603(*; "backStripe"; False:C215)
	
End if 