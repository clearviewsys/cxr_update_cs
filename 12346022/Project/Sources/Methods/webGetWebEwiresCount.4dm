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
		
		
		//-20=Denied
		//-10=Cancelled
		//0=draft
		//5-Pending-Waiting for Payment from customer
		//10=Pending Review-by Teller
		//20=Approved
		//30=Sent-Invoiced and Sent
		//40 = Completed -Fetched Beneficiary received
		
		Case of 
			: ($tType="@denied")
				$entity:=ds:C1482.WebEWires.query(Field name:C257(->[WebEWires:149]CustomerID:21)+" == :1 AND "+Field name:C257(->[WebEWires:149]status:16)+" == -20"; [Customers:3]CustomerID:1)
			: ($tType="@cancelled")
				$entity:=ds:C1482.WebEWires.query(Field name:C257(->[WebEWires:149]CustomerID:21)+" == :1 AND "+Field name:C257(->[WebEWires:149]status:16)+" == -10"; [Customers:3]CustomerID:1)
			: ($tType="@draft")
				$entity:=ds:C1482.WebEWires.query(Field name:C257(->[WebEWires:149]CustomerID:21)+" == :1 AND "+Field name:C257(->[WebEWires:149]status:16)+" == 0"; [Customers:3]CustomerID:1)
			: ($tType="@pendingPayment")
				$entity:=ds:C1482.WebEWires.query(Field name:C257(->[WebEWires:149]CustomerID:21)+" == :1 AND "+Field name:C257(->[WebEWires:149]status:16)+" == 5"; [Customers:3]CustomerID:1)
			: ($tType="@pending")  //pending review
				$entity:=ds:C1482.WebEWires.query(Field name:C257(->[WebEWires:149]CustomerID:21)+" == :1 AND "+Field name:C257(->[WebEWires:149]status:16)+" == 10"; [Customers:3]CustomerID:1)
			: ($tType="@approved")  //approved
				$entity:=ds:C1482.WebEWires.query(Field name:C257(->[WebEWires:149]CustomerID:21)+" == :1 AND "+Field name:C257(->[WebEWires:149]status:16)+" == 20"; [Customers:3]CustomerID:1)
			: ($tType="@sent")  //sent via invoice/ewire
				$entity:=ds:C1482.WebEWires.query(Field name:C257(->[WebEWires:149]CustomerID:21)+" == :1 AND "+Field name:C257(->[WebEWires:149]status:16)+" == 30"; [Customers:3]CustomerID:1)
			: ($tType="@completed")  //completed and fetched
				$entity:=ds:C1482.WebEWires.query(Field name:C257(->[WebEWires:149]CustomerID:21)+" == :1 AND "+Field name:C257(->[WebEWires:149]status:16)+" == 40"; [Customers:3]CustomerID:1)
			Else 
				$entity:=ds:C1482.WebEWires.query(Field name:C257(->[WebEWires:149]CustomerID:21)+" == :1"; [Customers:3]CustomerID:1)
		End case 
		
	: ($tContext="agents")
		
		
	Else 
		
		
End case 

$0:=$entity.length