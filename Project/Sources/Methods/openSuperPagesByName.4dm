//%attributes = {}
//http://wp2.superpages.ca/wp/results.phtml?SRC=ca&STYPE=WS&PS=15&PI=1&WF=Ehsan&WL=Malaki&WES=1&T=&S=&search=Find&rtd=wp1.superpages.ca-215539

//http://wp.superpages.ca/wp/results.phtml?SRC=ca&STYPE=WS&PS=15&PI=1&WF=tiran&WL=behrouz&T=&S=&search=Find+It


C_TEXT:C284($firstName; $lastName; $1; $2)
C_BOOLEAN:C305($3; $exactMatch)
$firstName:=$1
$lastName:=$2
$exactMatch:=$3
If ($exactMatch)
	OPEN URL:C673("http://wp2.superpages.ca/wp/results.phtml?SRC=ca&STYPE=WS&PS=15&PI=1&WF="+$firstName+"&WL="+$lastName+"&WES=1&T=&S=&search=Find&rtd=wp1.superpages.ca-215539"; *)
Else 
	OPEN URL:C673("http://wp.superpages.ca/wp/results.phtml?SRC=ca&STYPE=WS&PS=15&PI=1&WF="+$firstName+"&WL="+$lastName+"&T=&S=&search=Find+It"; *)
End if 