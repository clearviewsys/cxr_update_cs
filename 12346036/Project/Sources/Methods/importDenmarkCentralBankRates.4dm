//%attributes = {}

// ------------------------------------------------------------------------------
// Method: importDenmarkCentralBankRates: 
//         Read an XML file from an URL and replaces sportRate in Currencies
// 
// ------------------------------------------------------------------------------
// Jaime Alvarez, March 18/2015
// ------------------------------------------------------------------------------


C_TIME:C306($docRef)
C_TEXT:C284($name; $prefix; $file; $dailyRateDate; $msg)
C_LONGINT:C283($httpResponse)

// Variables to read the xml file

C_TEXT:C284(url; xmlData)
ARRAY TEXT:C222(attrNames; 0)
ARRAY TEXT:C222(attrValues; 0)

// Local variables
C_LONGINT:C283($goodCount; $badCount)
C_TEXT:C284($code; $desc; $rate)
C_TEXT:C284($tempDir)

$goodCount:=0
$badCount:=0


// Set a directory where the app will write temporal files
$tempDir:=Temporary folder:C486

// Set the URL, It is possible to read it from a [preferences] table.
url:="http://www.nationalbanken.dk/_vti_bin/DN/DataService.svc/CurrencyRatesXML?lang=da"

// Request to external web server
$httpResponse:=getXML

If ($httpResponse=0)  // Response ok?
	
	$file:=$tempDir+"response.xml"
	$docRef:=Create document:C266($file)
	
	If (OK=1)
		SEND PACKET:C103($docRef; xmlData)  // Write one word in the document
		CLOSE DOCUMENT:C267($docRef)  // Close the document
	End if 
	
	// Open and Read XML File
	$docRef:=Open document:C264($file; Read mode:K24:5)
	
	If (OK=1)
		
		Repeat 
			// Read XML Node Info
			MyEvent:=SAX Get XML node:C860($docRef)
			
			Case of 
				: (MyEvent=XML start document:K45:7)
					// Ignore Event
					
				: (MyEvent=XML comment:K45:8)
					// Ignore Event
					
				: (MyEvent=XML start element:K45:10)
					
					// Get Element Info
					SAX GET XML ELEMENT:C876($docRef; $name; $prefix; attrNames; attrValues)
					$name:=Lowercase:C14($name)
					
					Case of 
							
						: ($name="dailyrates")
							
							// Get Date Info
							$dailyRateDate:=attrValues{1}
							
						: ($name="currency")
							
							// Get rate Info
							$code:=attrValues{1}
							$desc:=attrValues{2}
							$rate:=attrValues{3}
							
							// Create record in database
							If (updateCurrSpotRate($dailyRateDate; $code; $rate))
								$goodCount:=$goodCount+1
							Else 
								$badCount:=$badCount+1
							End if 
							
					End case 
					
				: (MyEvent=XML end element:K45:11)
					// Ignore Event
					
			End case 
			
		Until (MyEvent=XML end document:K45:15)
		CLOSE DOCUMENT:C267($docRef)
		
		$msg:=String:C10($goodCount)+" Record(s) has been imported successfully. \n"
		$msg:=$msg+String:C10($badCount)+" Record(s) have been rejected."
		myAlert($msg)
		
	Else 
		
		myAlert("Error when opening a temporal file. Try again")
		
	End if 
	
Else 
	
	myAlert("URL to update rates is not available, try again. \n\nUrl: "+url+" \n\nError code: "+String:C10(gError))
	
End if 

