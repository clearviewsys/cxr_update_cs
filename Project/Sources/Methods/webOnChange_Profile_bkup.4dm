//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 10/12/18, 14:23:56
// ----------------------------------------------------
// Method: webFormOnChange_profile
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $tFormName)
C_TEXT:C284($2; $tEvent)
C_TEXT:C284($3; $tSource)
C_TEXT:C284($4; $tSourceType)
C_POINTER:C301($5; $ptrNameArray)
C_POINTER:C301($6; $ptrValueArray)


C_TEXT:C284($0; $tResult)

C_TEXT:C284($tValue; $tCurrCode; $id; $num)
C_BOOLEAN:C305($bRefresh; $isSell; $isPage2; $isPage2Required; $isFlagged)
C_REAL:C285($rBookAmt; $rAmt; $rFee)
C_BOOLEAN:C305($bOnLoad; $is2Required; $is3Required)
C_TEXT:C284($tSection; $help; $alert)
C_COLLECTION:C1488($col; $idCol)
C_OBJECT:C1216($es; $entity; $status)
C_LONGINT:C283($currLevel; $min; $max; $priorLevel; $page2Count; $effectiveLevel; $i)


$tFormName:=$1
$tEvent:=$2
$tSource:=$3
$tSourceType:=$4
$ptrNameArray:=$5
$ptrValueArray:=$6

$tResult:=""
$bRefresh:=False:C215
$bOnLoad:=False:C215


If ($tEvent="DOMContentLoaded") | ($tEvent="onload")  //ON LOAD phase
	$bOnLoad:=True:C214
	
	ARRAY TEXT:C222($atSelectName; 0)
	ARRAY TEXT:C222($atSelectValue; 0)
	webGetChoiceListPictureTypes(getKeyValue("web.customers.profile.id.1.code"; "F;B;A;1;D"); ->$atSelectName; ->$atSelectValue)
	WAPI_pushDOMSelectOptions("profile-id-type-select"; ->$atSelectName; ->$atSelectValue; ->$atSelectName; "")
	WAPI_pushDOMVisible("wapi-dropzone-drop-group"; False:C215)  // hide the button
	WAPI_pushDOMHelp("profile-id-type-select"; getKeyValue("web.customers.profile.id.1.help"); "form-control-label small")
	WAPI_pushDOMHTML("profile-id-type-label"; getKeyValue("web.customers.profile.id.1.label"; "Select the type of ID you will upload"))
End if 


