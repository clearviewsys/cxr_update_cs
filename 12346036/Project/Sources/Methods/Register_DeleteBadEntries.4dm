//%attributes = {"publishedWeb":true}
// Project Method: Register_DeleteBadEntries

// Searching for answers? Be sure to check out the "About..." menu located in the
// Apple menu (Macintosh) or the Help menu (Windows). There you can find online
// help for this example database, as well as a listing of numerous 4D resources
// available to you.

// Method created by Dave Batton, DataCraft

// Find any entries that have no data.  We do a lot of error checking to try to
//   prevent blank entries, but there's still ways for them to creep in.  We call 
//   this from a few places (like when switching between accounts) to try to
//   keep the data clean.
// We do this across all accounts, rather than just on the current account, since
//  it's harmless and faster than doing just one account.


MESSAGES OFF:C175
QUERY:C277([Cheques:1]; [Cheques:1]ChequeNumber:4=""; *)
QUERY:C277([Cheques:1];  & ; [Cheques:1]InvoiceID:5=""; *)
QUERY:C277([Cheques:1];  & ; [Cheques:1]RegisterID:6=""; *)
QUERY:C277([Cheques:1];  & ; [Cheques:1]AccountID:7=""; *)
QUERY:C277([Cheques:1];  & ; [Cheques:1]Amount:8=0; *)
QUERY:C277([Cheques:1];  & ; [Cheques:1]Currency:9=0)
DELETE SELECTION:C66([Cheques:1])
MESSAGES ON:C181