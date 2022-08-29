//%attributes = {"shared":true,"publishedWeb":true}
C_TEXT:C284($0; $gateway)


$gateway:=""


If (True:C214)
	
	If ([WebEWires:149]paymentInfo:35=Null:C1517)
	Else 
		
		$gateway:=[WebEWires:149]paymentInfo:35.gateway
		
		If ($gateway="") & ([WebEWires:149]paymentInfo:35.poliLink#"")
			$gateway:="polipaylink"  //to handle "old" test records lotus
		End if 
		
	End if 
	
Else   // this doesn't work if the webewires record hasn't been saved
	C_OBJECT:C1216($we)
	
	$we:=New object:C1471
	$we:=Create entity selection:C1512([WebEWires:149])  //assume we have the record
	
	If (OB Get type:C1230($we.first(); "paymentInfo")=Is null:K8:31)
	Else 
		If (OB Is defined:C1231($we.first().paymentInfo))
			$gateway:=$we.first().paymentInfo.gateway
			
			If ($gateway="") & ($we.first().poliLink#"")
				$gateway:="polipaylink"  //to handle "old" test records lotus
			End if 
		End if 
	End if 
End if 

$0:=$gateway