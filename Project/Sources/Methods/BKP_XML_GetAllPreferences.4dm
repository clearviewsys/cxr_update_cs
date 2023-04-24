//%attributes = {}
// ----------------------------------------------------

// User name (OS): Jonathan Le

// Date and time: 04/02/04, 09:26:04

// ----------------------------------------------------

// Method: BKP_XML_GetAllPreferences

// Description

// 

//

// Parameters

// ----------------------------------------------------

C_TEXT:C284($1)

C_TEXT:C284($tParentElem; $tXPathElem)
$tParentElem:=BKP_XML_GetParentElem
$tXPathElem:=DOM Find XML element:C864($tParentElem; $1)

C_LONGINT:C283($iRet)
ARRAY TEXT:C222(aInfoLabels; 0)
ARRAY TEXT:C222(aInfoValues; 0)

// parse the DOM tree and put values into containers

$iRet:=BKP_XML_GetDatabaseInfo($tXPathElem)
$iRet:=BKP_XML_GetAdvancedSettings($tXPathElem)
$iRet:=BKP_XML_GetGeneralSettings($tXPathElem)
$iRet:=BKP_XML_GetSchedulerSettings($tXPathElem)

// now here we will set the the variables depending on what we retrieved in our container

BKP_XML_SetInfo(->aInfoLabels; ->aInfoValues)
BKP_XML_SetGeneral(->aInfoLabels; ->aInfoValues)
BKP_XML_SetAdvanced(->aInfoLabels; ->aInfoValues)
BKP_XML_SetScheduler(->aInfoLabels; ->aInfoValues)

// close out the document

DOM CLOSE XML:C722($tParentElem)