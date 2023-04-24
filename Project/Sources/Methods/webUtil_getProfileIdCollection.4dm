//%attributes = {}


C_OBJECT:C1216($0; $status)

C_COLLECTION:C1488($page2Col; $idCol)
C_LONGINT:C283($page2Count; $flaggedCount; $i; $currLevel; $buildLevel; $effectiveLevel; $priorLevel)
C_OBJECT:C1216($entity)
C_TEXT:C284($num; $id)
C_BOOLEAN:C305($isFlagged; $isPage2; $isPage2Required; $isComplete)

$status:=New object:C1471("success"; False:C215; \
"status"; 1; \
"statusText"; ""; \
"collection"; New collection:C1472; \
"buildLevel"; 0; \
"currentLevel"; 0; \
"priorLevel"; 0; \
"effectiveLevel"; 0; \
"page2Count"; 0; \
"isComplete"; False:C215)

$isComplete:=False:C215
//what IDs require a page 2
$page2Col:=Split string:C1554(getKeyValue("web.customers.profile.id.page2.required"); ";")

$idCol:=New collection:C1472
$i:=0
Repeat 
	$i:=$i+1
	
	$id:=WAPI_getParameter(WAPI_getInputControlID(->[Customers:3]PictureID_TemplateID:15)+"--"+String:C10($i))
	
	If ($id="")  //done
	Else 
		$num:=WAPI_getParameter(WAPI_getInputControlID(->[Customers:3]PictureID_Number:69)+"--"+String:C10($i))
		
		
		//if PAGE 2
		
		If ($id="PAGE2")
			$entity:=ds:C1482.PictureIDTypes.query("TemplateID == :1"; $idCol[$i-2].id).first()  // get parent
		Else 
			$entity:=ds:C1482.PictureIDTypes.query("TemplateID == :1"; $id).first()
		End if 
		
		If ($i>1)  //is this a page 2? ... look at prior and see if page 2 required?
			C_OBJECT:C1216($parent)
			$parent:=$idCol[$i-2]
			
			If ($parent.isPage2Required) & ($parent.isPage2=False:C215)
				$isPage2:=True:C214
				$isPage2Required:=False:C215
				$isFlagged:=False:C215  //$parent.isFlagged
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

If ($idCol.length>0)
	
	$page2Count:=$idCol.query("isPage2 == :1"; True:C214).length
	$flaggedCount:=$idCol.query("isFlagged == :1"; True:C214).length
	
	$currLevel:=$idCol.length
	
	C_OBJECT:C1216($idObj)
	$idObj:=$idCol[$idCol.length-1]
	
	Case of 
		: ($currLevel=0)  //no images yet
			$buildLevel:=1
			$priorLevel:=0
			$effectiveLevel:=0
			
		: ($idObj.isPage2Required)
			$buildLevel:=$currLevel+1
			$priorLevel:=$currLevel-1-$page2Count
			$effectiveLevel:=$currLevel+$flaggedCount-$page2Count
			
		: ($currLevel=1) & ($idObj.isFlagged) & (getKeyValue("web.customers.profile.id."+String:C10($currLevel-$page2Count+$flaggedCount+1)+".required")="true")
			$buildLevel:=3
			$priorLevel:=0
			$effectiveLevel:=2
			
		: ($idObj.isPage2) & (getKeyValue("web.customers.profile.id."+String:C10($currLevel-$page2Count+$flaggedCount+1)+".required")="true")
			//current level is page 2 and the next level is required
			$buildLevel:=$currLevel+1
			$priorLevel:=$currLevel-1-$page2Count
			$effectiveLevel:=$currLevel+$flaggedCount-$page2Count
			
			//: ($idObj.isPage2Required)
			//$buildLevel:=$currLevel+1
			//$priorLevel:=$currLevel-1-$page2Count
			//$effectiveLevel:=$currLevel+$flaggedCount-$page2Count
			
		: (getKeyValue("web.customers.profile.id."+String:C10($currLevel-$page2Count+$flaggedCount+1)+".required")="true")
			//current level is a page 1 and the next level is required
			$buildLevel:=$currLevel+1
			$priorLevel:=$currLevel-1-$page2Count
			$effectiveLevel:=$currLevel+$flaggedCount-$page2Count
			
		Else 
			$buildLevel:=0
			$priorLevel:=0
			$effectiveLevel:=0
			$isComplete:=True:C214
	End case 
	
	
	
	$status.success:=True:C214
	$status.status:=0
	$status.collection:=$idCol
	$status.buildLevel:=$buildLevel
	$status.currentLevel:=$currLevel
	$status.priorLevel:=$priorLevel
	$status.effectiveLevel:=$effectiveLevel
	$status.page2Count:=$page2Count
	$status.isComplete:=$isComplete
End if 

$0:=$status
