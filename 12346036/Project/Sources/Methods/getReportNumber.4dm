//%attributes = {}
// getReportNumber($subHeaderSeq;$relatedToIran;$suffix;$reportType="lctr")
// Generate the report number

C_LONGINT:C283($1; $seq)
C_BOOLEAN:C305($2; $isRelatedIran)
C_TEXT:C284($3; $suffix; $0)
C_TEXT:C284($4; $reportType)
C_REAL:C285($amount)

Case of 
	: (Count parameters:C259=2)
		
		$seq:=$1
		$isRelatedIran:=$2
		$suffix:=""
		$reportType:="lctr"
		
	: (Count parameters:C259=3)
		
		$seq:=$1
		$isRelatedIran:=$2
		$suffix:=$3
		$reportType:="lctr"
		
	: (Count parameters:C259=4)
		
		$seq:=$1
		$isRelatedIran:=$2
		$suffix:=$3
		$reportType:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($reportNumType; $reportSeqstr)

$reportNumType:=getKeyValue("FT.ReportNumber"; "INVOICE")
//$isRelatedIran:=false


//If ((FT_SumUsingMarketRate ([Invoices]InvoiceID)<[ServerPrefs]twoIDsLimit) | ($suffix="S"))

Case of 
		
	: ($reportType="lctr")
		$amount:=FT_SumUsingMarketRate([Invoices:5]InvoiceID:1)
		
	: ($reportType="ewire")
		$amount:=[eWires:13]amountLocal:45
		
	: ($reportType="wire")
		$amount:=[Wires:8]AmountLocal:25
		
	: ($reportType="str")
		$amount:=FT_SumUsingMarketRate([Invoices:5]InvoiceID:1)
		
End case 


If ($reportNumType="INVOICE")
	
	$reportSeqstr:=[Invoices:5]InvoiceID:1+FT_StringFormat(String:C10($seq); 2; "_"; "RJ")+$suffix
	
	If ($isRelatedIran)
		
		If (($amount<[ServerPrefs:27]twoIDsLimit:15) | ($suffix="S"))
			$reportSeqstr:=FT_StringFormat("IR2020"+$reportSeqstr; 20; " "; "LJ")
		Else 
			$reportSeqstr:=FT_StringFormat($reportSeqStr; 20; " "; "LJ")
		End if 
		
	Else 
		$reportSeqstr:=FT_StringFormat($reportSeqStr; 20; " "; "LJ")
	End if 
	
Else 
	$reportSeqStr:=String:C10(FT_NextSequence("FINTRAC_ReportSeq"))
	
	If ($isRelatedIran)
		//If ((FT_SumUsingMarketRate ([Invoices]InvoiceID)<[ServerPrefs]twoIDsLimit) | ($suffix="S"))
		If (($amount<[ServerPrefs:27]twoIDsLimit:15) | ($suffix="S"))
			$reportSeqstr:=FT_StringFormat("IR2020R"+$reportSeqstr; 20; " "; "LJ")
		Else 
			$reportSeqstr:=FT_StringFormat("R"+$reportSeqStr; 20; " "; "LJ")
		End if 
		
	Else 
		$reportSeqstr:=FT_StringFormat("R"+$reportSeqStr; 20; " "; "LJ")
	End if 
	
End if 

$0:=$reportSeqstr