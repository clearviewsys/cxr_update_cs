//%attributes = {}

C_OBJECT:C1216($0; $data)
C_TEXT:C284($1; $param1)
C_LONGINT:C283($2; $param2)
C_OBJECT:C1216($3; $data)
Case of 
	: (Count parameters:C259=2)
		$param1:=$1
		$param2:=$2
		$data:=Null:C1517
	: (Count parameters:C259=3)
		$param1:=$1
		$param2:=$2
		$data:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BOOLEAN:C305($progressBar)
$progressBar:=False:C215

// #ORDA
C_COLLECTION:C1488($results)
C_TEXT:C284($query; $name)
C_OBJECT:C1216($selection)
C_BOOLEAN:C305($isEntity)
$selection:=Null:C1517
$query:="ResponseJSON # null and internalTableID = :1 and InternalRecordID = :2"
Case of 
	: ($data=Null:C1517)
		$selection:=ds:C1482.SanctionCheckLog.query($query; $param2; $param1)
		
	: (OB Is defined:C1231($data; "sanctionList"))
		$query:=$query+" and SanctionList = :3"
		$selection:=ds:C1482.SanctionCheckLog($query; $param2; $param1; $data.sanctionList)
		
	: (OB Is defined:C1231($data; "results"))
		$name:=$1
		$isEntity:=$param2=2
		$results:=$data.results
	: (OB Is defined:C1231($data; "result"))
		$name:=$1
		$isEntity:=$param2=2
		$results:=New collection:C1472($data.result)
	Else 
		ASSERT:C1129(False:C215; "Unacceptable JSON:"+JSON Stringify:C1217($data))
End case 

