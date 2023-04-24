//%attributes = {}
C_TEXT:C284($0; $1; $ccinhex)
C_LONGINT:C283($i; $cc)
C_BLOB:C604($TextToEncode_x)

ASSERT:C1129(Count parameters:C259#0)

// we have to do this using BLOB because we could have clients that use languages using more than 4 byte Unicode characters

CONVERT FROM TEXT:C1011($1; "UTF-8"; $TextToEncode_x)

For ($i; 0; BLOB size:C605($TextToEncode_x)-1)
	
	$cc:=$TextToEncode_x{$i}
	
	Case of 
			
		: (($cc=Space:K15:42) | ($cc=Tab:K15:37) | ($cc=Line feed:K15:40) | ($cc=Carriage return:K15:38))
			
			$0:=$0+Char:C90($cc)
			
			
		: ($cc=0x003D)  //the equals sign
			
			$0:=$0+"=3D"
			
			
		: ($cc=0x005F)  //the under score (low line)
			
			$0:=$0+"=5F"
			
			
		: (($cc<0x007F) & ($cc>0x0020))  // US ASCII character
			
			$0:=$0+Char:C90($cc)
			
			
		Else 
			
			$ccinhex:=String:C10($cc; "&$")
			$ccinhex:=Replace string:C233($ccinhex; "$"; "")
			$0:=$0+"="+Choose:C955(Length:C16($ccinhex); "00"; "0"+$ccinhex; $ccinhex)
			
	End case 
	
End for 
