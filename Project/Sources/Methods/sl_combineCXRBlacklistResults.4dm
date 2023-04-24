//%attributes = {}
#DECLARE($selectionParam : Collection; $progressBarParam : Integer; $totalParam : Integer)->$form : Object
// MARK:- Parameter Check
var $selection : Collection
var $progressBar; $total : Integer
Case of 
	: (Count parameters:C259=0)
		$selection:=New collection:C1472
		$progressBar:=Progress New
		Progress SET WINDOW VISIBLE(True:C214)
		$total:=$selection.length
	: (Count parameters:C259=1)
		$selection:=$selectionParam
		$progressBar:=Progress New
		Progress SET WINDOW VISIBLE(True:C214)
		$total:=$selection.length
	: (Count parameters:C259=3)
		$selection:=$selectionParam
		$progressBar:=$progressBarParam
		$total:=$totalParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// MARK: Initial Setup to show progress
var $progressContinue : Boolean
var $count : Integer
$progressContinue:=True:C214
$count:=$total-$selection.length
Progress SET WINDOW VISIBLE(True:C214)
Progress SET PROGRESS($progressBar; 0)
Progress SET BUTTON ENABLED($progressBar; True:C214)

// MARK: Basic setup for displaying JSON
$form:=New object:C1471(\
"lists"; New collection:C1472; \
"display"; sl_createResultFilterOptions; \
"search"; New object:C1471; \
"searchFields"; 1; \
"searchValues"; 1; \
"showAllMatches"; 1; \
"searchPlaceHolder"; ""; \
"resultStatus"; 0; \
"resultObjectName"; "SanctionList"; \
"searchObjectName"; "SearchList"; \
"selectedLists"; New collection:C1472\
)

// MARK:- 
var $entity : cs:C1710.SanctionCheckLogEntity

