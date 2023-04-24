//%attributes = {}
// ------------------------------------------------------------------------------
// Method: AUS_SetReportHeader 
// Generate the Report XML Header
// ------------------------------------------------------------------------------


C_TEXT:C284($1; $root)
C_TEXT:C284($2; $fileName)
C_TEXT:C284($3; $reportCode)
C_BOOLEAN:C305($4; $reportType)


Case of 
		
	: (Count parameters:C259=1)
		
		$root:=$1
		
		// Report codes: 
		// TTR-MSB: Threshold Transaction Report For Money Services Business
		// 
		// 
		
		$reportCode:="TTR-MSB"
		$reportType:=True:C214
		
		C_TEXT:C284($fileName)
		
	: (Count parameters:C259=2)
		
		$root:=$1
		$fileName:=$2
		$reportCode:="TTR-MSB"
		$reportType:=True:C214
		
	: (Count parameters:C259=3)
		
		$root:=$1
		$fileName:=$2
		$reportCode:=$3
		$reportType:=True:C214
		
	: (Count parameters:C259=4)
		
		$root:=$1
		$fileName:=$2
		$reportCode:=$3
		$reportType:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
ARRAY TEXT:C222($arrRecords; 0)
C_LONGINT:C283($p)
C_TEXT:C284($element; $n)


$element:=GAML_CreateXMLNode($root; "reNumber"; ->reportingEntityID)

$p:=Position:C15($reportCode; $fileName)
$fileName:=Substring:C12($fileName; $p)
$element:=GAML_CreateXMLNode($root; "fileName"; ->$fileName)

// Number of transactions reported

Case of 
	: ($reportCode="TTR-MSB")
		DISTINCT VALUES:C339([Registers:10]CustomerID:5; $arrRecords)
		
	: ($reportCode="IFTI-DRA")
		If ($reportType)
			SELECTION TO ARRAY:C260([eWires:13]CustomerID:15; $arrRecords)
		Else 
			SELECTION TO ARRAY:C260([Wires:8]CustomerID:2; $arrRecords)
		End if 
		
		
	: ($reportCode="SRM")
		SELECTION TO ARRAY:C260([AML_Reports:119]CustomerID:19; $arrRecords)
		
End case 


//$n:=String(Size of array($arrRecords))
$n:=String:C10(Records in selection:C76([Registers:10]))
$element:=GAML_CreateXMLNode($root; "reportCount"; ->$n)


