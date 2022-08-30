//%attributes = {}
//OBJECT SET VISIBLE(*;"updateSpot";True)
//ALL RECORDS([Currencies])
//QUERY([Currencies];[Currencies]AutoUpdateOurRates=True)
updateAllCurrenciesRates
//updateSelectedQuotesUsingYahoo 
//updateTableUsingMethod
//OBJECT SET VISIBLE(*;"updateSpot";False)
//vLastUpdate:=String(Current date;"Short")+" at "+String(Current time)
setLastUpdate
