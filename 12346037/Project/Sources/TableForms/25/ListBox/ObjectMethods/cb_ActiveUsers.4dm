C_POINTER:C301($self)
$self:=Self:C308
READ ONLY:C145([Users:25])
Case of 
	: ($self->=0)
		ALL RECORDS:C47([Users:25])
	: ($self->=1)
		QUERY:C277([Users:25]; [Users:25]isInactive:18=False:C215)
	Else 
		QUERY:C277([Users:25]; [Users:25]isInactive:18=True:C214)
End case 
orderByUsers