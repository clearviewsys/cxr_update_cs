Class constructor($resultsParam : Collection)
	
	// MARK: Paramters
	var $results : Collection
	var $entity : Object
	Case of 
		: (Count parameters:C259=1)
			$results:=$resultsParam
		: (Count parameters:C259=0)
			$results:=New collection:C1472
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	
	// MARK: initial report setup
	This:C1470.cxrBlacklistText:=New collection:C1472
	This:C1470.cxrBlacklistJson:=New collection:C1472
	This:C1470.kyc2020:=New collection:C1472
	This:C1470.openSanctions:=New collection:C1472
	This:C1470.localBlackList:=New collection:C1472
	
	var $type : Text
	This:C1470.resultCode:=0
	var $error; $similiar; $match : Integer
	var $pass : Boolean
	$error:=0
	$similiar:=0
	$match:=0
	$pass:=True:C214
	
	For each ($entity; $results)
		// MARK: sort the Sanction Screening Log
		$type:=sl_getSanctionSourceForRecord($entity)
		Case of 
			: ($type=sl_useCXBlacklistText)
				This:C1470.cxrBlacklistText.push($entity)
			: ($type=sl_useCXBlackListJSON)
				This:C1470.cxrBlacklistJson.push($entity)
			: ($type=sl_useKYC2020)
				This:C1470.kyc2020.push($entity)
			: ($type=sl_useOpenSanctions)
				This:C1470.openSanctions.push($entity)
			: ($type=sl_useLocalBlacklist)
				This:C1470.localBlackList.push($entity)
		End case 
		
		// MARK: uses the first entry for general info
		If (Not:C34(OB Is defined:C1231(This:C1470; "name")))
			This:C1470.name:=$entity.FullName
			This:C1470.isEntity:=$entity.isEntity
			This:C1470.dataSent:=$entity.Details.data
		End if 
		
		// MARK: count exact and similar matches
		This:C1470._updateStatus($entity.CheckResult)
		Case of 
			: ($entity.CheckResult=-1)
				$error:=$error+1
				$pass:=False:C215
			: ($entity.CheckResult=1)
				$similiar:=$similiar+1
				$pass:=False:C215
			: ($entity.CheckResult=2)
				$match:=$match+1
				$pass:=False:C215
		End case 
	End for each 
	
	// MARK: saves the result
	If ($pass)
		This:C1470.resultText:="No matches in "+String:C10($results.length)+" lists/PEPs."
	Else 
		This:C1470.resultText:=""
		If ($error>0)
			This:C1470.resultText:=String:C10($error)+" screening errors. "
		End if 
		If ($similiar>0)
			This:C1470.resultText:=This:C1470.resultText+String:C10($similiar)+" list/PEP similar match. "
		End if 
		If ($match>0)
			This:C1470.resultText:=This:C1470.resultText+String:C10($match)+" list/PEP exact matches."
		End if 
	End if 
	
