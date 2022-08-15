//%attributes = {}
// ilb_generate_xls (->listbox;path)
// this method exports the table to be opened in Excel

C_POINTER:C301($listBoxPtr; $1)
C_TEXT:C284($tReportName; $2)
//C_TEXT($tPath;$2)

//C_TEXT($0)


C_LONGINT:C283($i; $j; $n; $m)
C_LONGINT:C283($i; $j; $iRows; $iCols; $iBackColor; $iAltColor; $iForeColor; $iDestination; $iTempField; $iTempTable; $iArea; $iTotalWidth)
C_LONGINT:C283($iStyle; $iSize; $iTable; $iType; $iView; $iWidth; $iRef; $iRecs)
C_POINTER:C301($ptrField)

C_REAL:C285($rPercent)
C_TEXT:C284($sAltColor)
C_TEXT:C284($tFormula; $tRef)
C_BOOLEAN:C305($bHorGrid; $bVertGrid)
C_BLOB:C604($xBlob)
C_TEXT:C284($headerName; $sDisplayFormat; $sAltColor; $sFont; $stylePrefix)

C_TEXT:C284(iLB_dataString)

$listBoxPtr:=$1

If (Count parameters:C259>=2)
	$tReportName:=$2
Else 
	$tReportName:=""
End if 

$iDestination:=qr printer:K14903:1


//TRACE

OK:=1  //init

$iRows:=LISTBOX Get number of rows:C915($listBoxPtr->)
$iCols:=LISTBOX Get number of columns:C831($listBoxPtr->)


//Case of 
//: ($tPath="")  //not set
//$tPath:=Temporary folder
//$tPath:=$tPath+"Listbox"+"_"+String($iCols)+"_recs.xls"
//: (Test path name($tPath)=Is a folder)
//$tPath:=$tPath+"Listbox"+"_"+String($iCols)+"_recs.xls"
//Else   //assume a complete file path
//
//End case 

//USE SET("UserSet")


C_DATE:C307($dDate)
C_TIME:C306($hTime)
C_TEXT:C284($tLocalTableName; $tCommand; $tFilePath; $tHeader; $tRef; $tFormula; $tReportName; $tVarName; $tableRef; $sqlStatement)
C_LONGINT:C283($i; $iAlign; $iAltColor; $iArraySize; $iBackColor; $iCalcType; $iColCount; $iCols; $iDestination; $iForeColor)

OBJECT GET RGB COLORS:C1074($listBoxPtr->; $iForeColor; $iBackColor; $iAltColor)
$sAltColor:=UTIL_Num2HexString($iAltColor)

C_TEXT:C284($stylePrefix)

