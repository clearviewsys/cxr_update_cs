//%attributes = {"publishedSoap":true,"publishedWsdl":true}
//METHOD COMMENTS
//Receive Sync Request from remote server

//main SYNC component web service

//DECLARATIONS
C_BLOB:C604(vblob_Sync_Request; vblob_Sync_Response)

//TRACE

//INITIALIZATION
SOAP DECLARATION:C782(vblob_Sync_Request; Is BLOB:K8:12; SOAP input:K46:1; "Sync_Request")
SOAP DECLARATION:C782(vblob_Sync_Response; Is BLOB:K8:12; SOAP output:K46:2; "Sync_Response")

//MAIN CODE
//SYNC_Log (Current method name+" START";SYNC_Get_MemoryStats )
Sync_IsSyncProcess(True:C214)  //8/22/19 - v17 broke SOAP Request call from within nested methods

vblob_Sync_Response:=Sync_Receive(vblob_Sync_Request)

//SYNC_Log (Current method name+" END";SYNC_Get_MemoryStats )