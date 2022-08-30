//%attributes = {}

// pickFilePathCurrencies(SearchString;preQueryString;->returnPointer)
// #ORDA


C_TEXT:C284($searchString; $preQueryString; $filePathID)

If (Count parameters:C259>=1)
	C_TEXT:C284($1)
	$searchString:=$1
Else 
	$searchString:=""
End if 

If (Count parameters:C259>=2)
	C_TEXT:C284($2)
	$preQueryString:=$2
End if 

// new way using collection
C_COLLECTION:C1488($listboxcolumns)
C_OBJECT:C1216($listboxcolumn)

$listboxcolumns:=New collection:C1472

// all properties are present in first column
$listboxcolumn:=setListboxObjectProperties(->[FilePaths:83]FilePathID:1; 100; "Filepath ID")
$listboxcolumn.columnstyle:=Underline:K14:4
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[FilePaths:83]FileName:2; 100; "File Name")
$listboxcolumns.push($listboxcolumn)

$listboxcolumn:=setListboxObjectProperties(->[FilePaths:83]FolderPath:3; 150; "Folder Path")
$listboxcolumns.push($listboxcolumn)


C_OBJECT:C1216($parameters)
$parameters:=New object:C1471
$parameters.tableLabel:="File Path"
$parameters.initialUserSearchString:=$searchString
$parameters.preQueryStr:="FilePathID = "+$preQueryString+"@"
$parameters.makeSelection:=False:C215
$parameters.listboxBottom:=150

C_OBJECT:C1216($result)
$result:=pickRecords($listboxcolumns; $parameters)
If ($result#Null:C1517)
	$filePathID:=$result.FilePathID[0]
	$0:=$filePathID
End if 