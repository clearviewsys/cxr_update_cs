//%attributes = {}

// ------------------------------------------------------------------------------
// FJ_AddTagToReport ($tag; $tagInfo; {$required=false} {$addCRLF=true}
// Add a Tag and tag info to FIJI Report
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $tag; $2; $tagInfo)
C_BOOLEAN:C305($3; $required; $crlf)
C_TEXT:C284($0)


Case of 
		
	: (Count parameters:C259=2)
		
		$tag:=$1
		$tagInfo:=FJ_Trim($2)
		$required:=False:C215
		$crlf:=True:C214
		
	: (Count parameters:C259=3)
		
		$tag:=$1
		$tagInfo:=FJ_Trim($2)
		$required:=$3
		$crlf:=True:C214
		
	: (Count parameters:C259=4)
		
		$tag:=$1
		$tagInfo:=FJ_Trim($2)
		$required:=$3
		$crlf:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


Case of 
	: (($tag="000") & ($required))
		
		If ($tagInfo#"")
			$0:=", "+$tagInfo
		Else 
			$0:=", "+"*MISSING*"
		End if 
		
		
	: (($tag="001") & ($required))
		
		If ($tagInfo#"")
			$0:=$tagInfo
		Else 
			$0:=" *MISSING*"
		End if 
		
		
	: (($tagInfo#"") & ($required))
		$0:=$tag+$tagInfo
		
	: (($tagInfo#"") & (Not:C34($required)))
		
		If ($tagInfo#"")
			$0:=$tag+$tagInfo
		End if 
		
	: (($tagInfo="") & ($required))
		$0:=$tag+" *MISSING*"
		
	: (($tagInfo="") & (Not:C34($required)))
		// DO Nothing
		$0:=""
		
	Else 
		$0:=$tagInfo
		// TRACE  // TODO: Only for testing
		
End case 


If (($crlf) & ($0#""))
	If (FJ_Trim($0)#"")
		$0:=$0+CRLF
	End if 
	
End if 


