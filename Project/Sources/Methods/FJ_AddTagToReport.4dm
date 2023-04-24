//%attributes = {}

// ------------------------------------------------------------------------------
// FJ_AddTagToReport ($tag; $tagInfo; {$required=false} {$addCRLF=true}
// Add a Tag and tag info to FIJI Report
// ------------------------------------------------------------------------------

#DECLARE($tag : Text; $tagInfo : Text; $required : Boolean)->$tagResult : Text

var $crlf : Boolean

Case of 
		
	: (Count parameters:C259=2)
		
		$tag:=$1
		$tagInfo:=FJ_Trim($tagInfo)
		$required:=False:C215
		$crlf:=True:C214
		
	: (Count parameters:C259=3)
		
		$tag:=$1
		$tagInfo:=FJ_Trim($tagInfo)
		$required:=$3
		$crlf:=True:C214
		
	: (Count parameters:C259=4)
		
		$tag:=$1
		$tagInfo:=FJ_Trim($tagInfo)
		$required:=$3
		$crlf:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


Case of 
	: (($tag="000") & ($required))
		
		If ($tagInfo#"")
			$tagResult:=", "+$tagInfo
		Else 
			$tagResult:=", "+"*MISSING*"
		End if 
		
		
	: (($tag="001") & ($required))
		
		If ($tagInfo#"")
			$tagResult:=$tagInfo
		Else 
			$tagResult:=" *MISSING*"
		End if 
		
		
	: (($tagInfo#"") & ($required))
		$tagResult:=$tag+$tagInfo
		
	: (($tagInfo#"") & (Not:C34($required)))
		
		If ($tagInfo#"")
			$tagResult:=$tag+$tagInfo
		End if 
		
	: (($tagInfo="") & ($required))
		$tagResult:=$tag+" *MISSING*"
		
	: (($tagInfo="") & (Not:C34($required)))
		// DO Nothing
		$tagResult:=""
		
	Else 
		$tagResult:=$tagInfo
		// TRACE  // TODO: Only for testing
		
End case 


If (($crlf) & ($tagResult#""))
	If (FJ_Trim($tagResult)#"")
		$tagResult:=$tagResult+CRLF
	End if 
	
End if 


