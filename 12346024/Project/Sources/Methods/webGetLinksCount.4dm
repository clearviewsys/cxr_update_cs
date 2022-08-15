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
			: ($tType="@hold")
				$entity:=ds:C1482.Links.query(Field name:C257(->[Links:17]CustomerID:14)+" == :1 AND "+Field name:C257(->[Links:17]AML_isOnHold:54)+" IS true"; [Customers:3]CustomerID:1)
			: ($tType="@flagged")
				$entity:=ds:C1482.Links.query(Field name:C257(->[Links:17]CustomerID:14)+" == :1 AND "+Field name:C257(->[Links:17]isFlagged:32)+" IS true"; [Customers:3]CustomerID:1)
			Else 
				$entity:=ds:C1482.Links.query(Field name:C257(->[Links:17]CustomerID:14)+" == :1"; [Customers:3]CustomerID:1)
		End case 
		
	: ($tContext="agents")
		
		
	Else 
		
		
End case 

$0:=$entity.length