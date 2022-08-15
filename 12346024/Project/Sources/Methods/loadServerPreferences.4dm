//%attributes = {}

// initServerPrefsVars
READ ONLY:C145([ServerPrefs:27])
ALL RECORDS:C47([ServerPrefs:27])
If (Records in selection:C76([ServerPrefs:27])=0)
	READ WRITE:C146([ServerPrefs:27])
	CREATE RECORD:C68([ServerPrefs:27])
	[ServerPrefs:27]errorTolerance:4:=0.35  // 35 % 
	[ServerPrefs:27]smtpFromEmail:6:="support@clearviewsys.com"
	[ServerPrefs:27]smtpPassword:8:="easyAS123!"  //"matifer2k4DCXR1324!#@$"  //"Vancouver2018"  // on 6/1/2019 I changed it to the Same as CXR designer
	[ServerPrefs:27]smtpServer:5:="mail.smtp2go.com"  //"smtp.gmail.com"
	[ServerPrefs:27]smtpUserName:7:="noreply@clearviewsys.com"  //"cvs.web.testing"
	[ServerPrefs:27]smtpPortNo:71:=2525  //587
	[ServerPrefs:27]starteWireNumber:3:=1000000
	[ServerPrefs:27]startInvoiceNumber:1:=100000
	[ServerPrefs:27]startRegisterNumber:2:=10000000
	[ServerPrefs:27]updateFrequency:9:=60  // update every 690 mins
	[ServerPrefs:27]InactivityTimeAllowed:10:=Time:C179("00:30:00")
	
	// inactivity time on the web server
	[ServerPrefs:27]updateSource:11:=""  // source of update
	[ServerPrefs:27]doFINTRACchecks:13:=False:C215
	[ServerPrefs:27]oneIDLimit:14:=3000
	[ServerPrefs:27]twoIDsLimit:15:=10000
	[ServerPrefs:27]declarationFormLimit:16:=100000
	[ServerPrefs:27]LimitForSS:73:=1000
	
	[ServerPrefs:27]minUpdateTime:17:=45
	[ServerPrefs:27]isLogEnabled:18:=False:C215
	[ServerPrefs:27]chargeLeg:19:=3  // commission on both buy and sell
	[ServerPrefs:27]cashFaultTolerance:20:=1000000000
	
	[ServerPrefs:27]tax1Name:21:="HST"
	[ServerPrefs:27]tax1:22:=0.12
	[ServerPrefs:27]tax2Name:23:="_"
	[ServerPrefs:27]tax2:24:=0
	[ServerPrefs:27]roundDigitBaseCurrency:25:=2  // assume it's CAD
	
	[ServerPrefs:27]panelRatesInputFile:26:=""
	[ServerPrefs:27]panelRatesOutputFolder:27:=""
	[ServerPrefs:27]warningLevel:28:=1
	[ServerPrefs:27]doAutoChequePrinting:29:=False:C215
	[ServerPrefs:27]doAutoInvoicePrinting:30:=False:C215
	[ServerPrefs:27]defaultBuyCommission:31:=5
	[ServerPrefs:27]defaultSellCommission:32:=5
	[ServerPrefs:27]defaultBuyOffset:48:=0
	[ServerPrefs:27]defaultSellOffset:49:=0
	
	[ServerPrefs:27]totalCashRegisters:33:=0
	[ServerPrefs:27]fromDate:34:=calcBOYear(Current date:C33)  // beginning of year
	[ServerPrefs:27]toDate:35:=Add to date:C393([ServerPrefs:27]fromDate:34; 1; 0; 0)  // end of year
	[ServerPrefs:27]applyDateRange:36:=False:C215
	[ServerPrefs:27]isRefreshRatesOnByDefault:42:=False:C215
	[ServerPrefs:27]receiptFootnote:43:="Please verify your receipt and money before leaving the counter. "+CRLF+"Thank you for your business. "
	[ServerPrefs:27]defaultBuyMethod:47:=c_Cash
	[ServerPrefs:27]defaultSellMethod:54:=c_Cash
	
	[ServerPrefs:27]defaultBuyCurrency:45:="USD"
	[ServerPrefs:27]defaultSellCurrency:46:="USD"
	
	[ServerPrefs:27]customCurrencyFlag1:50:="USD"
	[ServerPrefs:27]customCurrencyFlag2:51:="EUR"
	
	[ServerPrefs:27]defaultCommission:53:=0
	[ServerPrefs:27]defaultFlatFee:52:=0
	[ServerPrefs:27]useSentenceForACG:55:=False:C215
	[ServerPrefs:27]useCommissionRules:56:=False:C215
	[ServerPrefs:27]doAskCustIDForCheque:57:=True:C214
	[ServerPrefs:27]doWarnOnShortSelling:58:=True:C214
	
	[ServerPrefs:27]dateEntryFilter:60:="!1&9##/##/####"
	[ServerPrefs:27]dateFormat:59:=2  // system date abbreviated
	[ServerPrefs:27]queryLimit:61:=100
	[ServerPrefs:27]doAskSigningWithTill:62:=True:C214
	[ServerPrefs:27]doCheckSanctionLists:63:=False:C215
	[ServerPrefs:27]doCheckOSFI:64:=False:C215
	[ServerPrefs:27]doCheckCustomerProfile:66:=False:C215
	[ServerPrefs:27]doCheck24HrsRule:67:=False:C215
	[ServerPrefs:27]doComplyWithSkatteverket:65:=False:C215
	[ServerPrefs:27]OverridePassword:68:="password"
	[ServerPrefs:27]overrideLimit:69:=0
	[ServerPrefs:27]administratorCellNo:70:=""
	[ServerPrefs:27]smtpPortNo:71:=25
	[ServerPrefs:27]flagExtension:74:="GIF"
	[ServerPrefs:27]disclaimer:75:=""
	[ServerPrefs:27]WorkstationDetectionMethod:76:=0  // 0: detectbycomputername; 1:detectbyusername; 2:nodetection
	[ServerPrefs:27]useAMLRules:77:=False:C215
	[ServerPrefs:27]autoPublishXMLRates:78:=False:C215
	[ServerPrefs:27]defaultPhoneFormat:79:="### ####"
	[ServerPrefs:27]ReviewCustomerAfterNDays:81:=180
	[ServerPrefs:27]doSanctionCheckOnInvoice:80:=False:C215
	[ServerPrefs:27]checkNPreviousDays:83:=1  // 1 means 24hrs
	
	[ServerPrefs:27]webTimeOut:82:=10
	[ServerPrefs:27]WireDisclaimer:85:=""
	[ServerPrefs:27]doLockDirectRate:88:=False:C215
	[ServerPrefs:27]doLockInverseRate:89:=False:C215
	[ServerPrefs:27]doHideDirectRate:90:=False:C215
	
	[ServerPrefs:27]hmReportLicense:92:="rMqACfZ0uAHjAAAAKLANxBh1ACaAFIAIVAKpAsxAMl"
	[ServerPrefs:27]LimitToRecheckSanctionList:107:=24
	[ServerPrefs:27]thresholdForPTRTransfers:108:=1000
	
	[ServerPrefs:27]autoLogoutEnabled:110:=False:C215
	[ServerPrefs:27]autoLogoutTime:111:=10
	[ServerPrefs:27]passwordResetInterval:112:=3
	
	[ServerPrefs:27]currencyRateSource:113:=0  //0 is ewire.me (SOAP), 1 is clound.clearviewsys.net (REST)
	
	[ServerPrefs:27]twilioAccountSid:115:=""
	[ServerPrefs:27]twilioAuthKey:116:=""
	[ServerPrefs:27]twilioDefaultFromNumber:117:=""
	
	[ServerPrefs:27]passwordCheckUsed:118:=True:C214
	
	assignServerPrefsVarsToFields
	// set global variables
	SAVE RECORD:C53([ServerPrefs:27])
	UNLOAD RECORD:C212([ServerPrefs:27])
	READ ONLY:C145([ServerPrefs:27])
Else 
	READ ONLY:C145([ServerPrefs:27])
	FIRST RECORD:C50([ServerPrefs:27])
	LOAD RECORD:C52([ServerPrefs:27])
	assignServerPrefsVarsToFields
	UNLOAD RECORD:C212([ServerPrefs:27])
End if 

