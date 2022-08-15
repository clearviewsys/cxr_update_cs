//%attributes = {"shared":true,"publishedSoap":true,"publishedWsdl":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 08/21/17, 16:35:11
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: Sync_Pull_WS
// Description
//     designed to be called from a remote site against a sync server
//    ; this will pull missing records to the remote site and bypass the sync queue
//

//    NOTE: This method must be copied to the host database
//          set the method properties to be offered as a Web Service, and copy the following text into it.  
//         Components can’t receive web service requests directly, so this method is needed to receive the 
//         request and pass along to the Sync component. --- per Jason Hect doc's

// Parameters
// ----------------------------------------------------



//DECLARATIONS
C_BLOB:C604(vblob_Sync_Request; vblob_Sync_Response)



//INITIALIZATION
SOAP DECLARATION:C782(vblob_Sync_Request; Is BLOB:K8:12; SOAP input:K46:1; "Sync_Request")
SOAP DECLARATION:C782(vblob_Sync_Response; Is BLOB:K8:12; SOAP output:K46:2; "Sync_Response")

//TRACE

//MAIN CODE
Sync_IsSyncProcess(True:C214)  //8/22/19 - v17 broke SOAP Request call from within nested methods

vblob_Sync_Response:=Sync_Pull(vblob_Sync_Request)

