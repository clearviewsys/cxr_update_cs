//%attributes = {}
//
//
//
//  // ----------------------------------------------------
//  // User name (OS): Barclay Berry
//  // Date and time: 06/26/12, 08:52:03
//  // Copyright 2012 -- i.Comp, LLC
//  // ----------------------------------------------------
//  // Method: webSendGridData
//  // 
//  //
//  // Parameters
//  // ----------------------------------------------------
//
//C_TEXT($tResult;$tCondition;$tDataIndx;$tDataType;$tValue)
//C_BLOB($xBlob)
//
//C_LONGINT($pq_rpp;$pq_curpage;$pq_totalrecords)
//C_BLOB($xBlob)
//
//C_BOOLEAN($bUseObjects)
//
//  //$ptrTable:=->[Address_Book]
//  //TRACE
//
//If (False)
//$tVersion:=Application version
//Else 
//$tVersion:="1306"
//End if 
//
//If ($tVersion="13@")
//$bUseObjects:=False
//json_init 
//Else 
//$bUseObjects:=True
//End if 
//
//ARRAY TEXT($anames;0)
//ARRAY TEXT($avalues;0)
//WEB GET VARIABLES($anames;$avalues)
//
//
//$pq_totalrecords:=0
//
//
//$iElem:=Find in array($anames;"table")
//If ($iElem>0)
//$pq_table:=$avalues{$iElem}
//Else 
//$pq_table:=""  //default to no table
//End if 
//
//If ($pq_table="")  //stop right here
//  //send back an error
//Else 
//
//$ptrTable:=webTxt2Field ($pq_table)
//
//$iElem:=Find in array($anames;"pq_curpage")
//If ($iElem>0)
//$pq_curpage:=Num($avalues{$iElem})
//Else 
//$pq_curpage:=1
//End if 
//
//
//$iElem:=Find in array($anames;"pq_rpp")
//If ($iElem>0)
//$pq_rpp:=Num($avalues{$iElem})
//Else 
//$pq_rpp:=20  //default to 20 records at a time
//End if 
//
//$iElem:=Find in array($anames;"map")  //not used yet
//If ($iElem>0)
//$pq_map:=$avalues{$iElem}
//Else 
//$pq_map:=""  //default to all fields
//End if 
//
//  //--------- DO WE IMPLEMENT A CACHING MECHANISM USING SETS AND SESSION INFO ? -------------
//
//$iElem:=Find in array($anames;"pq_filter")
//
//If ($iElem>0)
//
//$tFilter:=$avalues{$iElem}
//
//
//If ($bUseObjects=False)  //for v13
//
//$tjsonOBJ:=json_parse ($tFilter)
//$tMode:=json_getText ($tjsonOBJ;"mode")
//$tDataList:=json_getText ($tjsonOBJ;"data")
//
//$tjsonOBJ:=json_parseList ($tDataList)
//$iCount:=json_getListSize ($tjsonOBJ)
//
//For ($i;1;$iCount)
//$tListItem:=json_getListText ($tjsonOBJ;$i)
//$tListItemParsed:=json_parse ($tListItem)
//
//$tCondition:=json_getText ($tListItemParsed;"condition")
//$tDataType:=json_getText ($tListItemParsed;"dataType")
//$tDataIndx:=json_getText ($tListItemParsed;"dataIndx")
//$tValue:=json_getText ($tListItemParsed;"value")
//
//$ptrField:=webTxt2Field ($tDataIndx)
//
//If (Nil($ptrField))  //is this a function
//
//Else 
//If ($i=1)
//QUERY($ptrTable->;$ptrField->=$tValue+"@";*)
//Else 
//If ($tMode="OR")
//QUERY($ptrTable->; | ;$ptrField->=$tValue+"@";*)
//Else 
//QUERY($ptrTable->; & ;$ptrField->=$tValue+"@";*)
//End if 
//End if 
//End if 
//
//End for 
//
//QUERY($ptrTable->)
//
//Else   //v15 +++
//
//$obj:=JSON Parse($tFilter)
//$tMode:=OB Get($obj;"mode")
//
//ARRAY OBJECT($aoQueryData;0)
//OB GET ARRAY($obj;"data";$aoQueryData)
//
//For ($i;1;Size of array($aoQueryData))
//$tCondition:=OB Get($aoQueryData{$i};"condition")
//$tDataType:=OB Get($aoQueryData{$i};"dataType")
//$tDataIndx:=OB Get($aoQueryData{$i};"dataIndx")
//$tValue:=OB Get($aoQueryData{$i};"value")
//
//$ptrField:=webTxt2Field ($tDataIndx)
//
//If (Nil($ptrField))  //is this a function
//
//Else 
//If ($i=1)
//QUERY($ptrTable->;$ptrField->=$tValue+"@";*)
//Else 
//If ($tMode="OR")
//QUERY($ptrTable->; | ;$ptrField->=$tValue+"@";*)
//Else 
//QUERY($ptrTable->; & ;$ptrField->=$tValue+"@";*)
//End if 
//End if 
//End if 
//End for 
//
//QUERY($ptrTable->)
//
//End if 
//
//Else 
//  //REDUCE SELECTION($ptrTable->;0)
//ALL RECORDS($ptrTable->)
//  //REDUCE SELECTION($ptrTable->;500)
//End if 
//
//
//  //----- ADD FILTERING HERE BASED ON USER SESSION AND PERMISSIONS -----------
//
//
//
//
//
//
//
//If (True)  // ---- ----------------  REMOTE SORTING HERE ---------------------
//$iElem:=Find in array($anames;"pq_sort")
//If ($iElem>0)  //we have soring info
//
//$tSort:=$avalues{$iElem}
//
//If (Substring($tSort;1;1)="[")
//$tSort:=Substring($tSort;2;Length($tSort))
//End if 
//
//If (Substring($tSort;Length($tSort);1)="]")
//$tSort:=Substring($tSort;1;Length($tSort)-1)
//End if 
//
//
//If ($bUseObjects=False)  //v13
//$tjsonOBJ:=json_parse ($tSort)
//$tDataIndx:=json_getText ($tjsonOBJ;"dataIndx")
//$tDir:=json_getText ($tjsonOBJ;"dir")
//Else 
//C_OBJECT($objSort)
//$objSort:=JSON Parse($tSort)
//$tDataIndx:=OB Get($objSort;"dataIndx")
//$tDir:=OB Get($objSort;"dir")
//End if 
//
//
//$ptrSortField:=webTxt2Field ($tDataIndx)
//
//If (Nil($ptrSortField))  //is this a function
//
//Else 
//If ($tDir="up")
//ORDER BY($ptrTable->;$ptrSortField->;<)
//Else 
//ORDER BY($ptrTable->;$ptrSortField->;>)
//End if 
//End if 
//
//End if 
//End if 
//
//
//If (True)  //----------------- HANDLE REMOTE PAGING HERE -----------------------
//If (Records in selection($ptrTable->)>0)
//
//$pq_totalrecords:=Records in selection($ptrTable->)
//$iStart:=($pq_curpage-1)*$pq_rpp
//
//ARRAY LONGINT($aiRecNums;0)
//SELECTION RANGE TO ARRAY($iStart;$iStart+$pq_rpp;$ptrTable->;$aiRecNums)
//CREATE SELECTION FROM ARRAY($ptrTable->;$aiRecNums)  //using selection we keep the sort order
//
//End if 
//End if 
//
//
//
//If (True)  // ------------------ BUILD THE JSON RECORD SET -----------------------
//If ($bUseObjects=True)
//C_OBJECT($objTable)
//
//ARRAY OBJECT($aoRecords;0)
//
//FIRST RECORD($ptrTable->)
//For ($i;1;Records in selection($ptrTable->))
//
//C_OBJECT($objRecord)
//
//If (OK=1)
//
//For ($ii;1;Get last field number($ptrTable))
//If (Is field number valid($ptrTable;$ii))
//
//$ptrField:=Field(Table($ptrTable);$ii)
//$tJSONFieldName:=webField2Txt ($ptrField)
//$iType:=Type($ptrField->)
//
//Case of 
//: ($tJSONFieldName="@irsid@")
//
//: ($iType=Is Text) | ($iType=Is Alpha Field) | ($iType=Is String Var)
//OB SET($objRecord;$tJSONFieldName;$ptrField->)
//
//: ($iType=Is Picture)
//
//
//
//If (Picture size($ptrField->)>0)
//
//C_PICTURE($picture)
//
//TRACE
//CREATE THUMBNAIL($ptrField->;$picture;96;96;Scaled to fit prop centered)
//PICTURE TO BLOB($picture;$xBlob;".jpg")
//
//  //PICTURE TO GIF($ptrField->;$xBlob)
//If (OK=1)
//BASE64 ENCODE($xBlob)
//$tConverted:=Convert to text($xBlob;"US-ASCII")
//$tConverted:="<content type=\"html\"><img alt=\"Embedded Image\" src=\"data:image/jpg;base64,"+$tConverted+"\"></content>"
//OB SET($objRecord;$tJSONFieldName;$tConverted)
//End if 
//
//Else 
//OB SET($objRecord;$tJSONFieldName;"")
//End if 
//
//: ($iType=Is Date)  //handle date formating here
//OB SET($objRecord;$tJSONFieldName;String($ptrField->;ISO Date))
//
//: ($iType=Is Time)  //handle time formating here
//OB SET($objRecord;$tJSONFieldName;String($ptrField->;HH MM SS))
//
//: ($iType=Is BLOB)
//OB SET($objRecord;$tJSONFieldName;"UNSUPPORTED TYPE")
//
//Else   // ADD HANDLING FOR OTHER FIELD TYPES
//OB SET($objRecord;$tJSONFieldName;$ptrField->)
//End case 
//
//End if 
//End for 
//
//
//If (True)
//C_OBJECT($objTip)
//OB SET($objTip;"title";[Address_Book]Comment)
//C_OBJECT($objAttrib)
//OB SET($objAttrib;"address_book___last_name";$objTip)
//OB SET($objRecord;"pq_cellattr";$objAttrib)
//End if 
//
//End if 
//
//$refValue:=OB Copy($objRecord)
//APPEND TO ARRAY($aoRecords;$refValue)
//
//NEXT RECORD($ptrTable->)
//End for 
//
//
//OB SET($objTable;"totalRecords";$pq_totalrecords)
//OB SET($objTable;"curPage";$pq_curpage)
//
//OB SET ARRAY($objTable;"data";$aoRecords)
//$tResult:=JSON Stringify($objTable;*)
//
//Else 
//
//$tTableObj:=json_newObject 
//$tRecordList:=json_newList 
//
//  //ARRAY OBJECT($aoRecords;0)
//
//FIRST RECORD($ptrTable->)
//For ($i;1;Records in selection($ptrTable->))
//
//  //C_OBJECT($objRecord)
//C_TEXT($tRecordObj)
//$tRecordObj:=json_newObject 
//
//If (OK=1)
//
//For ($ii;1;Get last field number($ptrTable))
//If (Is field number valid($ptrTable;$ii))
//
//$ptrField:=Field(Table($ptrTable);$ii)
//$tJSONFieldName:=webField2Txt ($ptrField)
//$iType:=Type($ptrField->)
//
//Case of 
//: ($tJSONFieldName="@irsid@")
//
//: ($iType=Is Text) | ($iType=Is Alpha Field) | ($iType=Is String Var)
//json_addText (->$tRecordObj;$ptrField->;$tJSONFieldName)
//
//: ($iType=Is Picture)
//If (Picture size($ptrField->)>0)
//
//C_PICTURE($picture)
//
//CREATE THUMBNAIL($ptrField->;$picture;96;96;Scaled to fit prop centered)
//PICTURE TO BLOB($picture;$xBlob;".jpg")
//
//  //PICTURE TO GIF($ptrField->;$xBlob)
//If (OK=1)
//BASE64 ENCODE($xBlob)
//  //$tConverted:=Replace string(Convert to text($xBlob;"US-ASCII");"\\";"\\\\")
//$tConverted:=Replace string(Convert to text($xBlob;"UTF-8");"\\";"\\\\")
//$tConverted:="<content type=\"html\"><div><img alt='Embeded Image' src='data:image/jpeg;charset=UTF8;base64,"+$tConverted+"'/></div></content>"
//json_addText (->$tRecordObj;$tConverted;$tJSONFieldName)
//End if 
//
//Else 
//json_addText (->$tRecordObj;"";$tJSONFieldName)
//End if 
//
//: ($iType=Is Date)  //handle date formating here
//json_addText (->$tRecordObj;String($ptrField->;ISO Date);$tJSONFieldName)
//
//: ($iType=Is Time)  //handle time formating here
//json_addText (->$tRecordObj;String($ptrField->;HH MM SS);$tJSONFieldName)
//
//: ($iType=Is BLOB)
//json_addText (->$tRecordObj;"UNSUPPORTED TYPE";$tJSONFieldName)
//
//: ($iType=Is Boolean)
//json_addBoolean (->$tRecordObj;$ptrField->;$tJSONFieldName)
//
//: ($iType=Is Real) | ($iType=Is LongInt) | ($iType=Is Integer)
//json_addNum (->$tRecordObj;$ptrField->;$tJSONFieldName)
//
//Else   // ADD HANDLING FOR OTHER FIELD TYPES
//json_addText (->$tRecordObj;$ptrField->;$tJSONFieldName)
//End case 
//
//End if 
//End for 
//
//
//If (False)
//C_OBJECT($objTip)
//OB SET($objTip;"title";[Address_Book]Comment)
//C_OBJECT($objAttrib)
//OB SET($objAttrib;"address_book___last_name";$objTip)
//OB SET($objRecord;"pq_cellattr";$objAttrib)
//End if 
//
//End if 
//
//json_appendObjectToList (->$tRecordList;$tRecordObj)
//
//NEXT RECORD($ptrTable->)
//End for 
//
//json_addNum (->$tTableObj;$pq_totalrecords;"totalRecords")
//json_addNum (->$tTableObj;$pq_curpage;"curPage")
//json_addObj (->$tTableObj;$tRecordList;"data")
//
//End if 
//
//  //$tResult:=JSON Stringify array($aoRecords;*)
//SET TEXT TO PASTEBOARD($tResult)
//
//json_send ($tTableObj)
//
//  //WEB SEND TEXT($tResult;"application/json")
//  //WEB SEND TEXT($tResult;"text/plain")
//
//Else 
//$tRootValue:=webField2Txt ($ptrTable)
//
//$tRoot:=DOM Create XML Ref($tRootValue)
//
//For ($i;1;Records in selection($ptrTable->))
//
//$tRecordRef:=DOM Create XML element($tRoot;"/"+$tRootValue+"/record["+String($i)+"]/")
//
//If (OK=1)
//For ($ii;1;Get last field number($ptrTable))
//If (Is field number valid($ptrTable;$ii))
//
//$ptrField:=Field(Table($ptrTable);$ii)
//$tJSONFieldName:=WEBAPI_Field2txt($ptrField)
//$iType:=Type($ptrField->)
//
//Case of 
//: ($tJSONFieldName="@irsid@")
//
//: ($iType=Is Text) | ($iType=Is Alpha Field) | ($iType=Is String Var)
//$tRef:=DOM Create XML element($tRecordRef;"/record/"+$tJSONFieldName+"/")
//If (OK=1)
//DOM SET XML ELEMENT VALUE($tRef;$ptrField->)
//End if 
//
//Else 
//
//End case 
//
//End if 
//End for 
//End if 
//
//NEXT RECORD($ptrTable->)
//End for 
//
//If (True)
//DOM EXPORT TO VAR($tRoot;$tResult)
//SET TEXT TO PASTEBOARD($tResult)
//DOM CLOSE XML($tRoot)
//
//WEB SEND TEXT($tResult;"application/xml")
//Else 
//DOM EXPORT TO VAR($tRoot;$xBlob)
//SET TEXT TO PASTEBOARD($tResult)
//DOM CLOSE XML($tRoot)
//WEB SEND BLOB($xBlob;"application/xml")
//End if 
//
//End if 
//
//End if 
