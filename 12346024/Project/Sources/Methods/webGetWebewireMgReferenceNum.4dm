//%attributes = {"publishedWeb":true,"shared":true}
C_OBJECT:C1216($1)  // current entity is passed in here

C_TEXT:C284($0)



Case of 
		
	: ($1.paymentInfo.result=Null:C1517)
		$0:="n/a"
		
	: ($1.paymentInfo.result.referenceNumber=Null:C1517)
		$0:="n/a"
		
	Else 
		$0:=$1.paymentInfo.result.referenceNumber
End case 
