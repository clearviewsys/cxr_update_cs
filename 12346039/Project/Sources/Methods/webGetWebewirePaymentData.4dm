//%attributes = {"shared":true,"publishedWeb":true}

C_TEXT:C284($0; $data)

C_LONGINT:C283($i)
C_TEXT:C284($value)

$data:=""



Case of 
	: ([WebEWires:149]paymentInfo:35.paymentData#Null:C1517)
		ARRAY TEXT:C222($atProperties; 0)
		OB GET PROPERTY NAMES:C1232([WebEWires:149]paymentInfo:35.paymentData; $atProperties)
		If (Size of array:C274($atProperties)>0)
			For ($i; 1; Size of array:C274($atProperties))
				$value:=OB Get:C1224([WebEWires:149]paymentInfo:35.paymentData; $atProperties{$i}; Is text:K8:3)
				If ($value="")
				Else 
					$data:=$data+"<tr><td>"
					$data:=$data+$atProperties{$i}+"</td>"
					$data:=$data+"<td>"+$value+"</td></tr>"
				End if 
			End for 
		End if 
		
		
		
	: ([WebEWires:149]paymentInfo:35.payment#Null:C1517)  // old method
		ARRAY TEXT:C222($atProperties; 0)
		OB GET PROPERTY NAMES:C1232([WebEWires:149]paymentInfo:35.payment; $atProperties)
		If (Size of array:C274($atProperties)>0)
			For ($i; 1; Size of array:C274($atProperties))
				$value:=OB Get:C1224([WebEWires:149]paymentInfo:35.payment; $atProperties{$i}; Is text:K8:3)
				If ($value="")
				Else 
					$data:=$data+"<tr><td>"
					$data:=$data+$atProperties{$i}+"</td>"
					$data:=$data+"<td>"+$value+"</td></tr>"
				End if 
			End for 
		End if 
		
		
	Else 
		ARRAY TEXT:C222($atProperties; 0)
		OB GET PROPERTY NAMES:C1232([WebEWires:149]paymentInfo:35; $atProperties)
		If (Size of array:C274($atProperties)>0)
			For ($i; 1; Size of array:C274($atProperties))
				$value:=OB Get:C1224([WebEWires:149]paymentInfo:35; $atProperties{$i}; Is text:K8:3)
				If ($value="")
				Else 
					$data:=$data+"<tr><td>"
					$data:=$data+$atProperties{$i}+"</td>"
					$data:=$data+"<td>"+$value+"</td></tr>"
				End if 
			End for 
		End if 
		
End case 


If ($data="")
	$0:=""
Else 
	$0:="<table class='table table-default'>"+$data+"</table>"
End if 
