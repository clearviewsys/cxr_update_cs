//%attributes = {}
#DECLARE($propertiesParam : Object; $datasetsParam : Collection; $referentsParam : Collection)->$formatted : Collection

var $properties : Object
var $datasets; $referents : Collection
Case of 
	: (Count parameters:C259=3)
		$properties:=$propertiesParam
		$datasets:=$datasetsParam
		$referents:=$referentsParam
End case 

//var $schema : Object
//HTTP Request(HTTP GET method; "https://data.opensanctions.org/datasets/latest/index.json"; ""; $schema)


// MARK:- For each match...
var $colour : Text
var $style : Integer
var $formula : 4D:C1709.Function
$formatted:=New collection:C1472
var $key : Text

// MARK: Add properties into the formatted fields
For each ($key; $properties)
	var $line : Object
	If ($properties[$key].length=0)
		continue
	End if 
	
	
	// MARK: add styles and commands
	Case of 
		: (($key="modifiedAt") || ($key="topics"))
			$style:=Plain:K14:1
			$colour:="#808080"
			$formula:=Formula:C1597("")
			
		: (($key="@name") || ($key="@alias@"))
			$style:=Bold:K14:2
			$colour:=""
			$formula:=Formula:C1597("")
			
		: (($key="@url@") || ($key="website"))
			$style:=Underline:K14:4
			$colour:="#0000FF"
			$formula:=Formula:C1597(util_openURL($2))
			
		: ($key="wikidataid")
			$style:=Underline:K14:4
			$colour:="#0000FF"
			$formula:=Formula:C1597(util_openURL("https://www.wikidata.org/wiki/"+$2))
			
		: (($key="@entity") || ($key="person") || ($key="holder") || ($key="access"))
			$colour:="#0000FF"
			$style:=Underline:K14:4
			$formula:=Formula:C1597(sl_handleOpenSanctionEntity($2))
			
		Else 
			$style:=Plain:K14:1
			$colour:=""
			$formula:=Formula:C1597("")
	End case 
	
	var $value; $field : Text
	var $idx : Integer
	$idx:=0
	If (Value type:C1509($properties[$key][$idx])=Is text:K8:3)
		
		For each ($value; $properties[$key])
			// Create the field name
			If ($properties[$key].length=1)
				$field:=$key
			Else 
				$field:=$key+" ("+String:C10($idx+1)+")"
			End if 
			
			$line:=New object:C1471(\
				"key"; $field; \
				"value"; $properties[$key][$idx]; \
				"style"; $style; \
				"colour"; $colour; \
				"detail"; $formula)
			$formatted.push($line)
			$idx:=$idx+1
		End for each 
	Else 
		
		$style:=Underline:K14:4
		$colour:="#4B0082"
		$formula:=Formula:C1597(sl_handleOpenSanctionEntity(This:C1470.entity))
		
		var $entity : Object
		For each ($entity; $properties[$key])
			// Create the field name
			If ($properties[$key].length=1)
				$field:=$key
			Else 
				$field:=$key+" ("+String:C10($idx+1)+")"
			End if 
			
			$line:=New object:C1471(\
				"key"; $field; \
				"value"; $properties[$key][$idx].id; \
				"style"; $style; \
				"colour"; $colour; \
				"detail"; $formula; \
				"entity"; $properties[$key][$idx])
			$formatted.push($line)
			$idx:=$idx+1
		End for each 
	End if 
	
End for each 

// MARK: add datasets as properties
$idx:=1
$colour:="#0000FF"
$style:=Underline:K14:4
$formula:=Formula:C1597(util_openURL("https://www.opensanctions.org/datasets/"+$2))

var $dataset : Text
For each ($dataset; $datasets)
	If ($dataset#"")
		$formatted.push(New object:C1471(\
			"key"; "dataset ("+String:C10($idx)+")"; \
			"value"; $dataset; \
			"style"; $style; \
			"colour"; $colour; \
			"detail"; $formula\
			))
		$idx:=$idx+1
	End if 
End for each 

// MARK: add referant as properties
var $referent : Text
$idx:=1

$colour:="#0000FF"
$style:=Underline:K14:4
$formula:=Formula:C1597(sl_handleOpenSanctionEntity($2))
For each ($referent; $referents)
	If ($referent#"")
	End if 
	$formatted.push(New object:C1471(\
		"key"; "referent ("+String:C10($idx)+")"; \
		"value"; $referent; \
		"style"; $style; \
		"colour"; $colour; \
		"detail"; $formula\
		))
	$idx:=$idx+1
End for each 