If ($iRows>0)
	//RESOLVE POINTER($listBoxPtr;$varName;$iTable;$iField)
	$dDate:=Current date:C33
	$hTime:=Current time:C178
	
	$tLocalTableName:="_"+getApplicationUser+"_"+String:C10(Year of:C25($dDate))+String:C10(Month of:C24($dDate))+String:C10(Day of:C23($dDate))
	$tLocalTableName:=$tLocalTableName+Replace string:C233(String:C10($hTime; HH MM SS:K7:1); ":"; "")
	$tLocalTableName:=Substring:C12($tLocalTableName; 1; 31)  //just in case
	
	// initialize the arrays
	ARRAY TEXT:C222($arrHeaderNames; 0)
	ARRAY TEXT:C222($arrColNames; 0)
	ARRAY POINTER:C280($arrColVars; 0)
	ARRAY POINTER:C280($arrHeaderVars; 0)
	ARRAY BOOLEAN:C223($arrVisible; 0)
	ARRAY POINTER:C280($arrStyles; 0)
	
	ARRAY TEXT:C222($arrFooterNames; 0)
	ARRAY POINTER:C280($arrFooterVars; 0)
	ARRAY BOOLEAN:C223($arrColsVisible; 0)
	
	C_LONGINT:C283($i; $j)
	
	
	If (True:C214)  //8/20/18
		$sqlStatement:="DROP TABLE IF EXISTS "+$tLocalTableName
		
		Begin SQL
			EXECUTE IMMEDIATE :$sqlStatement
		End SQL
	End if 
	
	LISTBOX GET ARRAYS:C832($listBoxPtr->; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrVisible; $arrStyles)
	
	If (True:C214)  //create temp table
		
		$sqlStatement:="CREATE TABLE IF NOT EXISTS "+$tLocalTableName+" ("
		
		For ($i; 1; Size of array:C274($arrColNames))
			$sqlStatement:=$sqlStatement+"["+$arrColNames{$i}+"] "+UTIL_getSQLTypeName(Type:C295($arrColVars{$i}->))+","
		End for 
		
		$sqlStatement:=Substring:C12($sqlStatement; 1; Length:C16($sqlStatement)-1)+");"  //strip last comma and close the column def
		
		Begin SQL
			EXECUTE IMMEDIATE :$sqlStatement
		End SQL
	End if 
	
	
	If (False:C215)  //delete existing records - 3/11/19 removed from here and have it do after printing
		$tCommand:="TRUNCATE TABLE "+$tLocalTableName+";"
		
		Begin SQL
			EXECUTE IMMEDIATE :$tCommand
		End SQL
	End if 
	
	
	// INSERT DATA INTO local table from arrays
	//INSERT INTO MyTable (Fld1,Fld2,BoolFld,DateFld,TimeFld, InfoFld) VALUES( :vArrId, :vArrIdx, :vArrbool, :vArrdate, :vArrL, :vArrText);
	
	$iTable:=Table:C252(UTIL_getFieldPointer("["+$tLocalTableName+"]"))
	
	READ WRITE:C146(Table:C252($iTable)->)  //3/11/19
	
	$sqlStatement:="INSERT INTO "+$tLocalTableName+" ("
	// need to do the INSERT here
	For ($i; 1; Size of array:C274($arrColNames))
		
		If ($i=1)
			$iArraySize:=Size of array:C274($arrColVars{$i}->)
		Else 
			If (Size of array:C274($arrColVars{$i}->)>$iArraySize)  //<>TODO IBB 3/11/19
				//TRACE
				//need to truncate array
			End if 
		End if 
		
		//If (UTIL_isInsertBug(UTIL_get4DTypeFromSQLType($aiFieldTypes{$i})))  // | ($atFieldNames{$i}="UUID")  //currently bug with 4D
		//so don't use this field ... yet
		//Else 
		$sqlStatement:=$sqlStatement+"["+$arrColNames{$i}+"],"
		//End if 
		
	End for 
	
	$sqlStatement:=Substring:C12($sqlStatement; 1; Length:C16($sqlStatement)-1)+") VALUES("  //strip last comma and add closing paren
	
	For ($i; 1; Size of array:C274($arrColNames))
		
		//$iType:=UTIL_get4DTypeFromSQLType($aiFieldTypes{$i})
		
		//If (UTIL_isInsertBug($iType))  // | ($atFieldNames{$i}="UUID")  //currently bug with 4D
		//Else 
		//$ptrIntoArray:=iSQL_getColumnVar(Current method name;$i;$iType)
		RESOLVE POINTER:C394($arrColVars{$i}; $tVarName; $iTempTable; $iTempField)
		$sqlStatement:=$sqlStatement+":"+$tVarName+","
		//End if 
		
	End for 
	
	$sqlStatement:=Substring:C12($sqlStatement; 1; Length:C16($sqlStatement)-1)+");"  //strip last comma and add closing paren
	
	Begin SQL
		EXECUTE IMMEDIATE :$sqlStatement
	End SQL
	
	
	
	$iColCount:=LISTBOX Get number of columns:C831($listBoxPtr->)
	
	
	
	
	UNLOAD RECORD:C212(Table:C252($iTable)->)
	READ ONLY:C145(Table:C252($iTable)->)
	ALL RECORDS:C47(Table:C252($iTable)->)
	
	LISTBOX GET ARRAYS:C832($listBoxPtr->; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrColsVisible; $arrStyles; $arrFooterNames; $arrFooterVars)
	LISTBOX GET GRID:C1199($listBoxPtr->; $bHorGrid; $bVertGrid)
	
	$iArea:=QR New offscreen area:C735
	QR SET REPORT TABLE:C757($iArea; $iTable)
	
	
	
	
	//---- CALCULATE SCALING PERCENTAGE --------
	$iTotalWidth:=0
	$rPercent:=1  //default 100%
	
	For ($i; 1; $iColCount)  //calc total width
		$iWidth:=LISTBOX Get column width:C834(*; $arrColNames{$i})  //<---- LAST COLUMN MAYBE ADJUST???
		If ($i=$iColCount)  //last column
			$iTotalWidth:=$iTotalWidth+$iWidth
		Else 
			$iTotalWidth:=$iTotalWidth+$iWidth  //use scaling at print time if available
		End if 
	End for 
	
	If ($iTotalWidth>520)  //landscape
		If ($iTotalWidth>720)  //need to scale
			$rPercent:=756/$iTotalWidth
		End if 
	End if 
	
	
	
	
	For ($i; 1; $iColCount)
		
		$tFormula:=$arrColNames{$i}  //get the column field name
		//$ptrField:=UTIL_getFieldPointer ("["+$tLocalTableName+"]"+$tFormula)  //<--- doesn't seem to work with newly created tables in sql
		
		EXECUTE FORMULA:C63("$ptrField:=->["+$tLocalTableName+"]"+$tFormula)
		
		If (Not:C34(Is nil pointer:C315($ptrField)))
			$tHeader:=OBJECT Get title:C1068(*; $arrHeaderNames{$i})
			$iWidth:=LISTBOX Get column width:C834(*; $arrColNames{$i})  //<---- LAST COLUMN MAYBE ADJUST???
			$iWidth:=$iWidth*$rPercent  //scale
			
			//$iTotalWidth:=$iTotalWidth+$iWidth  //use scaling at print time if available
			
			$sDisplayFormat:=OBJECT Get format:C894(*; $arrColNames{$i})
			QR INSERT COLUMN:C748($iArea; $i; $ptrField)
			QR SET INFO COLUMN:C765($iArea; $i; $tHeader; $ptrField; 0; $iWidth; 0; $sDisplayFormat)
			
			
			//******** SET COLUMN HEADER TEXT PROPERTIES *********
			
			$sFont:=OBJECT Get font:C1069(*; $arrHeaderNames{$i})
			$iSize:=OBJECT Get font size:C1070(*; $arrHeaderNames{$i})
			$iSize:=Abs:C99(Round:C94($iSize*$rPercent; 0))
			
			$iStyle:=OBJECT Get font style:C1071(*; $arrHeaderNames{$i})
			$iAlign:=OBJECT Get horizontal alignment:C707(*; $arrHeaderNames{$i})  //this is setting OK=0 ???
			
			
			QR SET TEXT PROPERTY:C759($iArea; $i; qr title:K14906:1; qr font name:K14904:10; "Arial")  // changed by @tiran for v18 compatibility 
			//assigning the font size 10 points:
			QR SET TEXT PROPERTY:C759($iArea; $i; qr title:K14906:1; qr font size:K14904:2; Num:C11($iSize))
			//assigning the font style attributes:
			If ($iStyle=1) | ($iStyle=3) | ($iStyle=5)
				QR SET TEXT PROPERTY:C759($iArea; $i; qr title:K14906:1; qr bold:K14904:3; 1)
			End if 
			If ($iStyle=2) | ($iStyle=3) | ($iStyle=6)
				QR SET TEXT PROPERTY:C759($iArea; $i; qr title:K14906:1; qr italic:K14904:4; 1)
			End if 
			If ($iStyle=4) | ($iStyle=5) | ($iStyle=6)
				QR SET TEXT PROPERTY:C759($iArea; $i; qr title:K14906:1; qr underline:K14904:5; 1)
			End if 
			//assign alignment
			QR SET TEXT PROPERTY:C759($iArea; $i; qr title:K14906:1; qr justification:K14904:7; Abs:C99($iAlign-1))
			
			QR SET TEXT PROPERTY:C759($iArea; $i; qr title:K14906:1; qr background color:K14904:8; 0x00E5E5E5)
			QR SET BORDERS:C797($iArea; $i; qr title:K14906:1; qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+qr right border:K14908:3+qr inside horizontal border:K14908:6+qr inside vertical border:K14908:5; 1)
			
			
			// ******** SET COLUMN FOOTER TEXT PROPERTIES - USE THE SAME AS HEADER ********
			
			//QR SET TEXT PROPERTY($iArea;$i;qr grand total;_O_qr font;_O_Font number($sFont))
			QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr font name:K14904:10; "Arial")  // changed by @tiran  for v18 compatibility ; #modernize
			
			//assigning the font size 10 points:
			QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr font size:K14904:2; $iSize)
			//assigning the font style attributes:
			If ($iStyle=1) | ($iStyle=3) | ($iStyle=5)
				QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr bold:K14904:3; 1)
			End if 
			If ($iStyle=2) | ($iStyle=3) | ($iStyle=6)
				QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr italic:K14904:4; 1)
			End if 
			If ($iStyle=4) | ($iStyle=5) | ($iStyle=6)
				QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr underline:K14904:5; 1)
			End if 
			//assign alignment
			QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr justification:K14904:7; Abs:C99($iAlign-1))
			
			$iCalcType:=LISTBOX Get footer calculation:C1150(*; $arrColNames{$i})
			
			Case of 
				: ($iCalcType=lk footer count:K70:5)
					QR SET TOTALS DATA:C767($iArea; $i; qr grand total:K14906:3; qr count:K14901:5)
					QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr justification:K14904:7; $iAlign-1)  //assign alignment
				: ($iCalcType=lk footer sum:K70:4)
					QR SET TOTALS DATA:C767($iArea; $i; qr grand total:K14906:3; qr sum:K14901:1)
					QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr justification:K14904:7; $iAlign-1)  //assign alignment
				: ($iCalcType=lk footer average:K70:6)
					QR SET TOTALS DATA:C767($iArea; $i; qr grand total:K14906:3; qr average:K14901:2)
					QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr justification:K14904:7; $iAlign-1)  //assign alignment
				: ($iCalcType=lk footer max:K70:3)
					QR SET TOTALS DATA:C767($iArea; $i; qr grand total:K14906:3; qr max:K14901:4)
					QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr justification:K14904:7; $iAlign-1)  //assign alignment
				: ($iCalcType=lk footer min:K70:2)
					QR SET TOTALS DATA:C767($iArea; $i; qr grand total:K14906:3; qr min:K14901:3)
					QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr justification:K14904:7; $iAlign-1)  //assign alignment
			End case 
			
			QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr background color:K14904:8; 0x00E5E5E5)  //light grey background for column headers
			QR SET BORDERS:C797($iArea; $i; qr grand total:K14906:3; qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+qr right border:K14908:3+qr inside horizontal border:K14908:6+qr inside vertical border:K14908:5; 1)
			
			
			
			//****** SET DETAIL ROWS *********
			
			//set detail text properties
			$sFont:=OBJECT Get font:C1069(*; $arrColNames{$i})
			$iSize:=OBJECT Get font size:C1070(*; $arrColNames{$i})
			$iSize:=Abs:C99(Round:C94($iSize*$rPercent; 0))
			
			$iStyle:=OBJECT Get font style:C1071(*; $arrColNames{$i})
			$iAlign:=OBJECT Get horizontal alignment:C707(*; $arrColNames{$i})
			OBJECT GET RGB COLORS:C1074(*; $arrColNames{$i}; $iForeColor; $iBackColor; $iAltColor)
			
			//QR SET TEXT PROPERTY($iArea;$i;qr detail;_O_qr font;_O_Font number($sFont)) // #obsolete
			QR SET TEXT PROPERTY:C759($iArea; $i; qr detail:K14906:2; qr font name:K14904:10; "Arial")  // changed by @tiran for v18 ; #modernize
			
			//assigning the font size 10 points:
			QR SET TEXT PROPERTY:C759($iArea; $i; qr detail:K14906:2; qr font size:K14904:2; $iSize)
			//assigning the font style attributes:
			If ($iStyle=1) | ($iStyle=3) | ($iStyle=5)
				QR SET TEXT PROPERTY:C759($iArea; $i; qr detail:K14906:2; qr bold:K14904:3; 1)
			End if 
			If ($iStyle=2) | ($iStyle=3) | ($iStyle=6)
				QR SET TEXT PROPERTY:C759($iArea; $i; qr detail:K14906:2; qr italic:K14904:4; 1)
			End if 
			If ($iStyle=4) | ($iStyle=5) | ($iStyle=6)
				QR SET TEXT PROPERTY:C759($iArea; $i; qr detail:K14906:2; qr underline:K14904:5; 1)
			End if 
			
			//assign alignment
			QR SET TEXT PROPERTY:C759($iArea; $i; qr detail:K14906:2; qr justification:K14904:7; Abs:C99($iAlign-1))
			
			Case of 
				: ($bHorGrid) & ($bVertGrid)
					QR SET BORDERS:C797($iArea; $i; qr detail:K14906:2; qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+qr right border:K14908:3; 1)
				: ($bHorGrid)
					QR SET BORDERS:C797($iArea; $i; qr detail:K14906:2; qr bottom border:K14908:4+qr top border:K14908:2; 1)
					QR SET BORDERS:C797($iArea; $i; qr detail:K14906:2; qr left border:K14908:1+qr right border:K14908:3; 0)
				: ($bVertGrid)
					QR SET BORDERS:C797($iArea; $i; qr detail:K14906:2; qr left border:K14908:1+qr right border:K14908:3; 1)
					QR SET BORDERS:C797($iArea; $i; qr detail:K14906:2; qr bottom border:K14908:4+qr top border:K14908:2; 0)
				Else 
					QR SET BORDERS:C797($iArea; $i; qr detail:K14906:2; qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+qr right border:K14908:3+qr inside horizontal border:K14908:6+qr inside vertical border:K14908:5; 0)
			End case 
			
			QR SET TEXT PROPERTY:C759($iArea; $i; qr detail:K14906:2; qr alternate background color:K14904:9; $iAltColor)
		End if 
		
	End for 
	
	//********* SET PAGE HEADER TEXT PROPERTIES ********
	
	QR SET TEXT PROPERTY:C759($iArea; 1; qr header:K14906:4; qr font name:K14904:10; "Arial")  // changed by @tiran for v18 
	QR SET TEXT PROPERTY:C759($iArea; 1; qr header:K14906:4; qr font size:K14904:2; 12)  //assigning the font size 12 points:
	QR SET TEXT PROPERTY:C759($iArea; 1; qr header:K14906:4; qr bold:K14904:3; 1)  //assigning the font attribute Bold:
	QR SET HEADER AND FOOTER:C774($iArea; 1; ""; $tReportName; ""; 50)
	
	//********* SET  PAGE FOOTER TEXT PROPERTIES **********
	
	QR SET TEXT PROPERTY:C759($iArea; 1; qr footer:K14906:5; qr font name:K14904:10; "Arial")  // changed by @tiran for v18 ; #modernize
	QR SET TEXT PROPERTY:C759($iArea; 1; qr footer:K14906:5; qr font size:K14904:2; 10)  //assigning the font size 10 points:
	QR SET HEADER AND FOOTER:C774($iArea; 2; "Printed: #D"; ""; "Page: #P"; 12)
	
	
	OK:=1  //b/c getting changed above
	
	If ($iDestination=qr printer:K14903:1)
		QR SET DESTINATION:C745($iArea; $iDestination)
		
		If ($iTotalWidth>520)
			SET PRINT OPTION:C733(Orientation option:K47:2; 2)  //landscape
			
			If (False:C215)  //scaling handled above
				If ($iTotalWidth>710)
					SET PRINT OPTION:C733(Scale option:K47:3; ((710/$iTotalWidth)*100))  //assume a .5 inch margin plus a little bit to fit right border
				End if 
			End if 
			
		Else 
			SET PRINT OPTION:C733(Orientation option:K47:2; 1)  //portrait
		End if 
		
		OK:=1
		
	Else 
		QR SET DESTINATION:C745($iArea; $iDestination; $tFilePath)
	End if 
	
	
	If (OK=1)  //8/20/18 can probably ignore this now
		QR RUN:C746($iArea)
	Else 
		myAlert("Printer error: Please ensure that a default printer has been selected.")
	End if 
	
	
	If (False:C215)
		QR REPORT TO BLOB:C770($iArea; $xBlob)
		$tFilePath:=Get 4D folder:C485(Current resources folder:K5:16)+"test.4qr"
		BLOB TO DOCUMENT:C526($tFilePath; $xBlob)
		SHOW ON DISK:C922($tFilePath)
		QR REPORT:C197(Table:C252($iTable)->; Char:C90(1))  //$tFilePath)  //;$iArea)
	End if 
	
	
	QR DELETE OFFSCREEN AREA:C754($iArea)
	
	//$ptrTable:=UTIL_getFieldPointer ($tLocalTableName)
	//If (Not(Nil($ptrTable)))
	//TRUNCATE TABLE($ptrTable->)  //8/20/18 delete all records and clean up
	//End if 
	
	If (True:C214)  //8/20/18
		
		If (True:C214)  //delete existing records
			$tCommand:="TRUNCATE TABLE "+$tLocalTableName+";"
			
			Begin SQL
				EXECUTE IMMEDIATE :$tCommand
			End SQL
		End if 
		
		UNLOAD RECORD:C212(Table:C252($iTable)->)  //3/11/19
		REDUCE SELECTION:C351(Table:C252($iTable)->; 0)
		READ ONLY:C145(Table:C252($iTable)->)
		
		$sqlStatement:="DROP TABLE IF EXISTS "+$tLocalTableName
		
		Begin SQL
			EXECUTE IMMEDIATE :$sqlStatement
		End SQL
	End if 
	
Else 
	myAlert("There are no rows to export")
End if 



//$0:=$tPath