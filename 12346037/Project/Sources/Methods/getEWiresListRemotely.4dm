//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/12/15, 09:22:22
// ----------------------------------------------------
// Method: eWiresGetListRemotely
// Description
// 
//     eWiresGetListRemotely 
//    display -> (fromCountry; toCountry; fromDate; toDate; isFetched; isSettled)
//
//    The above method will return a list of eWires that match the given criteria. We 
//    like to be able to see those in a listbox view.
//
//    This is for a head office to see the total amount of eWire payable they have eve
//    without accessing the eWire server. Eventually I don’t want administrators to co
//    to eWire and manipulate the data there.
//
//     calls webservice and gets a blob back -- xml bags of arrays

// Parameters
// ----------------------------------------------------


C_BLOB:C604($xBlob)
C_TEXT:C284($tXML)


$xBlob:=WS_Remote_List_Load


$tXML:=XB_BlobToBag($xBlob)


//get item list... tag names = field names?
//loop thru and fill arrays for listbox