Case of 
	: ($tSource="dz-remove-btn@")
		// what just got removed? need to adjust the options to what pics have been added
		
		$id1:=WAPI_getParameter(WAPI_getInputControlID(->[Customers:3]PictureID_TemplateID:15)+"--1")
		$id1isFlagged:=ds:C1482.PictureIDTypes.query("TemplateID == :1"; $id1).first().isFlagged
		$id2:=WAPI_getParameter(WAPI_getInputControlID(->[Customers:3]PictureID_TemplateID:15)+"--2")
		$id3:=WAPI_getParameter(WAPI_getInputControlID(->[Customers:3]PictureID_TemplateID:15)+"--3")
		
		
		Case of 
			: ($id1="")
				$buildLevel:=1
				$priorLevel:=0
			: (($id2="") & ($id1isFlagged=False:C215))  // just added id1
				$buildLevel:=2
				$priorLevel:=1
			: ($id2="") & ($id1isFlagged)  // just added 1 and now need proof of address
				$buildLevel:=3
				$priorLevel:=1
			Else 
				$buildLevel:=3
				$priorLevel:=2
		End case 
		
		
		If ($buildLevel>0)
			ARRAY TEXT:C222($atSelectName; 0)
			ARRAY TEXT:C222($atSelectValue; 0)
			
			webGetChoiceListPictureTypes(getKeyValue("web.customers.profile.id."+String:C10($buildLevel)+".code"; "F;B;A;1;D"); ->$atSelectName; ->$atSelectValue)
			WAPI_pushDOMHTML("profile-id-type-label"; getKeyValue("web.customers.profile.id."+String:C10($buildLevel)+".label"; "Select the type of ID you will upload"))
			WAPI_pushDOMHelp("profile-id-type-select"; getKeyValue("web.customers.profile.id."+String:C10($buildLevel)+".help"))
			
			WAPI_pushDOMVisible("wapi-dropzone-select-group"; True:C214)
			WAPI_pushDOMSelectOptions("profile-id-type-select"; ->$atSelectName; ->$atSelectValue; ->$atSelectName; "")
			WAPI_pushDOMVisible("wapi-dropzone-drop-group"; False:C215)  // hide the button
		End if 
		
		
		If ($priorLevel>0)
			WAPI_pushJs("$('#dz-remove-btn--"+String:C10($priorLevel)+"').show();")
		End if 
		
		
		
	: ($tSource="") & ($tSourceType="file")  // image just added
		C_BOOLEAN:C305($id1isFlagged)
		C_TEXT:C284($id1; $id2; $id3; $currId)
		C_LONGINT:C283($buildLevel; $currLevel; $idLevel)
		
		If (True:C214)
			C_COLLECTION:C1488($page2Col; $idCol)
			
			//does the current level require a page 2
			$page2Col:=Split string:C1554(getKeyValue("web.customers.profile.id.page2.required"); ",")
			
			$idCol:=New collection:C1472
			$i:=0
			Repeat 
				$i:=$i+1
				
				$id:=WAPI_getParameter(WAPI_getInputControlID(->[Customers:3]PictureID_TemplateID:15)+"--"+String:C10($i))
				
				
				
				If ($id="")  //done
				Else 
					$num:=WAPI_getParameter(WAPI_getInputControlID(->[Customers:3]PictureID_Number:69)+"--"+String:C10($i))
					
					$entity:=ds:C1482.PictureIDTypes.query("TemplateID == :1"; $id).first()
					
					If ($i>1)  //is this a page 2? ... look at prior and see if page 2 required?
						C_OBJECT:C1216($parent)
						$parent:=$idCol[$i-2]
						
						If ($parent.isPage2Required) & ($parent.isPage2=False:C215)
							$isPage2:=True:C214
							$isPage2Required:=False:C215
							$isFlagged:=$parent.isFlagged
						Else 
							$isPage2:=False:C215
							$isPage2Required:=$page2Col.indexOf($entity.GovernmentCode)>-1
							$isFlagged:=False:C215  //only image 1
						End if 
					Else 
						$isPage2:=False:C215
						$isPage2Required:=$page2Col.indexOf($entity.GovernmentCode)>-1
						$isFlagged:=$entity.isFlagged
					End if 
					
					$idCol.push(New object:C1471("level"; $i; \
						"id"; $id; \
						"name"; $entity.Description; \
						"code"; $entity.GovernmentCode; \
						"isRequired"; getKeyValue("web.customers.profile.id."+String:C10($i)+".required"; "true")="true"; \
						"isFlagged"; $isFlagged; \
						"isPage2Required"; $isPage2Required; \
						"isPage2"; $isPage2; \
						"number"; $num\
						))
				End if 
			Until ($id="")
			
		Else 
			$id1:=WAPI_getParameter(WAPI_getInputControlID(->[Customers:3]PictureID_TemplateID:15)+"--1")
			$id2:=WAPI_getParameter(WAPI_getInputControlID(->[Customers:3]PictureID_TemplateID:15)+"--2")
			$id3:=WAPI_getParameter(WAPI_getInputControlID(->[Customers:3]PictureID_TemplateID:15)+"--3")
			If ($id1#"")
				$id1isFlagged:=ds:C1482.PictureIDTypes.query("TemplateID == :1"; $id1).first().isFlagged
			End if 
			$is2Required:=getKeyValue("web.customers.profile.id.2.required"; "true")="true"
			$is3Required:=getKeyValue("web.customers.profile.id.3.required"; "true")="true"
		End if 
		
		
		$page2Count:=$idCol.query("isPage2 == :1"; True:C214).length
		
		If (True:C214)
			$idLevel:=$idCol.length
			$currLevel:=$idCol.length
			
			C_OBJECT:C1216($idObj)
			$idObj:=$idCol[$idCol.length-1]
			
			Case of 
				: ($currLevel=0)  //no images yet
					$buildLevel:=1
				: ($idObj.isPage2) & (getKeyValue("web.customers.profile.id."+String:C10($currLevel-$page2Count+1)+".required")="true")
					//current level is page 2 and the next level is required
					$buildLevel:=$currLevel+1
					
				: ($idObj.isPage2Required)
					$buildLevel:=$currLevel+1
					
				: (getKeyValue("web.customers.profile.id."+String:C10($currLevel-$page2Count+1)+".required")="true")
					//current level is a page 1 and the next level is required
					$buildLevel:=$currLevel+1
					
				Else 
					$buildLevel:=0
			End case 
			
			
		Else 
			$idLevel:=0
			
			Case of 
				: ($id1="")
					$currLevel:=1
				: ($id2="") & ($id3="")  //  & ($id1isFlagged=False)
					$currLevel:=1
				: ($id2="") & ($id3#"")
					$currLevel:=3  // all done - not sure this will happen
				: ($id3="") & ($id1isFlagged)  //no level 2 in this case
					$currLevel:=2
					$idLevel:=3
				: ($id3="")
					$currLevel:=2
				Else 
					$currLevel:=3
			End case 
			
			If ($idLevel=0)
				$idLevel:=$currLevel
			End if 
		End if 
		
		
		If (False:C215)
			If (True:C214)
				Case of 
					: ($currLevel=0)  // first image on page
						$buildLevel:=1
						
					: (($currLevel=1) & ($id1isFlagged=False:C215))  // just added id1 and need a secondary ID is needed
						$currId:=$id1
						$buildLevel:=2
						
					: ($currLevel=1) & ($id1isFlagged=True:C214)  // just added id1 and NO secondary is needed so skip to 3
						If ($is3Required)
							$currId:=$id1
							$buildLevel:=3  //skip level 2 - per lotus
						Else 
							$currId:=$id1
							$buildLevel:=0
						End if 
						
					: ($currLevel=2) & ($id1isFlagged)  // just added id2 adn this would have been the proof (no secondary needed)
						$currId:=$id2
						$buildLevel:=0
						
					: ($currLevel=2)
						If ($is3Required)
							$currId:=$id2
							$buildLevel:=3
						Else 
							$currId:=$id2
							$buildLevel:=0
						End if 
						
					: ($currLevel=3)  // all images collected
						$currId:=$id3
						$buildLevel:=0
						
					Else 
						TRACE:C157
				End case 
				
			Else 
				Case of 
					: (($id2="") & ($id1isFlagged=False:C215))  // just added id1 and need a secondary ID
						$currId:=$id1
						$currLevel:=1
						$buildLevel:=2
						
					: ($id2="") & ($id1isFlagged) & ($is3Required)  // just added 1 and now need proof of address
						$currId:=$id1
						$currLevel:=1
						$buildLevel:=3  //skip level 2
						
					: ($id2="") & ($id1isFlagged)  // just added 1 - NO ID3 is needed
						$currId:=$id1
						$currLevel:=1
						$buildLevel:=0
						
					: (($id1isFlagged=True:C214) & ($id2#""))  //all ids collected
						$currId:=$id2
						$currLevel:=2
						$buildLevel:=0
						
					: ($id3#"")  // all ids collected
						$currId:=$id3
						$currLevel:=3
						$buildLevel:=0
						
					: ($is3Required)
						$currId:=$id2
						$currLevel:=2
						$buildLevel:=3
						
					Else   // NOT REQUIRED ID 3
						$currId:=$id2
						$currLevel:=2
						$buildLevel:=0
				End case 
			End if 
		End if 
		
		ARRAY TEXT:C222($atSelectName; 0)
		ARRAY TEXT:C222($atSelectValue; 0)
		
		WAPI_pushDOMVisible("wapi-dropzone-drop-group"; False:C215)  // hide the dz area to start with
		
		Case of 
			: ($buildLevel=0)
				WAPI_pushDOMVisible("wapi-dropzone-select-group"; False:C215)  // hide the pick list
				
			: ($buildLevel>0)
				//is this a page 2?
				If ($idObj.isPage2Required)  //next image is page 2
					APPEND TO ARRAY:C911($atSelectName; "--Select--")
					APPEND TO ARRAY:C911($atSelectValue; "")
					APPEND TO ARRAY:C911($atSelectName; "Page 2")
					APPEND TO ARRAY:C911($atSelectValue; "Page2")
					WAPI_pushDOMSelectOptions("profile-id-type-select"; ->$atSelectName; ->$atSelectValue; ->$atSelectName; "")
					WAPI_pushDOMHTML("profile-id-type-label"; "Please upload page 2 of the "+$idCol[$buildLevel-2].name)
					WAPI_pushDOMHelp("profile-id-type-select"; "")
				Else 
					webGetChoiceListPictureTypes(getKeyValue("web.customers.profile.id."+String:C10($buildLevel-$page2Count)+".code"; "F;B;A;1;D"); ->$atSelectName; ->$atSelectValue)
					WAPI_pushDOMSelectOptions("profile-id-type-select"; ->$atSelectName; ->$atSelectValue; ->$atSelectName; "")
					WAPI_pushDOMHTML("profile-id-type-label"; getKeyValue("web.customers.profile.id."+String:C10($buildLevel-$page2Count)+".label"; "Select the type of ID you will upload"))
					WAPI_pushDOMHelp("profile-id-type-select"; getKeyValue("web.customers.profile.id."+String:C10($buildLevel-$page2Count)+".help"))
				End if 
				
				WAPI_pushDOMVisible("wapi-dropzone-select-group"; True:C214)
				
		End case 
		
		
		// --- UPDATE THE INPUTS FOR THE NEWLY ADDED DZ IMAGE ----
		//$es:=ds.PictureIDTypes.query("TemplateID == :1"; $idObj.id)
		//If ($es.length=1)
		
		If ($idObj.isPage2)
			$entity:=ds:C1482.PictureIDTypes.query("TemplateID == :1"; $idCol[$currLevel-2].id).first()
		Else 
			$entity:=ds:C1482.PictureIDTypes.query("TemplateID == :1"; $idObj.id).first()
		End if 
		
		If ($entity.isIssuingDateMandatory=False:C215) | ($idObj.isPage2)  // hide field
			WAPI_pushDOMRemove("customers-pictureid_issuedate-input--"+String:C10($currLevel))
			WAPI_pushDOMRemove("customers-pictureid_issuedate-label--"+String:C10($currLevel))
		Else 
			// if type = G (proof of address) then only 90 days back
			$col:=Split string:C1554(getKeyValue("web.customers.profile.id.90dayexpire.code"); "G;BS")
			Case of 
				: ($col.indexOf($entity.GovernmentCode)>-1)
					$min:=-90
				: ($entity.GovernmentCode="G") | ($entity.GovernmentCode="BS")  // can remove after testing above
					$min:=-90
				Else 
					$min:=-3650
			End case 
			
			WAPI_pushJs("let optionsIssue = {")
			WAPI_pushJs("format: 'dd/mm/yyyy', editable: false, selectYears: 10, selectMonths: true,")
			WAPI_pushJs("formatSubmit: 'yyyy-mm-ddT00:00:00', hiddenName: true, min: "+String:C10($min)+", max: true, showMonthsShort: true};")
			WAPI_pushJs("$('[id="+"customers-pictureid_issuedate-input--"+String:C10($currLevel)+"]').pickadate(optionsIssue);")
		End if 
		
		If ($entity.isExpiryDateMandatory=False:C215) | ($idObj.isPage2)  // hide field
			WAPI_pushDOMRemove("customers-pictureid_expirydate-input--"+String:C10($currLevel))
			WAPI_pushDOMRemove("customers-pictureid_expirydate-label--"+String:C10($currLevel))
		Else 
			$max:=3650
			WAPI_pushJs("let optionsExpiry = {")
			WAPI_pushJs("format: 'dd/mm/yyyy', editable: false, selectYears: 10, selectMonths: true,")
			WAPI_pushJs("formatSubmit: 'yyyy-mm-ddT00:00:00', hiddenName: true, min: 0, max: "+String:C10($max)+", showMonthsShort: true};")
			WAPI_pushJs("$('[id="+"customers-pictureid_expirydate-input--"+String:C10($currLevel)+"]').pickadate(optionsExpiry);")
		End if 
		
		If ($entity.isIssuingAuthMand=False:C215) | ($idObj.isPage2)  // hide field
			WAPI_pushDOMRemove("customers-pictureid_authority-input--"+String:C10($currLevel))
			WAPI_pushDOMRemove("customers-pictureid_authority-label--"+String:C10($currLevel))
		End if 
		
		If ($entity.isIssuingCountryMandatory=False:C215) | ($idObj.isPage2)  // hide field
			WAPI_pushDOMRemove("customers-pictureid_countrycode-input--"+String:C10($currLevel))
			WAPI_pushDOMRemove("customers-pictureid_countrycode-label--"+String:C10($currLevel))
		End if 
		
		If ($entity.isIssuingStateMandatory=False:C215) | ($idObj.isPage2)  // hide field
			WAPI_pushDOMRemove("customers-pictureid_issuestate-input--"+String:C10($currLevel))
			WAPI_pushDOMRemove("customers-pictureid_issuestate-label--"+String:C10($currLevel))
		End if 
		
		WAPI_pushDOMValue("customers-pictureid_templatename-input--"+String:C10($currLevel); $entity.Description)
		
		
		If ($idObj.isPage2)
			WAPI_pushDOMValue("customers-pictureid_number-input--"+String:C10($currLevel); $idCol[$currLevel-2].num)
			WAPI_pushDOMReadOnly("customers-pictureid_number-input--"+String:C10($currLevel); True:C214)
			
		Else 
			$col:=Split string:C1554(getKeyValue("web.customers.profile.id.mandatory.code"; "*"); ";")
			If ($col.length>0)
				If ($col[0]="*")  // all required
				Else 
					If ($col.indexOf($entity.GovernmentCode)>-1)  // it is required
					Else 
						// get list of codes that have a mandatory ID for this level
						WAPI_pushDOMRemove("customers-pictureid_number-input--"+String:C10($currLevel))
						WAPI_pushDOMRemove("customers-pictureid_number-label--"+String:C10($currLevel))
					End if 
				End if 
			End if 
		End if 
		
		
		If ($currLevel>1)
			WAPI_pushJs("$('#dz-remove-btn--"+String:C10($currLevel-1)+"').hide();")
		End if 
		
		//End if 
		
		
	: ($tSource=WAPI_getInputControlID(->[Customers:3]PictureID_TemplateID:15))
		
		$col:=Split string:C1554(getKeyValue("web.customers.profile.id.requires.multiple.list"); ","; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
		
		If ($col.indexOf(WAPI_getParameter(WAPI_getInputControlID(->[Customers:3]PictureID_TemplateID:15)))>=0)  //
			//If (WAPI_getParameter (WAPI_getInputControlID (->[Customers]PictureID_TemplateID))="DL")
			WAPI_pushDOMVisible("profile-id-extra-group"; True:C214)
			$help:=webGetKeyValue("web.customers.profile.id.multiple.help"; "*** This type of ID REQUIRES an additional document ***")
			$alert:=webGetKeyValue("web.customers.profile.id.multiple.alert"; "*** This type of ID REQUIRES an additional document ***")
		Else 
			$help:=""
			$alert:=""
			WAPI_pushDOMVisible("profile-id-extra-group"; False:C215)
		End if 
		
		WAPI_pushDOMHelp(WAPI_getInputControlID(->[Customers:3]PictureID_TemplateID:15); $help; "text-danger small")
		WAPI_pushDOMHTML("profile-id-extra-alert"; $alert)
		
	: ($tSource="edit-button@")
		
		$tSection:=Replace string:C233($tSource; "edit-button-"; "")
		
		//enable all fields for editing
		WAPI_pushJs(WAPI_setAllInputReadOnly(False:C215))
		WAPI_pushDOMVisible("edit-button-"+$tSection; False:C215)
		WAPI_pushDOMVisible("cancel-button-"+$tSection; True:C214)
		WAPI_pushDOMVisible("save-button-"+$tSection; True:C214)
		
		
		If ($tSection="id")
			WAPI_pushDOMVisible("customers-pictureid_image-file"; True:C214)
		End if 
		
	: ($tSource="cancel-button@")  //hide cancel/save and show edit
		
		$tSection:=Replace string:C233($tSource; "cancel-button-"; "")
		
		//  ------ NEED TO UPDATE VALUES BASED ON SAVED IN CASE USER MADE ANY CHANGES --- <>TODO
		//disable all fields for editing
		WAPI_pushJs(WAPI_setAllInputReadOnly(True:C214))
		WAPI_pushDOMVisible("edit-button-"+$tSection; True:C214)
		WAPI_pushDOMVisible("cancel-button-"+$tSection; False:C215)
		WAPI_pushDOMVisible("save-button-"+$tSection; False:C215)
		
		
		If ($tSection="id")
			WAPI_pushDOMVisible("customers-pictureid_image-file"; False:C215)
		End if 
		
		
	: ($tSource="save-button@")
		
		$tSection:=Replace string:C233($tSource; "save-button-"; "")
		
		
		//---------------- SUBMIT BUTTON AND AGFEEMENT CHECKBOX ----------------------
	: ($tSource="agreement-input")  //checkbox to agree to conditions
		C_REAL:C285($iElem)
		$iElem:=Find in array:C230($ptrNameArray->; $tSource)
		If ($iElem>0)
			If ($ptrValueArray->{$iElem}="on")
				WAPI_pushJs("$('#submit-new-input').removeAttr('disabled');")
			Else 
				WAPI_pushJs("$('#submit-new-input').attr('disabled', 'disabled');")
			End if 
		Else 
			WAPI_pushJs("$('#submit-new-input').attr('disabled', 'disabled');")
		End if 
		
		
		//--- OPT IN CHECKBOX ----
	: ($tSource="optin-input")  //checkbox to optin  to marketing
		C_REAL:C285($iElem)
		$iElem:=Find in array:C230($ptrNameArray->; $tSource)
		If ($iElem>0)
			If ($ptrValueArray->{$iElem}="on")
				
			Else 
				
			End if 
		Else 
			
		End if 
		
		
	: ($tSource="profile-existing-input")
		If (WAPI_getParameter("profile-existing-input")="on")
			WAPI_pushDOMProperty("profile-new-input"; "checked"; "false")
			WAPI_pushDOMVisible("profile-create-row"; False:C215)
			WAPI_pushDOMVisible("profile-existing-submit"; True:C214)
		Else 
			WAPI_pushDOMProperty("profile-new-input"; "checked"; "true")
			WAPI_pushDOMVisible("profile-create-row"; True:C214)
			WAPI_pushDOMVisible("profile-existing-submit"; False:C215)
		End if 
		
	: ($tSource="profile-new-input")
		If (WAPI_getParameter("profile-new-input")="on")
			WAPI_pushDOMProperty("profile-existing-input"; "checked"; "false")
			WAPI_pushDOMVisible("profile-create-row"; True:C214)
			WAPI_pushDOMVisible("profile-existing-submit"; False:C215)
		Else 
			WAPI_pushDOMProperty("profile-existing-input"; "checked"; "true")
			WAPI_pushDOMVisible("profile-create-row"; False:C215)
			WAPI_pushDOMVisible("profile-existing-submit"; True:C214)
		End if 
		
		
		
	Else 
		
End case 


WAPI_pushJs("wapiShowProcessing(false);")

$0:=WAPI_pullJsStack  //$tResult
