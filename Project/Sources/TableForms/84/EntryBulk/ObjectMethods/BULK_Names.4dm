

Case of 
	: (Form event code:C388=On Losing Focus:K2:8)
		
		C_POINTER:C301($ptrCodes; $ptrOrders; $ptrNames)
		
		$ptrCodes:=OBJECT Get pointer:C1124(Object named:K67:5; "BULK_Codes")
		$ptrOrders:=OBJECT Get pointer:C1124(Object named:K67:5; "BULK_Orders")
		$ptrNames:=OBJECT Get pointer:C1124(Object named:K67:5; "BULK_Names")
		
		APPEND TO ARRAY:C911($ptrCodes->; "")
		APPEND TO ARRAY:C911($ptrOrders->; 0)
		APPEND TO ARRAY:C911($ptrNames->; "<ITEM NAME>")
		
		EDIT ITEM:C870($ptrCodes->; Size of array:C274($ptrCodes->))
		
		
	Else 
		
End case 