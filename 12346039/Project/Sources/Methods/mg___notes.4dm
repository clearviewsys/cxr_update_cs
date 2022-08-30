//%attributes = {}
// process for web create webewire for MG

//https://clearviewsys.atlassian.net/wiki/spaces/SUP/pages/2498854913/MoneyGram+integration

// get quote and store in object
mgGetQuote

// use quote to prefill create-webewire-quote.shtml

// need to stage before they complete online form
// object method:mgSend.btn_soap
// add property to object to stage: formFreeStaging
mgBuildSendRequestTransaction
// get transferID 

mgGetSendRequestMethodInfo  // this is extra fields

mgHndlSendRequestMissingParams  // compares existing to required and returns missing fields in object

// use that object to build custom fields on web form


// on submit/create - then create webewire 


//mgWebArea form object method everything is here for data collection

//then call -- actually use this code as basis for new method
mgCreateWebEWire

// look at examples on dev that milan has created