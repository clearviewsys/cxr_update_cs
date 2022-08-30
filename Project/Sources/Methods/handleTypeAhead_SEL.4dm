//%attributes = {}
// handleTypeAhead_SEL (self; ->field; placeholder ; allRecords)
// form events: on load; on unload; on before keystroke; on after keystroke
// This method will not change the selection of records in the table

C_TEXT:C284($Keystroke)
C_POINTER:C301($fieldPtr; $tablePtr; $self; $1; $2)
C_TEXT:C284($namedSelection; $placeholder; $3)
C_BOOLEAN:C305($allRecord; $4)

C_LONGINT:C283($fieldNo; $tableNum)
C_TEXT:C284($temp)

$allRecord:=True:C214


Case of 
	: (Count parameters:C259=2)
		$self:=$1
		$fieldPtr:=$2
		$placeholder:=Field name:C257($fieldPtr)
		
	: (Count parameters:C259=3)
		$self:=$1
		$fieldPtr:=$2
		$placeholder:=$3
		
	: (Count parameters:C259=4)
		$self:=$1
		$fieldPtr:=$2
		$placeholder:=$3
		$allRecord:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

RESOLVE POINTER:C394($fieldPtr; $temp; $tableNum; $fieldNo)
$tablePtr:=Table:C252($tableNum)
ASSERT:C1129($tableNum>0; "Cannot resolve pointer to a table")

Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(arrTypeAheadValues; 0)
		READ ONLY:C145($tablePtr->)
		$namedSelection:="$TA_"+Table name:C256($tablePtr)
		
		If ($allRecord)
			COPY NAMED SELECTION:C331($tablePtr->; $namedSelection)  // copy the selection
			ALL RECORDS:C47($tablePtr->)
			SELECTION TO ARRAY:C260($fieldPtr->; arrTypeAheadValues)
			USE NAMED SELECTION:C332($namedSelection)  // restore the selection
			CLEAR NAMED SELECTION:C333($namedSelection)
		Else 
			SELECTION TO ARRAY:C260($fieldPtr->; arrTypeAheadValues)
		End if 
		
		// _O_OBJECT SET COLOR($self->;calcColour(Light grey;White))
		OBJECT SET RGB COLORS:C628($self->; convPalleteColourToRGB(Light grey:K11:13); convPalleteColourToRGB(White:K11:1))
		
		$self->:=$placeholder
		
	: (Form event code:C388=On Before Keystroke:K2:6)
		//_O_OBJECT SET COLOR($self->;calcColour(Black;White))
		OBJECT SET RGB COLORS:C628($self->; convPalleteColourToRGB(Black:K11:16); convPalleteColourToRGB(White:K11:1))
		
		C_LONGINT:C283($i; $n)
		$Keystroke:=Keystroke:C390
		Case of 
			: (Character code:C91($Keystroke)=Backspace:K15:36)
				//FILTER KEYSTROKE($Keystroke)
				$self->:=Substring:C12($self->; 1; Length:C16($self->)-2)
		End case 
		
	: (Form event code:C388=On After Keystroke:K2:26)
		
		C_TEXT:C284($Keystroke; $token)
		C_LONGINT:C283($i; $n)
		$Keystroke:=Keystroke:C390
		$token:=Get edited text:C655
		$i:=Length:C16($token)
		
		If ($i>0)
			SET QUERY LIMIT:C395(1)
			QUERY:C277($tablePtr->; $fieldPtr->=$token+"@")
			SET QUERY LIMIT:C395(0)
		End if 
		
		If (Records in selection:C76($tablePtr->)>0)
			FIRST RECORD:C50($tablePtr->)
			$self->:=$fieldPtr->
			$n:=Length:C16($fieldPtr->)
			HIGHLIGHT TEXT:C210($self->; $i+1; $n+1)
			//_O_OBJECT SET COLOR($self->;calcColour(Black;White))
			OBJECT SET RGB COLORS:C628($self->; convPalleteColourToRGB(Black:K11:16); convPalleteColourToRGB(White:K11:1))
			
			
		Else   // token is not found in the table
			
			HIGHLIGHT TEXT:C210($self->; $i+1; $i+1)
			// _O_OBJECT SET COLOR($self->;calcColour(Red;White))
			OBJECT SET RGB COLORS:C628($self->; convPalleteColourToRGB(Red:K11:4); convPalleteColourToRGB(White:K11:1))
			
		End if 
		
	: (Form event code:C388=On Losing Focus:K2:8)
		If ($self->="")  // when the field is empty restore the placeholder text
			// _O_OBJECT SET COLOR($self->;calcColour(Light grey;White))
			OBJECT SET RGB COLORS:C628($self->; convPalleteColourToRGB(Light grey:K11:13); convPalleteColourToRGB(White:K11:1))
			
			$self->:=$placeholder
		End if 
		
	: (Form event code:C388=On Unload:K2:2)
		ARRAY TEXT:C222(arrTypeAheadValues; 0)
		
End case 

