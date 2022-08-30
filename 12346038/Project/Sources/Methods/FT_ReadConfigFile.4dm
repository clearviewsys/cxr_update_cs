//%attributes = {}
// FT_ReadConfigFile
// 
// Parses a config file and creates a 2D array with key value pairs 
// config file should look like: 
// [KEY]=[VALUE] 
// Before and after the = sign are spaces and tabs allowed 
// the VALUE can have an = sign. 
// Lines starting with a # are comment. 
// Lines starting with #include include another config file. 
// Invalid lines are silently ignored. 
//
// $1 = filename 
// $2 = pointer to array settings array 
// $0 = result 
//
// Config File Example: 
//
// [FINTRAC]
// # Reporting Entity Information
// ReportingEntityPKI=987654321
// ReportingEntityID=12345
// ReportingEntityName=A&B Money Exchange Ltd.
// #Contact Information
// ContactSurname=Blanc
// ContactName=Jean-Michel
// ContactPhone=888-390-840
// ContactExtension=00000
// 

C_TEXT:C284($1; $fileName)
C_POINTER:C301($2; $arrKeysPtr; $3; $arrValuesPtr)
C_BOOLEAN:C305($0; $ok; $match)


C_BLOB:C604($blob)
C_TEXT:C284($regExp; $regExpKey; $regExpValue; $fileText; $entry; $token; $downloadUpdates)
C_LONGINT:C283($i; $j; $k)

ARRAY TEXT:C222($line; 0)
ARRAY LONGINT:C221($arrPosition; 0)
ARRAY LONGINT:C221($arrLength; 0)
ARRAY TEXT:C222($arrTokens; 0)


Case of 
	: (Count parameters:C259=3)
		$fileName:=$1
		$arrKeysPtr:=$2
		$arrValuesPtr:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Does our target file exist? 
$ok:=Test path name:C476($fileName)=Is a document:K24:1

