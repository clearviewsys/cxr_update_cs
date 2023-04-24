//%attributes = {}
/*
When adding new servers to the list of screening check, you need to deal with

sl_chooseSLCollByOption
» removes sanction list if it not applicable (ie. person or entity)

sl_screenWithSanctionListCol
new sl_screenAgainst{server name} method
» the actual calling the server for name screening

SanctionListResult.new()
» sort the result log by sever used into collection

SanctionListResult.displayResults() method (prep half)
new sl_format{server name}Result
» formats the result for display

[SanctionCheckLog]View
SanctionScreenResult form lb_summary
new SanctionList{Server} Form (width 700, height 525)
SanctionScreenResult form new page
» display the result (see point above)

SanctionListResult.displayResults() method (clean up half)
» updates the information added when result is being viewed.

SanctionListResult.save()
» saves the result
» edits other tables

[SanctionLists]Entry
[SanctionLists]View
» show and edit option of the Sanction List

CXR_checkSanctionList
» allows the result to be sent as a JSON object. 
» preferly only send the result of the HTTP Request method.

*/
