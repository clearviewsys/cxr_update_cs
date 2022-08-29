//%attributes = {}
/* Fill in the values for $display of handleSanctionListMatches

#param $displayOptionsParam
       The object to fill
#return
       Display options with default values
#author @Wai-Kin
*/
#DECLARE($displayOptionsParam : Object)->$displayOptions : Object

C_OBJECT:C1216($displayOptions)

Case of 
	: (Count parameters:C259=0)
		$displayOptions:=New object:C1471
		
	: (Count parameters:C259=1)
		$displayOptions:=$displayOptionsParam
		
		If (Not:C34(OB Is defined:C1231($displayOptions)))
			$displayOptions:=New object:C1471
		End if 
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Which name matches to show in the list box
// handled by sl_handleShowRadio
If (OB Is defined:C1231($displayOptions; "matches"))
	Case of 
		: ($displayOptions.matches="A")  // All results
		: ($displayOptions.matches="S")  // Similar Name Matches
		: ($displayOptions.matches="E")  // Extact Name Matches
		Else 
			$displayOptions.matches:="A"
	End case 
Else 
	$displayOptions.matches:="A"
End if 

// Which list to show in the list box
// updated by sl_handleMatchSummaryList
If (OB Get type:C1230($displayOptions; "lists")#Is collection:K8:32)
	$displayOptions.lists:=New collection:C1472
End if 

// Should the search look for fields?
// updated by sl_handleFilterCheckBoxes
If (OB Get type:C1230($displayOptions; "searchFields")#Is boolean:K8:9)
	$displayOptions.searchFields:=True:C214
End if 

// Should the search look for values?
// updated by sl_handleFilterCheckBoxes
If (OB Get type:C1230($displayOptions; "searchValues")#Is boolean:K8:9)
	$displayOptions.searchValues:=True:C214
End if 

// The term to search; empty string for no searches
// updated by the actual textbox
If (OB Get type:C1230($displayOptions; "searchTerm")#Is text:K8:3)
	$displayOptions.searchTerm:=""
End if 