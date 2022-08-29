//%attributes = {}
/* Creates an object for various options in sanction check screening. 

#param $isForcedParam
       is this a manual check
#return
       list of options with default values
*/
#DECLARE($isForcedParam : Boolean)->$options : Object
var $isForced : Boolean
Case of 
	: (Count parameters:C259=0)
		$isForced:=False:C215
	: (Count parameters:C259=1)
		$isForced:=$isForcedParam
End case 

var $resultText : Text

$options:=New object:C1471
$options.options:=New object:C1471()

// ** not used **
$options.options.ignorePEP:=False:C215

/* uses only check if first + last name is filled 
 used in 
*/
$options.options.namePartsFilled:=True:C214

/* if true shows the result interface and progress bar 
used in sl_handlePersonNameCompliance for sl_displaySanctionListResult
used in sl_chooseSanctionServer
used in sl_k20requestSanctionCheck
used in sl_runWorkerProcess
*/
$options.options.interface:=True:C214

/* asks user when the result returns a match
used in sl_handlePersonNameCompliance 
used in sl_handleCompanyNameCompliance
*/
$options.options.comfirmReject:=False:C215

// ** not used **
$options.options.query:=""

/** Manual Sanction list or PEP check, possible options: "PEP", "SL" or "" (empty)
use in sl_pickSanctionCheckLists
*/
$options.options.manualList:=""

/** The list to use, overriding autoList options
use in sl_pickSanctionCheckLists
*/
$options.options.list:=""

/* The type of auto sanction check. See SanctionListFlags list. 
use in sl_pickSanctionCheckLists x2
*/
$options.options.autoList:=""

/** The type of auto sanction check. Replaces `options.autoList`
*/
$options.options.autoType:=sl_NoFlag

/** Run in a worker process?
use in sl_pickSanctionCheckLists
*/
$options.options.useWorker:=False:C215

/** Is this automatic run?
use in sl_pickSanctionCheckLists x2
*/
$options.options.isAuto:=Not:C34($isForced)

/** The match type/ search type (eg. EXACT). See SanctionListMatchType
used in sl_requestAndLogSanctionCheck
*/
$options.options.matchType:=""

/** Use emoji instead of pictures.
used in sl_displaySanctionListResult
*/
$options.options.useEmoji:=False:C215

$options.functions:=New object:C1471

/** Method to called when a pep list matched
Expects a Forumla with \
`This` = limited options list, \
`$1` = SanctionListCheckLog entity,\
and `$2` = SanctionList entity
used in sl_chooseSanctionServer
modified in sl_runWorkerProcess
*/
$options.functions.pepHandler:=Formula:C1597(True:C214)

/** Method to called when a non-pep list matched
Expects a Forumla with \
`This` = limited options list, \
`$1` = SanctionListCheckLog entity,\
and `$2` = SanctionList entity
used in sl_chooseSanctionServer
modified in sl_runWorkerProcess
*/
$options.functions.listHandler:=Formula:C1597(True:C214)

/** Method to called when a list has been checked
Expects a Forumla with \
`This` = limited options list, \
`$1` = SanctionListCheckLog entity,\
and `$2` = SanctionList entity
used in sl_chooseSanctionServer
modified in sl_runWorkerProcess
*/
$options.functions.ranHandler:=Formula:C1597(True:C214)

$options.pointers:=New object:C1471

/** Pointer for icon picture
used in sl_handlePersonNameCompliance for sl_displaySanctionListResult
used in sl_handleCompanyNameCompliance for sl_displaySanctionListResult
*/
$options.pointers.resultIconPtr:=->latestCheckStatus1
/** Pointer for text result
used in sl_handlePersonNameCompliance for sl_displaySanctionListResult
used in sl_handleCompanyNameCompliance for sl_displaySanctionListResult
*/
$options.pointers.resultTextPtr:=->$resultText

/** Pointer use in signal 
used in sl_pickSanctionCheckLists
*/
$options.pointers.signalName:="signal"

/** The key of the sanction check signal
use in sl_pickSanctionCheckLists
*/
$options.pointers.sanctionCheckSignals:="sanctionCheckSignals"

/** Method to call when a list is done
the parameters passed are 
- cs.SanctionCheckLog, 
- cs.SanctionLists, 
- and Object $options

Used in sl_chooseSanctionListServer
*/
$options.pointers.handleDetailMethod:=""

/** options related to KYC2020 
Not used
*/
$options.kyc2020:=New object:C1471
$options.kyc2020.categoryCodeList:="all"
$options.kyc2020.catGroupName:=""
$options.kyc2020.searchThreshold:=""
$options.kyc2020.responseType:=1

/** more data to check with */
$options.data:=New object:C1471
/** 
used in sl_k20requestSanctionCheck
*/
$options.data.address:=""
/** 
used in sl_k20requestSanctionCheck
*/
$options.data.idNumber:=""
/** 
used in sl_k20requestSanctionCheck
*/
$options.data.birthday:=!00-00-00!

$options.workers:=New object:C1471

/* Current Form window
used in sl_chooseSanctionServer
*/
$options.workers.formRef:=Current form window:C827