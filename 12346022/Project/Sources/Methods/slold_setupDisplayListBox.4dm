//%attributes = {}
/** Combine the CXRBlacklist selection into a object.

#param $selectionParam
the CXRBlacklist SanctionCheckLog records
#param $interfaceParam
use progress bar?
#return
a form object for SanctionList
#author @Wai-Kin
*/
#DECLARE($selectionParam : cs:C1710.SanctionCheckLogSelection; $interfaceParam : Boolean)->$form : Object

// MARK:- Setup parameters
var $selection : cs:C1710.SanctionCheckLogSelection
var $interface : Boolean
var $form : Object

$interface:=True:C214
Case of 
	: (Count parameters:C259=1)
		$selection:=$selectionParam
	: (Count parameters:C259=2)
		$selection:=$selectionParam
		$interface:=$interfaceParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// MARKS:- Form properties preset
var $entity : cs:C1710.SanctionCheckLog
$entity:=$selection.first()
$form:=New object:C1471(\
"lists"; New collection:C1472; \
"name"; $entity.FullName; \
"isEntity"; $entity.isEntity; \
"result"; ""; \
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
/* $form.result and $form.resultStatus will be updated
$form.list is filled with $fromSanction objects; which has the following properties
- status: real
- type: text
- emoji: Text
- message: Text
- item: Collection, which in turn contains objects with the following properties
- type: Text (SIMILAR or EXACT)
- properties: Collection contains object with the following properties
- key; value : Text
- style, color: Interger
*/


C_BOOLEAN:C305($progressBar)
If (Count parameters:C259=2)
	$progressBar:=$interface
Else 
	$progressBar:=True:C214
End if 

C_BOOLEAN:C305($loadListContinue)
$loadListContinue:=True:C214
If ($progressBar)
	C_REAL:C285($loadListCount; $loadListTotal)
	$loadListCount:=0
	$loadListTotal:=$selection.length
	C_LONGINT:C283($loadListProgress)
	$loadListProgress:=Progress New
	Progress SET WINDOW VISIBLE(True:C214)
	Progress SET PROGRESS($loadListProgress; 0)
	Progress SET MESSAGE($loadListProgress; "Completed 0 of "+String:C10($loadListTotal))
	Progress SET BUTTON ENABLED($loadListProgress; True:C214)
End if 

For each ($entity; $selection) While ($loadListContinue)
	// MARK:- Turn [SanctionCheckLog] into an object
	If ($progressBar)
		C_REAL:C285($loadListPrecent)
		$loadListPrecent:=$loadListCount/$loadListTotal
		Progress SET TITLE($loadListProgress; "Loading on sanction list: "+$entity.SanctionList)
		Progress SET PROGRESS($loadListProgress; $loadListPrecent)
		Progress SET MESSAGE($loadListProgress; "Completed "+String:C10($loadListCount)+" of "+String:C10($loadListTotal))
		$loadListCount:=$loadListCount+1
		//DELAY PROCESS(Current process;40)
		$loadListContinue:=Not:C34(Progress Stopped($loadListProgress))
	End if 
	
	C_BOOLEAN:C305($continue)
	If ($entity.ResponseJSON#Null:C1517)
		
		C_OBJECT:C1216($matches)
		$matches:=$entity.ResponseJSON
		
		C_OBJECT:C1216($formSanction)
		$formSanction:=New object:C1471
		$form.lists.push($formSanction)
		$formSanction.name:=$entity.SanctionList
		Case of 
			: ($entity.CheckResult=-1)
				$formSanction.status:=$entity.CheckResult
				$formSanction.type:="ERROR"
				$formSanction.emoji:="⚠"
				$formSanction.message:=$entity.ResponseText
				$formSanction.items:=New collection:C1472
				$form.result:="Some sanction lists matching failed to complete."
				$form.resultStatus:=-1
				
			: ($entity.CheckResult=0)
				$formSanction.status:=$entity.CheckResult
				$formSanction.type:="GOOD"
				$formSanction.emoji:="✔"
				$formSanction.message:=$entity.ResponseText
				$formSanction.items:=New collection:C1472
				
			Else   // ($entity.CheckResult=?)
				C_COLLECTION:C1488($formMatches)
				$formMatches:=New collection:C1472
				$formSanction.status:=$entity.CheckResult
				$formSanction.type:="MATCHED"
				If ($entity.CheckResult=2)
					$formSanction.emoji:="❌"
				Else 
					$formSanction.emoji:="❗"
				End if 
				$formSanction.message:=$entity.ResponseText
				$formSanction.items:=$formMatches
				
				If ($progressBar)
					C_LONGINT:C283($loadItemCount; $loadItemTotal; $loadItemProgress)
					$loadItemCount:=0
					$loadItemTotal:=$entity.ResponseJSON.Blacklist.count()
					$loadItemProgress:=Progress New
					Progress SET TITLE($loadItemProgress; "Format and checking list")
					Progress SET BUTTON ENABLED($loadItemProgress; True:C214)
				End if   // $progrssBar
				
				C_BOOLEAN:C305($loadItemContinue)
				$loadItemContinue:=True:C214
				
				C_OBJECT:C1216($item)
				For each ($item; $entity.ResponseJSON.Blacklist) While ($loadItemContinue)  // For lists.items
					If ($progressBar)
						C_REAL:C285($loadItemsPrecentage)
						$loadItemsPrecentage:=$loadItemCount/$loadItemTotal
						Progress SET PROGRESS($loadItemProgress; $loadItemsPrecentage)
						$loadItemsPrecentage:=$loadItemsPrecentage*100
						Progress SET MESSAGE($loadItemProgress; "Checking entity: "+String:C10($loadItemsPrecentage; "##0.00")+"%")
						//DELAY PROCESS(Current process;20) // For progress bar checking
						$loadItemCount:=$loadItemCount+1
						
						$loadItemContinue:=Not:C34(Progress Stopped($loadItemProgress))
					End if   // $progressBar
					
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
				
				// MARK:- Finish touches for saction list result
				
				If ($form.result="")
					$form.result:="One or more matches are found in the sanction lists."
				End if   // $form.result
				
				$form.resultStatus:=sl_updateDisplayingLogStatus($form.resultStatus; $entity.CheckResult)
				
				C_LONGINT:C283($loadItemProgress)
				If ($progressBar)
					Progress QUIT($loadItemProgress)
				End if   // $progressBar
				
		End case 
	End if 
End for each 

If ($progressBar)
	Progress QUIT($loadListProgress)
	Progress SET WINDOW VISIBLE(False:C215)
End if 