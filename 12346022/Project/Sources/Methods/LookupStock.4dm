//%attributes = {}
//

// Method source code automatically generated by the 4D SOAP wizard.

//


// ----------------------------------------------------------------

C_BLOB:C604($1)
C_BLOB:C604($0)

WEB SERVICE SET PARAMETER:C777("BlobAsXMLIn"; $1)

WEB SERVICE CALL:C778("http://www.xignite.com/xsecurity.asmx"; "http://www.xignite.com/services/LookupStock"; "LookupStock"; ""; Web Service manual:K48:4)

If (OK=1)
	WEB SERVICE GET RESULT:C779($0; "BlobAsXMLOut"; *)  // Memory clean-up on the final return value.

End if 