C_TEXT:C284($austracFile; $shutdownFile; $fijiFile)
If (Not:C34($ok))
	
	C_TEXT:C284($tmp)
	C_TEXT:C284($gamlFile; $fintracFile; $tmp)
	C_TIME:C306($vhdoc)
	
	$gamlFile:=Get 4D folder:C485(Active 4D Folder:K5:10)+"goaml.ini"
	$fintracFile:=Get 4D folder:C485(Active 4D Folder:K5:10)+"fintrac.ini"
	$austracFile:=Get 4D folder:C485(Active 4D Folder:K5:10)+"austrac.ini"
	$shutdownFile:=Get 4D folder:C485(Active 4D Folder:K5:10)+"shutdown.ini"
	$downloadUpdates:=Get 4D folder:C485(Active 4D Folder:K5:10)+"DownloadUpdates.ini"
	$fijiFile:=Get 4D folder:C485(Active 4D Folder:K5:10)+"fiji.ini"
	
	Case of 
		: ($fileName=$gamlFile)
			$tmp:="[GOAML]"+CRLF
			
			$tmp:=$tmp+"reportingEntityPKI=1234567890"+CRLF
			$tmp:=$tmp+"reportingEntityName=MY COMPANY LTD"+CRLF
			
			$tmp:=$tmp+"contactTitle=CONTACT Title"+CRLF
			$tmp:=$tmp+"contactGivenName=First Name"+CRLF
			$tmp:=$tmp+"contactOtherName="+CRLF
			$tmp:=$tmp+"contactSurname=CONTACT Last Name"+CRLF
			$tmp:=$tmp+"contactEMail=CONTACT@gmail.com"+CRLF
			$tmp:=$tmp+"contactOccupation="+CRLF
			$tmp:=$tmp+"contactNationality="+CRLF
			
			$tmp:=$tmp+"finalDate=11/01/2017"+CRLF
			
			$vhdoc:=Create document:C266($fileName)
			SEND PACKET:C103($vhdoc; $tmp)  // Write one word in the document 
			CLOSE DOCUMENT:C267($vhdoc)  // Close the document 
			
		: ($fileName=$fintracFile)
			
			$tmp:="[FINTRAC]"+CRLF
			
			$tmp:=$tmp+"reportingEntityPKI=1234567890"+CRLF
			$tmp:=$tmp+"reportingEntityCertificateID=1234567"+CRLF
			$tmp:=$tmp+"reportingEntityName=MY COMPANY LTD"+CRLF
			$tmp:=$tmp+"reportingEntityLocationNumber=00"+CRLF
			$tmp:=$tmp+"reportingEntityLocationName=My Location Name"+CRLF
			
			$tmp:=$tmp+"contactSurname=CONTACT SURNAME"+CRLF
			$tmp:=$tmp+"contactGivenName=CONTACT NAME"+CRLF
			$tmp:=$tmp+"contactOtherName="+CRLF
			$tmp:=$tmp+"contactPhoneNumber=999-999-9999"+CRLF
			$tmp:=$tmp+"contactPhoneNumberExt=0000"+CRLF
			
			$vhdoc:=Create document:C266($fileName)
			SEND PACKET:C103($vhdoc; $tmp)  // Write one word in the document 
			CLOSE DOCUMENT:C267($vhdoc)  // Close the document 
			
		: ($fileName=$fijiFile)
			
			$tmp:="[FIJI]"+CRLF
			
			$tmp:=$tmp+"reportingEntityPKI=1234567890"+CRLF
			$tmp:=$tmp+"reportingEntityCertificateID=1234567"+CRLF
			$tmp:=$tmp+"reportingEntityName=MY COMPANY LTD"+CRLF
			$tmp:=$tmp+"reportingEntityLocationNumber=00"+CRLF
			$tmp:=$tmp+"reportingEntityLocationName=My Location Name"+CRLF
			
			$tmp:=$tmp+"contactSurname=CONTACT SURNAME"+CRLF
			$tmp:=$tmp+"contactGivenName=CONTACT NAME"+CRLF
			$tmp:=$tmp+"contactOtherName="+CRLF
			$tmp:=$tmp+"contactPhoneNumber=999-999-9999"+CRLF
			$tmp:=$tmp+"contactPhoneNumberExt=0000"+CRLF
			
			$vhdoc:=Create document:C266($fileName)
			SEND PACKET:C103($vhdoc; $tmp)  // Write one word in the document 
			CLOSE DOCUMENT:C267($vhdoc)  // Close the document 
			
			
		: ($fileName=$austracFile)
			
			$tmp:="[AUSTRAC]"+CRLF
			
			$tmp:=$tmp+"reportingEntityPKI=1234567890"+CRLF
			$tmp:=$tmp+"reportingEntityCertificateID=1234567"+CRLF
			$tmp:=$tmp+"reportingEntityName=MY COMPANY LTD"+CRLF
			$tmp:=$tmp+"reportingEntityLocationNumber=00"+CRLF
			$tmp:=$tmp+"reportingEntityLocationName=My Location Name"+CRLF
			
			$tmp:=$tmp+"contactSurname=CONTACT SURNAME"+CRLF
			$tmp:=$tmp+"contactGivenName=CONTACT NAME"+CRLF
			$tmp:=$tmp+"contactOtherName="+CRLF
			$tmp:=$tmp+"contactPhoneNumber=999-999-9999"+CRLF
			$tmp:=$tmp+"contactPhoneNumberExt=0000"+CRLF
			
			$vhdoc:=Create document:C266($fileName)
			SEND PACKET:C103($vhdoc; $tmp)  // Write one word in the document 
			CLOSE DOCUMENT:C267($vhdoc)  // Close the document 
			
			
		: ($fileName=$shutdownFile)
			
			$tmp:="[SHUTDOWN]"+CRLF
			
			$tmp:=$tmp+"useUPSShutdown=0"+CRLF
			$vhdoc:=Create document:C266($fileName)
			SEND PACKET:C103($vhdoc; $tmp)  // Write one word in the document 
			CLOSE DOCUMENT:C267($vhdoc)  // Close the document 
			
		: ($fileName=$downloadUpdates)
			
			$tmp:="[UPDATES]"+CRLF
			$tmp:=$tmp+"cxrVersion=https://contattafiles.s3.us-west-1.amazonaws.com/tnt2425/0uRwZYPR1HHh42a/CXR4935.zip"+CRLF
			$tmp:=$tmp+"cxrResources=https://contattafiles.s3.us-west-1.amazonaws.com/tnt2425/0uRwZYPR1HHh42a/Resources.zip"+CRLF
			$tmp:=$tmp+"cxrComponents=https://contattafiles.s3.us-west-1.amazonaws.com/tnt2425/0uRwZYPR1HHh42a/Components.zip"+CRLF
			$tmp:=$tmp+"cxrPlugins=https://contattafiles.s3.us-west-1.amazonaws.com/tnt2425/0uRwZYPR1HHh42a/Plugins.zip"+CRLF
			
			$vhdoc:=Create document:C266($fileName)
			SEND PACKET:C103($vhdoc; $tmp)  // Write one word in the document 
			CLOSE DOCUMENT:C267($vhdoc)  // Close the document 
			
	End case 
	
End if 

// load the data 
DOCUMENT TO BLOB:C525($fileName; $blob)
$ok:=(OK=1)
$fileText:=BLOB to text:C555($blob; UTF8 text without length:K22:17)
$fileText:=Replace string:C233($fileText; Char:C90(CR ASCII code:K15:14); "|")
$fileText:=Replace string:C233($fileText; Char:C90(LF ASCII code:K15:11); "")
FT_ExplodeString($fileText; "|"; ->$arrTokens)

C_LONGINT:C283($pos; $len)
// get the values 
If ($ok)
	
	$regExp:="^([^#].*?)\\s*=\\s*(.*)$"
	
	For ($k; 1; Size of array:C274($arrTokens))
		
		$token:=$arrTokens{$k}
		$match:=Match regex:C1019($regExp; $token; 1; $arrPosition; $arrLength)
		
		If ($match)
			
			// Get the Key part of $entry (left side)
			// i.e.: if $entry is ReportingEntityPKI=987654321 it will take "ReportingEntityPKI"
			
			$regExpKey:="^\\s*([A-Za-z0-9]*)\\s*="
			$match:=Match regex:C1019($regExpKey; $token; 1; $pos; $len)
			APPEND TO ARRAY:C911($arrKeysPtr->; Substring:C12($token; $pos; $len-1))
			
			
			// Get the Value part of $entry (right side) 
			// i.e.: if $entry is ReportingEntityPKI=987654321 it will take "987654321"
			
			$regExpValue:="=\\s*([A-Za-z0-9.&\\/ '\\-:@]*)"
			$match:=Match regex:C1019($regExpValue; $token; 1; $pos; $len)
			APPEND TO ARRAY:C911($arrValuesPtr->; Substring:C12($token; $pos+1; $len))
			
		End if 
		
	End for 
	
	
End if 

$0:=$ok