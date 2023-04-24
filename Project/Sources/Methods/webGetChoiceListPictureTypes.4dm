//%attributes = {"shared":true,"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/11/18, 22:21:13
// ----------------------------------------------------


C_TEXT:C284($1)  // filter
C_POINTER:C301($2)  //option - pointer to array to fill
C_POINTER:C301($3)  //option value
C_POINTER:C301($4)  //option label

C_COLLECTION:C1488($col; $filter; $fields)

$filter:=New collection:C1472
$filter:=Split string:C1554($1; ";"; sk ignore empty strings:K86:1+sk trim spaces:K86:2)

$fields:=New collection:C1472
$fields.push("TemplateID")
$fields.push("Description")

READ ONLY:C145([PictureIDTypes:92])

Case of 
	: ($1="") | ($1="*")
		$col:=ds:C1482.PictureIDTypes.all().toCollection($fields)
	Else 
		$col:=ds:C1482.PictureIDTypes.query("GovernmentCode IN :1"; $filter).toCollection($fields)
End case 


If (True:C214)
	COLLECTION TO ARRAY:C1562($col; $3->; "TemplateID"; $2->; "Description")
Else 
	ORDER BY:C49([PictureIDTypes:92]; [PictureIDTypes:92]Description:14; >)
	SELECTION TO ARRAY:C260([PictureIDTypes:92]TemplateID:1; $3->)
	SELECTION TO ARRAY:C260([PictureIDTypes:92]Description:14; $2->)
End if 

INSERT IN ARRAY:C227($2->; 1)
$2->{1}:="-Select a Picture ID Type-"
INSERT IN ARRAY:C227($3->; 1)
$3->{1}:=""
