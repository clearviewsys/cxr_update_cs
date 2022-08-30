//%attributes = {}

//sl_requestManySanctionChecks($name : Text; $isEntity : Boolean; \
$logId : Object; $options : Object)->$results : Collection
// Author: Wai-Kin
var $name; $1 : Text
var $isEntity; $2 : Boolean
var $logId; $3 : Object
var $options; $4 : Object
var $results; $0 : Collection
Case of 
	: (Count parameters:C259=4)
		$name:=$1
		$isEntity:=$2
		$logId:=$3
		$options:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_OBJECT:C1216($defaults)
$defaults:=New object:C1471(\
"showInterface"; True:C214; \
"list"; ""; \
"isAuto"; False:C215; \
"autoList"; ""; \
"pepHandler"; Formula:C1597(True:C214); \
"listHandler"; Formula:C1597(True:C214); \
"ranHandler"; Formula:C1597(True:C214); \
"matchType"; ""\
)
$options:=utils_setupObjectProperties($defaults; $options)

C_BOOLEAN:C305($progress)
If (OB Is defined:C1231($options; "showInterface"))
	$progress:=$options.showInterface
Else 
	$progress:=True:C214
End if 

C_BOOLEAN:C305($progressBar)
If (Value type:C1509($progress)=Is boolean:K8:9)
	$progressBar:=$progress
Else 
	$progressBar:=True:C214
End if 

$results:=New collection:C1472

var $searchLists : cs:C1710.SanctionCheckLogSelection
Case of 
	: ($options.list#"")
		$searchLists:=ds:C1482.SanctionLists.query("ShortName = :1 and IsEnabled = true"; $options.list)
		
	: (($options.autoList#"") & ($options.isAuto))
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true")
		C_LONGINT:C283($value)
		C_OBJECT:C1216($remove)
		$remove:=ds:C1482.SanctionLists.newSelection()
		var $entity : cs:C1710.SanctionCheckLogEntity
		For each ($entity; $searchLists)
			If ($entity.isManual)
				C_LONGINT:C283($flags)
				$flags:=$entity.automaticFlags
				If (Not:C34(slold_setOrGetSanctionFlag(->$flags; $options.autoList)))
					
					$searchLists:=$searchLists.minus($entity)
				End if 
			End if 
		End for each 
		
	: ($options.isAuto)
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true & isManual = false")
		
	Else 
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true")
End case 

C_BOOLEAN:C305($requestListContinue)
$requestListContinue:=True:C214
If ($progressBar)
	C_REAL:C285($requestListCount; $requestListTotal)
	$requestListCount:=0
	$requestListTotal:=$searchLists.length
	C_LONGINT:C283($requestListProgress)
	$requestListProgress:=Progress New
	Progress SET WINDOW VISIBLE(True:C214)
	Progress SET PROGRESS($requestListProgress; 0)
	Progress SET MESSAGE($requestListProgress; "Completed 0 of "+String:C10($requestListTotal))
	Progress SET BUTTON ENABLED($requestListProgress; True:C214)
End if 

C_OBJECT:C1216($searchList)
For each ($searchList; $searchLists) While ($requestListContinue)
	If ($progressBar)
		C_REAL:C285($requestListPrecent)
		$requestListPrecent:=$requestListCount/$requestListTotal
		Progress SET TITLE($requestListProgress; "Checking on sanction list: "+$searchList.ShortName)
		Progress SET PROGRESS($requestListProgress; $requestListPrecent)
		Progress SET MESSAGE($requestListProgress; "Completed "+String:C10($requestListCount)+" of "+String:C10($requestListTotal))
		$requestListCount:=$requestListCount+1
		//DELAY PROCESS(Current process;40)
		$requestListContinue:=Not:C34(Progress Stopped($requestListProgress))
	End if 
	
	var $result : Object
	
	$result:=slold_requestAndLogSanction($name; $isEntity; $searchList; $logId; $options)
	
	If ($result.entity.CheckResult#0)
		If ($searchList.isPEP)
			$options.pepHandler($result.entity; $searchList)
		Else 
			$options.listHandler($result.entity; $searchList)
		End if 
	End if 
	$options.ranHandler($result.entity; $searchList)
	
	$results.push($result)
	
End for each 

If ($progressBar)
	Progress SET WINDOW VISIBLE(False:C215)
	Progress QUIT($requestListProgress)
End if   // $progressBar

$0:=$results