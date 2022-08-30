//%attributes = {}
// makeHTMLBody5 (»table,»field1;...;»field5;{contextID}) -> text

// This version handles the field pointer type resolutions. ie:convert them to str


// »table: pointer to the table to list its records

// field1-field5: pointers to fields to be listed in the HTML form

// returns a text for the body in HTML format


// PRE: RECORDS SELECTION MUST BE DONE IN ADVANCE

// POST: Current record will be changed to last record in selection




C_POINTER:C301($1; $2; $3; $4; $5; $6)
C_TEXT:C284($7)

C_LONGINT:C283($i)
C_TEXT:C284($dynamicLink; $dynamicLinkPrefix)
C_TEXT:C284($0)
C_TEXT:C284($str1; $str2; $str3; $str4; $str5)

$0:=Char:C90(1)
If (Count parameters:C259=7)
	$dynamicLinkPrefix:="/4DACTION/webViewCID"+Table name:C256($1)+"/"+$7+"/"
Else 
	$dynamicLinkPrefix:="/4DACTION/webView"+Table name:C256($1)+"/"
End if 

For ($i; 1; Records in selection:C76($1->))
	$str1:=FieldToString($2)
	$str2:=FieldToString($3)
	$str3:=FieldToString($4)
	$str4:=FieldToString($5)
	$str5:=FieldToString($6)
	
	// dynamicLink is a URL link to open an individual record once clicked on its link
	
	$dynamicLink:=$dynamicLinkPrefix+String:C10(Record number:C243($1->))
	
	$0:=$0+makeHTMLTitle5($i; makeURLLink($dynamicLink; $str1; "_self"); $str2; $str3; $str4; $str5)
	NEXT RECORD:C51($1->)
End for 

