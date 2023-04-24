//C_OBJECT($soapAPI_result)

//$soapAPI_result:=mgCheckReferenceNumber (Form.object.referenceNumber;Form.credentials)

//If ($soapAPI_result.success)

//If ($soapAPI_result.result.TransferState="40")

//Else 
//myAlert ("Transfer not available.\n\n TransferState is "+$soapAPI_result.result.TransferState)
//End if 

//Else 

//myAlert ("MG SOAP API error: "+$soapAPI_result.error)

//End if 
