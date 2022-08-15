//%attributes = {"publishedSoap":true,"publishedWsdl":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 11/09/13, 16:25:55
// ----------------------------------------------------
// Method: SYNC_RecordList_WS
// Description
// 
//    NOTE: This method must be copied to the host database
//          set the method properties to be offered as a Web Service, and copy the following text into it.  
//         Components can’t receive web service requests directly, so this method is needed to receive the 
//         request and pass along to the Sync component. --- per Jason Hect doc's
//
// Parameters
// ----------------------------------------------------



//METHOD COMMENTS
//Receive Record List Request from remote server

//DECLARATIONS
C_TEXT:C284(SYNC_sPassword)
C_TEXT:C284(SYNC_sSiteID)
C_LONGINT:C283(SYNC_iTable)
C_DATE:C307(SYNC_dStart)  //3/7/16
C_DATE:C307(SYNC_dEnd)  //2/24/17


ARRAY TEXT:C222(SYNC_atRecordList; 0)
ARRAY TEXT:C222(SYNC_atRecordHash; 0)

//INITIALIZATION
SOAP DECLARATION:C782(SYNC_sPassword; Is string var:K8:2; SOAP input:K46:1; "Sync_Password")
SOAP DECLARATION:C782(SYNC_sSiteID; Is string var:K8:2; SOAP input:K46:1; "Sync_SiteID")
SOAP DECLARATION:C782(SYNC_iTable; Is longint:K8:6; SOAP input:K46:1; "Sync_TableNum")
SOAP DECLARATION:C782(SYNC_dStart; Is date:K8:7; SOAP input:K46:1; "Sync_StartDate")
//SOAP DECLARATION(SYNC_dEnd;Is date;SOAP input;"Sync_StartEnd")
SOAP DECLARATION:C782(SYNC_dEnd; Is date:K8:7; SOAP input:K46:1; "Sync_EndDate")

SOAP DECLARATION:C782(SYNC_atRecordList; Text array:K8:16; SOAP output:K46:2; "Sync_RecordList_Response")
SOAP DECLARATION:C782(SYNC_atRecordHash; Text array:K8:16; SOAP output:K46:2; "Sync_HashList_Response")  //5/22/20

//MAIN CODE

Sync_IsSyncProcess(True:C214)  //8/22/19 - v17 broke SOAP Request call from within nested methods

Sync_Validation_getRecordList(->SYNC_atRecordList; SYNC_sSiteID; SYNC_sPassword; SYNC_iTable; SYNC_dStart; SYNC_dEnd; ->SYNC_atRecordHash)