//%attributes = {"shared":true,"publishedWeb":true}

C_TEXT:C284($1; $tType)
C_LONGINT:C283($0)

C_OBJECT:C1216($entity)
C_TEXT:C284($tContext)


If (Count parameters:C259>=1)
	$tType:=$1
Else 
	$tType:="pending"
End if 

$tContext:=WAPI_getSession("context")

$entity:=New object:C1471
$entity.length:=0

Case of 
	: ($tContext="customers")
		webSelectCustomerRecord
		Case of 
			: ($tType="@pending")
				$entity:=ds:C1482.Bookings.query(Field name:C257(->[Bookings:50]CustomerID:2)+" == :1 AND "+Field name:C257(->[Bookings:50]isConfirmed:15)+" IS false"; [Customers:3]CustomerID:1)
			: ($tType="@confirmed")
				$entity:=ds:C1482.Bookings.query(Field name:C257(->[Bookings:50]CustomerID:2)+" == :1 AND "+Field name:C257(->[Bookings:50]isConfirmed:15)+" IS true AND "+Field name:C257(->[Bookings:50]isHonored:18)+" IS false"; [Customers:3]CustomerID:1)
			: ($tType="@complete")
				$entity:=ds:C1482.Bookings.query(Field name:C257(->[Bookings:50]CustomerID:2)+" == :1 AND "+Field name:C257(->[Bookings:50]isHonored:18)+" IS true"; [Customers:3]CustomerID:1)
				
		End case 
		
	: ($tContext="agents")
		
		
	Else 
		
		
End case 

$0:=$entity.length