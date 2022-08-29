//%attributes = {}
// parseMethodPath

C_TEXT:C284($1)  // Method path
C_POINTER:C301($2; $3; $4)  // Retun Values


ARRAY TEXT:C222($result; 0)
ARRAY TEXT:C222($arrTableNames; 0)
ARRAY LONGINT:C221($arrTableNums; 0)
C_LONGINT:C283($n; $p)

$n:=Helper_StringTokenizer(->$result; $1; "/")

Case of 
		
	: ($result{1}="[databaseMethod]")  // database Method
		
		$2->:=0  // TableNum
		$3->:=""  // Form Name
		$4->:=""  // Object Name
		
	: ($result{1}="[projectForm]")  //project Form
		
		$2->:=0  // TableNum
		$3->:=$result{2}  // Form Name
		$4->:=$result{3}  // Object Name
		
	: ($result{1}="[tableForm]")  // table Form
		getTables(->$arrTableNums; ->$arrTableNames; True:C214)
		
		$p:=Find in array:C230($arrTableNames; $result{2})
		If ($p>0)
			$2->:=$arrTableNums{$p}
		Else 
			$2->:=-1  // Invalid form
		End if 
		
		$3->:=$result{3}  // Form Name
		$4->:=$result{4}  // Object Name
		
	: ($result{1}="[trigger]")  // trigger
		
		getTables(->$arrTableNums; ->$arrTableNames; True:C214)
		$p:=Find in array:C230($arrTableNames; $result{2})
		If ($p>0)
			$2->:=$arrTableNums{$p}
		Else 
			$2->:=-1  // Invalid form
		End if 
		
		$3->:=""  // Form Name
		$4->:=""  // Object Name
		
	Else   // Project Method
		
		$2->:=0  // TableNum
		$3->:=""  // Form Name
		$4->:=""  // Object Name
		
End case 