For each ($entity; $selection) While ($progressContinue)
	// MARK: Update progress bar
	Progress SET TITLE($progressBar; "Loading on sanction list: "+$entity.SanctionList)
	Progress SET PROGRESS($progressBar; $count/$total)
	Progress SET MESSAGE($progressBar; "Formatting "+$entity.SanctionList)
	$count:=$count+1
	//DELAY PROCESS(Current process;40)
	$progressContinue:=Not:C34(Progress Stopped($progressBar))
	
	// MARK: Setup result of entity
	ASSERT:C1129($entity.ResponseJSON#Null:C1517)
	
	C_OBJECT:C1216($matches)
	$matches:=$entity.ResponseJSON
	
	C_OBJECT:C1216($formSanction)
	$formSanction:=New object:C1471
	$form.lists.push($formSanction)
	$formSanction.name:=$entity.SanctionList
	
	Case of 
		: ($entity.CheckResult=-1)
			// MARK: Server Error
			$formSanction.status:=$entity.CheckResult
			$formSanction.type:="ERROR"
			$formSanction.emoji:="⚠"
			$formSanction.message:=$entity.ResponseText
			$formSanction.items:=New collection:C1472
			This:C1470._updateStatus(-1)
			continue
			
		: ($entity.CheckResult=0)
			// MARK: No matches
			$formSanction.status:=$entity.CheckResult
			$formSanction.type:="GOOD"
			$formSanction.emoji:="✔"
			$formSanction.message:=$entity.ResponseText
			$formSanction.items:=New collection:C1472
			continue
	End case 
	
	//MARK: Exact or Similiar Name matches 
	C_COLLECTION:C1488($formMatches)
	$formMatches:=New collection:C1472
	$formSanction.status:=$entity.CheckResult
	$formSanction.type:="MATCHED"
	If ($entity.CheckResult=2)
		$formSanction.emoji:="❌"
	Else 
		$formSanction.emoji:="❗"
	End if 
	If (This:C1470#Null:C1517)
		This:C1470._updateStatus($entity.CheckResult)
	End if 
	$formSanction.message:=$entity.ResponseText
	$formSanction.items:=$formMatches
	
	// MARK: Setup match reformat progress
	var $loadItemContinue : Boolean
	$loadItemContinue:=True:C214
	C_LONGINT:C283($loadItemCount; $loadItemTotal; $loadItemProgress)
	$loadItemCount:=0
	$loadItemTotal:=$entity.ResponseJSON.Blacklist.count()
	$loadItemProgress:=Progress New
	Progress SET TITLE($loadItemProgress; "Format and checking list")
	Progress SET BUTTON ENABLED($loadItemProgress; True:C214)
	
	C_OBJECT:C1216($item)
	For each ($item; $entity.ResponseJSON.Blacklist) While ($loadItemContinue)  // For lists.items
		// MARK: Update match progress
		C_REAL:C285($loadItemsPrecentage)
		$loadItemsPrecentage:=$loadItemCount/$loadItemTotal
		Progress SET PROGRESS($loadItemProgress; $loadItemsPrecentage)
		$loadItemsPrecentage:=$loadItemsPrecentage*100
		Progress SET MESSAGE($loadItemProgress; "Checking entity: "+String:C10($loadItemsPrecentage; "##0.00")+"%")
		//DELAY PROCESS(Current process;20) // For progress bar checking
		$loadItemCount:=$loadItemCount+1
		$loadItemContinue:=Not:C34(Progress Stopped($loadItemProgress))
		
		
		// MARK:- Load each match
		C_OBJECT:C1216($formItem)
		$formItem:=New object:C1471("properties"; New collection:C1472)
		$formMatches.push($formItem)
		
		C_TEXT:C284($value; $property)
		For each ($property; $item)
			If (OB Get type:C1230($item; $property)=Is text:K8:3)
				$value:=OB Get:C1224($item; $property)
				C_OBJECT:C1216($formItemProp)
				
				If ($property="OtherInfo")
					// MARK: Split OtherInfo into key-value pairs
					C_OBJECT:C1216($child)
					C_TEXT:C284($childProp)
					$child:=splitTextToObject($value; ": "; ", \n")
					For each ($childProp; $child)
						$formItemProp:=New object:C1471
						$formItemProp.key:=$childProp
						$formItemProp.value:=OB Get:C1224($child; $childProp)
						$formItemProp.style:=Plain:K14:1
						$formItemProp.color:=lk inherited:K53:26
						$formItem.properties.push($formItemProp)
					End for each   //($childProp;$child)
					
				Else   // ($property#"OtherInfo")
					If ($value#"")
						// MARK: add only if value has something in it
						$formItemProp:=New object:C1471
						$formItemProp.key:=$property
						$formItemProp.value:=$value
						$formItemProp.style:=Plain:K14:1
						
						// MARK: Add format for list box
						Case of 
								// mics info
							: ($property="ListId")
								$formItemProp.color:=0x00808080
							: ($property="ListName")
								$formItemProp.color:=0x00808080
							: ($property="Matchtype")
								$formItemProp.color:=0x00808080
								// For type property
								Case of 
									: (Position:C15("EXACT"; $value)>0)
										$formItem.type:="EXACT"
									: (Position:C15("SIMILAR"; $value)>0)
										$formItem.type:="SIMILAR"
								End case   // "Matchtype".value
								
								// bold full name
							: ($property="Fullname")
								$formItemProp.style:=Bold:K14:2
								$formItemProp.color:=0x0000
								$formItem.fullname:=$value
								
								// other fields
							Else   // $propery="@"
								$formItemProp.style:=Plain:K14:1
								$formItemProp.color:=lk inherited:K53:26
						End case   // $property
						
						$formItem.properties.push($formItemProp)
					End if   //$value#""
				End if   // ($property="OtherInfo")
			End if   // OB get type
		End for each   // ($property;$item)
	End for each 
	
	// MARK: Shut down progress bars
	Progress QUIT($loadItemProgress)
	
End for each 

If (Count parameters:C259=1)
	Progress QUIT($progressBar)
	Progress SET WINDOW VISIBLE(False:C215)
End if 