If (Self:C308->)
	OBJECT SET ENTERABLE:C238([eWires:13]DeliveryAddress:37; True:C214)
	GOTO OBJECT:C206([eWires:13]DeliveryAddress:37)
Else 
	OBJECT SET ENTERABLE:C238([eWires:13]DeliveryAddress:37; False:C215)
	[eWires:13]DeliveryAddress:37:=""
End if 


If (([eWires:13]doDeliverToAddress:32) & ([eWires:13]DeliveryAddress:37=""))
	[eWires:13]DeliveryAddress:37:=[Links:17]Address:19
End if 