//%attributes = {}
/* Display the filtered matches in the list box

#param $form
       the form object created through sl_setupDisplayListBox
#param $reload
       force a reload?      
#param $resultObjectNameParam
       the name of list box
#formEvents ON LOAD, ON OUTSIDE CALL
#author @wai-kin
#see sl_fillSanctionDisplayOptions
*/
#DECLARE($formParam : Object; $reloadParam : Boolean; $resultObjectNameParam : Text)

// MARK:- Parameter Setup
var $form : Object
var $reload : Boolean
var $resultObjectName : Text
$form:=Form:C1466
$reload:=(Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11)

Case of 
	: (Count parameters:C259=0)
	: (Count parameters:C259=1)
		$form:=$formParam
	: (Count parameters:C259=2)
		$form:=$formParam
		$reload:=$reloadParam
	: (Count parameters:C259=3)
		$form:=$formParam
		$reload:=$reloadParam
		$resultObjectName:=$resultObjectNameParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($resultObjectName="")
	$resultObjectName:=$form.resultObjectName
End if 

C_POINTER:C301($listboxPtr)
$listboxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; $resultObjectName)

C_OBJECT:C1216($display)
$display:=$form.display

// Only need $arrColVars, ignores rest
ARRAY TEXT:C222($arrColNames; 0)
ARRAY TEXT:C222($arrHeaderNames; 0)
ARRAY POINTER:C280($arrColVars; 0)
ARRAY POINTER:C280($arrHeaderVars; 0)
ARRAY TEXT:C222($arrHeaderNames; 0)
ARRAY BOOLEAN:C223($arrColsVisible; 0)
ARRAY POINTER:C280($arrStyles; 0)
LISTBOX GET ARRAYS:C832($listboxPtr->; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrColsVisible; $arrStyles)

// MARK:- Must do at ON LOAD event
C_BOOLEAN:C305($update)
$update:=(Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11)
If ($update)
	ARRAY POINTER:C280($arrHiearchy; 3)
	$arrHiearchy{1}:=$arrColVars{1}
	$arrHiearchy{2}:=$arrColVars{2}
	$arrHiearchy{3}:=$arrColVars{3}
	LISTBOX SET HIERARCHY:C1098($listboxPtr->; True:C214; $arrHiearchy)
Else 
	$update:=$reload
End if 

// MARK:- Clear lists
If ($update)
	ARRAY TEXT:C222($arrColVars{1}->; 0)
	ARRAY TEXT:C222($arrColVars{2}->; 0)
	ARRAY TEXT:C222($arrColVars{3}->; 0)
	ARRAY TEXT:C222($arrColVars{4}->; 0)
End if 

If ($update)
	ARRAY REAL:C219($rowColour; 0)
	ARRAY REAL:C219($rowStyle; 0)
	C_OBJECT:C1216($list)
	For each ($list; $form.lists)
		// MARK:- Show this list?
		C_BOOLEAN:C305($showList)
		Case of 
			: ($display.lists.count()=0)
				$showList:=True:C214  // default/no list selected
			: ($display.lists.indexOf($list.name)>-1)
				$showList:=True:C214  // in selected list
			Else 
				$showList:=False:C215  // not in selected list
		End case 
		
		If ($showList)
			// JSON for $repeat: 
			//     {"name1":12,"name2":-123, ...}
			// Where the key is the full name or "[Unknown]" and
			//       the field is for these purposes
			//        - positive number = num of times the extra name repeated
			//        - negative number = first occurance of a name at index (num * -1) - 1
			// If the key isn't define = no occurance of the name
			C_OBJECT:C1216($repeats; $item)
			$repeats:=New object:C1471
			For each ($item; $list.items)
				
				// MARK:- is the item has the right match type
				C_BOOLEAN:C305($showItem)
				Case of 
					: ($display.matches="A")
						$showItem:=True:C214
					: ($display.matches="E")
						$showItem:=$item.type="EXACT"
					: ($display.matches="S")
						$showItem:=$item.type="SIMILAR"
				End case 
				
				// MARK:- Set Name list
				If ($showItem)
					// No blacklist name
					C_TEXT:C284($entityName; $displayName)
					If (OB Is defined:C1231($item; "fullname"))
						$entityName:=$item.fullname
					Else 
						$entityName:="[Unknown]"
					End if 
					
					// MARK:- Set the name and 
					
					// Check for repeated names
					If (OB Is defined:C1231($repeats; $entityName))
						C_REAL:C285($index)
						$index:=OB Get:C1224($repeats; $entityName)
						If ($index<=0)
							// First time repeats, add 1 to the first match
							$index:=($index*-1)+1
							While (Size of array:C274($arrColVars{2}->)>$index)
								If ($arrColVars{2}->{$index}=$entityName)
									$arrColVars{2}->{$index}:=$entityName+"\t(1)"
									$index:=$index+1
								Else 
									$index:=Size of array:C274($arrColVars{2}->)  // Break
								End if 
							End while 
							// update $repeats count
							$index:=2
							OB SET:C1220($repeats; $entityName; 2)
						Else 
							// mulitple repeated names
							OB SET:C1220($repeats; $entityName; $index+1)
						End if 
						
						// Set the display name
						$displayName:=$entityName+"\t("+String:C10($index)+")"
					Else 
						$displayName:=$entityName
						
						// First occurance, remember the (line * -1)
						OB SET:C1220($repeats; $entityName; Size of array:C274($arrColVars{2}->)*-1)
					End if 
					
					C_OBJECT:C1216($property)
					For each ($property; $item.properties)
						// check if search is allow or not
						C_BOOLEAN:C305($showProperty)
						$showProperty:=$display.searchTerm=""
						If (Not:C34($showProperty) & $display.searchFields)
							$showProperty:=Position:C15($display.searchTerm; $property.key)>0
						End if 
						If (Not:C34($showProperty) & $display.searchValues)
							$showProperty:=Position:C15($display.searchTerm; $property.value)>0
						End if 
						
						// display the property
						If ($showProperty)
							APPEND TO ARRAY:C911($arrColVars{1}->; $list.name)
							APPEND TO ARRAY:C911($arrColVars{2}->; $displayName)
							APPEND TO ARRAY:C911($arrColVars{3}->; $property.key)
							APPEND TO ARRAY:C911($arrColVars{4}->; $property.value)
							APPEND TO ARRAY:C911($rowColour; $property.color)
							APPEND TO ARRAY:C911($rowStyle; $property.style)
						End if 
					End for each 
				End if 
			End for each 
		End if 
	End for each 
	
	
	// Sort first before styling the rows!!!
	MULTI SORT ARRAY:C718($arrColVars{1}->; >; $arrColVars{2}->; >; $arrColVars{3}->; $arrColVars{4}->; $rowColour; $rowStyle)
	
	For ($index; 1; Size of array:C274($rowColour))
		LISTBOX SET ROW COLOR:C1270($listboxPtr->; $index; $rowColour{$index})
		LISTBOX SET ROW FONT STYLE:C1268($listboxPtr->; $index; $rowStyle{$index})
	End for 
End if 

$0:=$display