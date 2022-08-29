//%attributes = {}
// converts result recived from MoneyGram into object

C_TEXT:C284($1; $data; $currProperty; $currValue)
C_OBJECT:C1216($0)
C_LONGINT:C283($len; $i)
C_BOOLEAN:C305($inProperty; $inValue)

$data:=$1
$len:=Length:C16($data)

$inProperty:=True:C214
$inValue:=False:C215
$currProperty:=""
$currValue:=""
$i:=1

While ($i<=$len)
	
	Case of 
			
		: ($data[[$i]]="=")
			
			$inValue:=True:C214
			$inProperty:=False:C215
			
		: ($data[[$i]]="&")
			
			$inValue:=False:C215
			$inProperty:=True:C214
			
			If ($0=Null:C1517)
				$0:=New object:C1471
			End if 
			
			$0[$currProperty]:=$currValue
			
			$currProperty:=""
			$currValue:=""
			
		Else 
			
			If ($inProperty)
				$currProperty:=$currProperty+$data[[$i]]
			Else 
				$currValue:=$currValue+$data[[$i]]
			End if 
			
	End case 
	
	$i:=$i+1
	
End while 

If ($currProperty#"")
	
	If ($0=Null:C1517)
		$0:=New object:C1471
	End if 
	
	$0[$currProperty]:=$currValue
	
End if 