Function displayResults($confirmRejectParam : Boolean)
	
	// MARK: Parameters
	var $confirmReject : Boolean
	Case of 
		: (Count parameters:C259=1)
			$confirmReject:=$confirmRejectParam
		: (Count parameters:C259=0)
			$confirmReject:=False:C215
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	var $entity : cs:C1710.SanctionCheckLogEntity
	
	// MARK: create the form object
	var $summary : Object
	$summary:=New object:C1471("status"; New collection:C1472; "server"; \
		New collection:C1472; "name"; New collection:C1472; "message"; New collection:C1472)
	var $list : Collection
	$list:=New collection:C1472
	
	Progress SET WINDOW VISIBLE(True:C214)
	var $progress : Integer
	$progress:=Progress New
	var $len : Integer
	$len:=This:C1470.kyc2020.length+This:C1470.openSanctions.length+This:C1470.cxrBlacklistJson.length
	Progress SET TITLE($progress; "Format Lists."; 0; ""; True:C214)
	
	// MARK: load and format the KYC2020 results
	For each ($entity; This:C1470.kyc2020)
		Progress SET MESSAGE($progress; "Formatting "+$entity.SanctionList)
		Progress SET PROGRESS($progress; $list.length/$len)
		If ($entity.CheckResult#-1)
			$list.push(sl_formatKYC2020Result($entity))
		Else 
			$list.push(Null:C1517)
		End if 
		This:C1470._addResult($summary; $entity; sl_useKYC2020)
	End for each 
	
	// MARK: load and format Open Sanction results
	For each ($entity; This:C1470.openSanctions)
		Progress SET MESSAGE($progress; "Formatting "+$entity.SanctionList)
		Progress SET PROGRESS($progress; $list.length/$len)
		If ($entity.CheckResult#-1)
			$list.push(sl_formatOpenSanctionResult($entity))
		Else 
			$list.push(Null:C1517)
		End if 
		This:C1470._addResult($summary; $entity; sl_useOpenSanctions)
	End for each 
	
	For each ($entity; This:C1470.localBlackList)
		Progress SET MESSAGE($progress; "Formatting "+$entity.SanctionList)
		Progress SET PROGRESS($progress; $list.length/$len)
		$list.push(sl_formatLocalBlacklistResult($entity))
		This:C1470._addResult($summary; $entity; sl_useLocalBlacklist)
	End for each 
	
	
	// MARK: load CXR Blacklist JSON results
	For each ($entity; This:C1470.cxrBlacklistJson)
		This:C1470._addResult($summary; $entity; "CXR Blacklist v2.0")
	End for each 
	
	// MARK: don't display if there is nothing logged
	If ($summary.name.length=0)
		Progress QUIT($progress)
		Progress SET WINDOW VISIBLE(False:C215)
		return 
	End if 
	
	// MARK: create the form object
	var $form : Object
	$form:=New object:C1471("summary"; $summary; \
		"cxrBlacklistJson"; sl_combineCXRBlacklistResults(This:C1470.cxrBlacklistJson; \
		$progress; $len); \
		"lists"; $list; \
		"title"; (This:C1470.isEntity ? "Entity" : "Person")+" Matches for "+This:C1470.name; \
		"checkName"; This:C1470.name; "data"; This:C1470.dataSent; \
		"isEntity"; This:C1470.isEnity; \
		"display"; Null:C1517)
	
	Progress QUIT($progress)
	Progress SET WINDOW VISIBLE(False:C215)
	
	// MARK: display the form and ask for confirm if required
	C_LONGINT:C283($winref)
	$winref:=Open form window:C675("SanctionSceenResult")
	DIALOG:C40("SanctionSceenResult"; $form)
	
	// MARK: Update the results with more info 
	var $updated : Object
	For each ($updated; $form.lists)
		If ($updated.UUID=Null:C1517)
			continue
		End if 
		var $id : Text
		$id:=$updated.UUID
		Case of 
			: ($updated.useServer=sl_useOpenSanctions)
				var $queried : Collection
				$queried:=This:C1470.openSanctions.query("UUID = :1"; $id)
				For each ($entity; $queried)
					This:C1470._updateOpenSanctions($entity; $updated)
				End for each 
				
			: ($updated.useServer=sl_useKYC2020)
				For each ($entity; This:C1470.kyc2020)
				End for each 
		End case 
	End for each 
	
	
	If ($confirmReject && (This:C1470.resultCode#0))
		myConfirm("Sanction check produces a match. Do you want to fix the issue?"; \
			"Ignore and continue"; "Return and Edit")
		If (OK#1)
			REJECT:C38
		End if 
	End if 
	
Function _addResult($summary : Object; $entity : cs:C1710.SanctionCheckLogEntity; \
$name : Text)
	$summary.status.push(sl_setEmojiStatusIcon($entity.CheckResult))
	$summary.server.push($name)
	$summary.name.push(This:C1470._getListName($entity))
	$summary.message.push($entity.ResponseText)
	
Function _getListName($entity : cs:C1710.SanctionCheckLogEntity)->$name : Text
	var $list : cs:C1710.SanctionLists
	$list:=ds:C1482.SanctionLists.query("ShortName = :1"; $entity.SanctionList)[0]
	If ($list.Description="")
		return $list.ShortName
	End if 
	$name:=$list.Description+" ("+$list.ShortName+")"
	
Function _updateStatus($latestStatusParam : Real)
	var $latestStatus : Real
	Case of 
		: (Count parameters:C259=1)
			$latestStatus:=$latestStatusParam
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	
	Case of 
		: ((This:C1470.resultCode=-1) | ($latestStatus=-1))
			This:C1470.resultCode:=-1
		: ((This:C1470.resultCode=2) | ($latestStatus=2))
			This:C1470.resultCode:=2
		: ((This:C1470.resultCode=1) || ($latestStatus=1))
			This:C1470.resultCode:=1
		Else 
			This:C1470.resultCode:=0
	End case 
	
Function save()
	var $saveResult : Object
	var $entity : cs:C1710.SanctionCheckLogEntity
	For each ($entity; This:C1470.cxrBlacklistJson)
		sl_saveSanctionListResult($entity)
	End for each 
	
	For each ($entity; This:C1470.cxrBlacklistText)
		sl_saveSanctionListResult($entity)
	End for each 
	
	For each ($entity; This:C1470.kyc2020)
		If (sl_saveSanctionListResult($entity))
			var $tablePtr : Pointer
			var $status : Integer
			var $path : Text
			var $contents; $response : Blob
			$tablePtr:=Table:C252($entity.internalTableID)
			$path:="KYC2020"+$entity.UUID+"Report.pdf"
			
			$status:=HTTP Request:C1158(HTTP GET method:K71:1; $entity.ResponseJSON.summary.diq_summary.pow_url; $contents; $response)
			
			BLOB TO DOCUMENT:C526($path; $response)
			createLinkedDoc($tablePtr; $path)
			[LinkedDocs:4]Description:9:=$entity.ResponseText
			[LinkedDocs:4]TypeOfDoc:5:="pdf"
			SAVE RECORD:C53([LinkedDocs:4])
			relateManyLinkedDocs
		End if 
	End for each 
	
	For each ($entity; This:C1470.openSanctions)
		sl_saveSanctionListResult($entity)
	End for each 
	
	For each ($entity; This:C1470.localBlackList)
		sl_saveSanctionListResult($entity)
	End for each 
	
Function _updateOpenSanctions($entityParam : cs:C1710.SanctionCheckLogEntity; \
$updatedParam : Object)
	var $entity : cs:C1710.SanctionCheckLogEntity
	var $updated : Object
	Case of 
		: (Count parameters:C259=2)
			$entity:=$entityParam
			$updated:=$updatedParam
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	
	If (Not:C34(OB Is defined:C1231($updated; "saving")))
		return 
	End if 
	
	If ($updated.saving.entities.length#0)
		$entity.ResponseJSON.entities:=$updated.saving.entities.copy()
	End if 
	
	
	$entity.ResponseJSON.results.combine($updated.saving.results)