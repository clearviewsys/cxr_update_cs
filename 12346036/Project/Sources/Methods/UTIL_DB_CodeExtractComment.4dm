//%attributes = {}
// ----------------------------------------------------
// User name (OS): truegold
// Date and time: 04/05/19, 09:21:38
// ----------------------------------------------------
// Method: UT_DB_CodeExtractComment
// Description
//  UT_DB_CodeExtractComment - modified by Bob Miller from code originally written by Nigel Greenlee
//Originally named CORE_DB_CodeExtractComment
//Called by Util_ParseButtonCommand and Util_StringCompilerToText to remove metadata from the method
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($u190409)
C_TEXT:C284($_t_MethodText; $0; $t_Header; $t_SubHeader)
C_LONGINT:C283($l_Position)

$_t_MethodText:=""

If (Count parameters:C259>=1)
	$_t_MethodText:=$1
	$t_Header:="//%attributes = {"+Char:C90(34)+"lang"+Char:C90(34)+":"+Char:C90(34)+"en"+Char:C90(34)+"}"
	$l_Position:=Position:C15($t_Header; $_t_MethodText)
	If ($l_Position>0)  //1
		$_t_MethodText:=Substring:C12($_t_MethodText; $l_Position+Length:C16($t_Header))
	Else 
		//in V14 this comment may have the folder..
		$t_Header:="//%attributes = {"
		$l_Position:=Position:C15($t_Header; $_t_MethodText)
		If ($l_Position>0)  //2
			$_t_MethodText:=Substring:C12($_t_MethodText; $l_Position+Length:C16($t_Header))
			$l_Position:=Position:C15("}"; $_t_MethodText)
			$_t_MethodText:=Substring:C12($_t_MethodText; $l_Position+1)
			
		End if   //$l_Position>0 #2
	End if   //$l_Position>0 #1
	
	//this might seem a bit odd-the number of • before the  comment text seems to vary so we have to look for different variants.
	$t_SubHeader:="comment added and reserved by 4D.\r"
	$l_Position:=Position:C15($t_SubHeader; $_t_MethodText)
	If ($l_Position>0)
		$_t_MethodText:=Substring:C12($_t_MethodText; $l_Position+Length:C16($t_SubHeader))
	End if 
	
	$t_SubHeader:="•••comment added and reserved by 4D.•••\r"
	$l_Position:=Position:C15($t_SubHeader; $_t_MethodText)
	If ($l_Position>1)
		$_t_MethodText:=Replace string:C233($_t_MethodText; "•••comment added and reserved by 4D.•••\r"; "")
	End if 
	
	If ($l_Position=1)
		$_t_MethodText:=Substring:C12($_t_MethodText; $l_Position+Length:C16($t_SubHeader))
	End if 
	
	
	$l_Position:=Position:C15($t_SubHeader; $_t_MethodText)
	If ($l_Position>1)
		$_t_MethodText:=Replace string:C233($_t_MethodText; "••comment added and reserved by 4D.••\r"; "")
	End if 
	
	If ($l_Position=1)
		$_t_MethodText:=Substring:C12($_t_MethodText; $l_Position+Length:C16($t_SubHeader))
	End if 
	
	$l_Position:=Position:C15($t_SubHeader; $_t_MethodText)
	If ($l_Position>1)
		$_t_MethodText:=Replace string:C233($_t_MethodText; "•comment added and reserved by 4D.•\r"; "")
	End if 
	
	If ($l_Position=1)
		$_t_MethodText:=Substring:C12($_t_MethodText; $l_Position+Length:C16($t_SubHeader))
	End if 
End if 
$0:=$_t_MethodText
// // Replaced #v15 2/19/2016 was DISABLE BUTT_N // Replaced #v15 2/19/2016 was DISABLE BUTT_N // Replaced #v15 2/19/2016 was DISABLE BUTT_N