// Convert selection to results
If ($selection#Null:C1517)
	$name:=$selection[0].FullName
	$isEntity:=$selection[0].isEntity
	
	$selection:=$selection.orderBy("SanctionList, CheckDate desc, CheckTime desc")
	C_OBJECT:C1216($use)
	$use:=ds:C1482.SanctionCheckLog.newSelection()
	C_TEXT:C284($listName)
	C_OBJECT:C1216($entity)
	For each ($entity; $selection)
		If ($entity.SanctionList#$listName)
			$use:=$use.add($entity)
		End if 
		$listName:=$entity.SanctionList
	End for each 
	$results:=$use.toCollection("ResponseJSON,SanctionList,CheckResult,ResponseText")
End if 

// Set up form
C_OBJECT:C1216($form)
$form:=New object:C1471
$form.lists:=New collection:C1472
$form.name:=$name
$form.isEntity:=$isEntity
$form.result:=""

// Progress bar for the lists

C_BOOLEAN:C305($loadListContinue)
$loadListContinue:=True:C214
If ($progressBar)
	C_REAL:C285($loadListCount; $loadListTotal)
	$loadListCount:=0
	$loadListTotal:=$results.length
	C_LONGINT:C283($loadListProgress)
	$loadListProgress:=Progress New
	Progress SET WINDOW VISIBLE(True:C214)
	Progress SET PROGRESS($loadListProgress; 0)
	Progress SET MESSAGE($loadListProgress; "Completed 0 of "+String:C10($loadListTotal))
	Progress SET BUTTON ENABLED($loadListProgress; True:C214)
End if 

C_OBJECT:C1216($result)
For each ($result; $results) While ($loadListContinue)
	If ($progressBar)
		C_REAL:C285($loadListPrecent)
		$loadListPrecent:=$loadListCount/$loadListTotal
		Progress SET TITLE($loadListProgress; "Loading on sanction list: "+$result.SanctionList)
		Progress SET PROGRESS($loadListProgress; $loadListPrecent)
		Progress SET MESSAGE($loadListProgress; "Completed "+String:C10($loadListCount)+" of "+String:C10($loadListTotal))
		$loadListCount:=$loadListCount+1
		//DELAY PROCESS(Current process;40)
		$loadListContinue:=Not:C34(Progress Stopped($loadListProgress))
	End if 
	C_OBJECT:C1216($matches)
	$matches:=$result.ResponseJSON
	
	C_OBJECT:C1216($formSanction)
	$formSanction:=New object:C1471
	$form.lists.push($formSanction)
	$formSanction.name:=$result.SanctionList
	Case of 
		: ($result.CheckResult=-1)
			$formSanction.status:=$result.CheckResult
			$formSanction.type:="ERROR"
			$formSanction.emoji:="⚠"
			$formSanction.message:=$result.ResponseText
			$formSanction.items:=New collection:C1472
			$form.result:="Some sanction lists matching failed to complete."
			
		: ($result.CheckResult=0)
			$formSanction.status:=$result.CheckResult
			$formSanction.type:="GOOD"
			$formSanction.emoji:="✔"
			$formSanction.message:=$result.ResponseText
			$formSanction.items:=New collection:C1472
			
		Else   // ($result.CheckResult=?)
			C_COLLECTION:C1488($formMatches)
			$formMatches:=New collection:C1472
			$formSanction.status:=$result.CheckResult
			$formSanction.type:="MATCHED"
			$formSanction.emoji:="❌"
			$formSanction.message:=$result.ResponseText
			$formSanction.items:=$formMatches
			
			If ($progressBar)
				C_LONGINT:C283($loadItemCount; $loadItemTotal; $loadItemProgress)
				$loadItemCount:=0
				$loadItemTotal:=$result.ResponseJSON.Blacklist.count()
				$loadItemProgress:=Progress New
				Progress SET TITLE($loadItemProgress; "Format and checking list")
				Progress SET BUTTON ENABLED($loadItemProgress; True:C214)
			End if   // $progrssBar
			C_BOOLEAN:C305($loadItemContinue)
			$loadItemContinue:=True:C214
			
			C_OBJECT:C1216($item)
			For each ($item; $result.ResponseJSON.Blacklist) While ($loadItemContinue)  // For lists.items
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
				
				C_OBJECT:C1216($formItem)
				$formItem:=New object:C1471("properties"; New collection:C1472)
				$formMatches.push($formItem)
				
				C_TEXT:C284($value; $property)
				For each ($property; $item)
					If (OB Get type:C1230($item; $property)=Is text:K8:3)
						$value:=OB Get:C1224($item; $property)
						C_OBJECT:C1216($formItemProp)
						
						If ($property="OtherInfo")
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
								$formItemProp:=New object:C1471
								$formItemProp.key:=$property
								$formItemProp.value:=$value
								$formItemProp.style:=Plain:K14:1
								Case of 
									: ($property="ListId")
										$formItemProp.color:=0x00808080
									: ($property="ListName")
										$formItemProp.color:=0x00808080
									: ($property="Matchtype")
										$formItemProp.color:=0x00808080
										Case of 
											: (Position:C15("EXACT"; $value)>0)
												$formItem.type:="EXACT"
											: (Position:C15("SIMILAR"; $value)>0)
												$formItem.type:="SIMILAR"
										End case   // "Matchtype".value
										
									: ($property="Fullname")
										$formItemProp.style:=Bold:K14:2
										$formItemProp.color:=0x0000
										$formItem.fullname:=$value
									Else   // $propery="@"
										$formItemProp.style:=Plain:K14:1
										$formItemProp.color:=lk inherited:K53:26
								End case   // $property
								
								$formItem.properties.push($formItemProp)
							End if   //$value#""
						End if   // ($property="OtherInfo")
					End if   // OB get type
				End for each   // ($property;$item)
				
				If ($form.result="")
					$form.result:="One or more matches are found in the sanction lists."
				End if   // $form.result
			End for each   //($item;$result.ResponseJSON.Blacklist)
			C_LONGINT:C283($loadItemProgress)
			If ($progressBar)
				Progress QUIT($loadItemProgress)
			End if   // $progressBar
			
	End case   // $result.CheckResult
End for each   // ($result;$results)

If ($progressBar)
	Progress SET WINDOW VISIBLE(False:C215)
	Progress QUIT($loadListProgress)
End if   // $progressBar

$0:=$form