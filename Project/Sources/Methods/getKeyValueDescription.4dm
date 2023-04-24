//%attributes = {}
// getKeyValueDescription (key) : description
// this method returns some documentation of what key/value is supposed to be used for
// as the number of key values increase we will have a hard time remembering them 
// [KeyValues];"Entry"

C_TEXT:C284($1; $0; $key; $description)

Case of 
	: (Count parameters:C259=0)
		$key:="test"
		
	: (Count parameters:C259=1)
		$key:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
		// developers NOTICE: PLEASE DON'T LEAVE DESCRIPTION BLANK
		// provide the default values and all acceptable values in the description (e.g. 'yes', 'no', 'maybe')
		// provide an example of a correct entry 
		// please don't use the KeyValues to store file paths. File paths should be stored in the FilePath table
		
	: ($key="ftp.method")
		$description:="This the method of FTP and SFTP that CXR will use to upload rates. By default 'curl'; you can store '4DIC' if you want to use the old method"
		
	: ($key="au.min.between.restarts")
		$description:="Automatic Updates Config parameter. Used to config the minimun time before restarting 4D Server after the upgrade."
		
	: ($key="au.url.update.components")
		$description:="Automatic Updates Config parameter. Used to indicate if components were upgraded."
		
	: ($key="au.url.update.datafiles")
		$description:="Automatic Updates Config parameter. Used to indicate the URL of the zip file to download."
		
	: ($key="au.url.update.latestversion")
		$description:="Automatic Updates Config parameter. Used to indicate the latest version upgraded."
		
	: ($key="au.url.update.plugins")
		$description:="Automatic Updates Config parameter. Used to indicate if plugins were upgraded."
		
	: ($key="au.url.update.resources")
		$description:="Automatic Updates Config parameter. Used to indicate if resources were upgraded."
		
	: ($key="au.Service.Name")
		$description:="Automatic Updates Config parameter. Used to indicate the name 4D server service (windows)."
		
	: ($key="au.LogFileName")
		$description:="Automatic Updates Config parameter. Used to indicate the Logfile Name4D server . (By default: AutomaticUpdates.LOG)"
		
		
		//_______________________________
		
		
	: ($key="Form.Customers.Entry")
		$description:="overrides the Customers.Entry when adding a new customer (e.g. 'Entry', 'Entry_old')"
		
		//_______________________________
		
	: ($key="identityMind.activated")
		$description:="Activates the Identity Mind API in CXR. value true=activate"
		
	: ($key="identityMind.autoCheckOnSave")
		$description:="IM: if true, run KYC when saving in the Customer Entry form"
		
	: ($key="identityMind.HTTPRequestTimeout")
		$description:="IM: HTTP request timeout. Used as: HTTP SET OPTION(HTTP timeout; $value)"
		
	: ($key="identityMind.KYCProfileName")
		$description:="IM: KYC profile name, defaults to \"DEFAULT\""
		
	: ($key="identityMind.TransferProfileName")
		$description:="IM: Transfer profile name, defaults to \"DEFAULT\""
		
	: ($key="identityMind.KYCValidateDoc")
		$description:="IM: Allows documentation to sent to IdentityMind. value true=allows"
		
	: ($key="identityMind.production.pass")
		$description:="IM: Production Password (Appears in the PDF credentials as \"API Key / Password\")."
		
	: ($key="identityMind.production.user")
		$description:="IM: Production Username (Appears in the PDF credentials as \"API User\")."
		
	: ($key="identityMind.sandbox.pass")
		$description:="IM: Sandbox password (Appears in the PDF credentials as \"API Key / Password\")."
		
	: ($key="identityMind.sandbox.user")
		$description:="IM: Sandbox username (Appears in the PDF credentials as \"API User\")."
		
	: ($key="identityMind.staging.pass")
		$description:="IM: Staging password (Appears in the PDF credentials as \"API Key / Password\")."
		
	: ($key="identityMind.staging.user")
		$description:="IM: Staging Username (Appears in the PDF credentials as \"API User\")."
		
		//_______________________________
		
	: ($key="KYC2020.APIKey")
		$description:="Unique API key would be generated for Trial and Premium members."+\
			"The API Key is location under My Account ->My profile"
	: ($key="KYC2020.Email")
		$description:="User's email"
	: ($key="KYC2020.CategoryCodeList")
		$description:="Custom Watchlist group list."
		
	: ($key="KYC2020.FilterThreshold")
		$description:="KYC2020: Include Risk Score threshold limits. It can be set from the Manage Prefences Page. "+\
			"0 = OFF, 1 = ON"
	: ($key="KYC2020.MustMatch")
		$description:="KYC2020: 1 - Name; 2 - Address; 3 for Identification; nothing for fuzzy serarch."+\
			" Separate number with pipe with mulitple eg. \"1|\\2\""
	: ($key="KYC2020.QueryCount")
		$description:="KYC2020: Systme maximum is 200 results returned. Default is 100."
	: ($key="KYC2020.ResponseType")
		$description:="KYC2020: Default response type:"+\
			"1 - Gives only SmartScan result in response. "+\
			"2 - Gives both DIQ and SmartScan result in response. "+\
			"3 - Gives only DIQ result in response. "+\
			"4 - Gives SmartScan and Adverse Media in response"
	: ($key="KYEC2020.ResponseType.Customer")
		$description:="KYC2020: Like KYC2020.ResponseType but for Customers"
		
	: ($key="KYEC2020.ResponseType.Customer")
		$description:="KYC2020: Like KYC2020.ResponseType but for Invoice"
		//________________________________
		
	: ($key="MemberCheck.ApplyPEPJurisdiction")
		$description:="MCHK: Eliminate results base on country of jurisdiction. Not for organizations. Possible values are: \"ApplyAll\", \"Ignore\",\"ApplySIP\", and \"ApplyRCA\""
		
	: ($key="MemberCheck.ApplyResidence")
		$description:="MCHK: Elimiate result base on country of residence. Not for organizations. Possible values are \"ApplyPEP\",\"ApplyAll\",\"Ignore\",\"ApplySIP\", and \"ApplyRCA\""
		
	: ($key="MemberCheck.ApplyWhitelist")
		$description:="MCHK: Apply whitelist? possible values are: \"Apply\" and \"Ignore\""
		
	: ($key="MemberCheck.CloseMatchRateThreshold")
		$description:="MCHK: Refine close match results. Not for organizations."
		
	: ($key="MemberCheck.MatchType")
		$description:="MCHK: Type of close match. Possible values are: \"Close\" and \"Exact\""
		
	: ($key="MemberCheck:Status")
		$description:="MCHK: The status of the MemberCheck. Possible values are: \"demo\", \"app\" and others."
		
		// _________________________________
		
	: ($key="sanctionlist.version")
		$description:="Sanction list version \"v1\" for the version in CRX 5 and earilier; \"v2\" for the JSON version created in CXR 6"
		
	: ($key="printInvoice.FullPage")
		$description:="Default form to use when printing the invoice in Full Page (e.g. printInvoice_FINTRAC, printInvoice_FullInfo, printInvoice_Large )"
		
		
		
	: ($key="Settings.eWireSiteID")
		$description:=""
		
	: ($key="Settings.filterZeroBalanceTills")
		$description:="default is true; when selecting a till in Accounts.view it filters the zeros unless we want to show all"
		
	: ($key="Settings.walkin")
		$description:="default value: 'create'; otherwise walking customers will not be created at startup."
		
		//_________________________________________
	: ($key="AMLRule.pictureIDExpDate")
		$description:="default value: 'loose'; value 'strict' will force users to update the picture ID if it expired."
		// validateCustomerKYC
		
	: ($key="AMLRule.ProfileReview")
		$description:="default value: 'strict';  will force users to review a customer profile before doing transactions with them."
		// validateCustomerKYC
		
	: ($key="AMLRule.license")
		$description:="Pro or otherwise"
		
		//_________________________________________
		
	: ($key="pick.forceAutomatic.relationship")
		$description:="If the value is true, then picker will automatically open when entering a value in the relationship field"
		
	: ($key="pictures.convertDeprecated")
		$description:="If the value is true, CXR wil convert all deprecated pictures to current formats on startup"
		
		//_________________________________________
		
	: ($key="currencyCloud.pass")
		$description:="Password for Currency Cloud account. This is the 64 characer API key provided by currency cloud"
		
	: ($key="currencyCloud.activated")
		$description:="Is Currency Cloud activated, set to 'true' to activate"
		
	: ($key="currencyCloud.user")
		$description:="Currency Cloud user name"
		
	: ($key="currencyCloud.URL")
		$description:="Currency Cloud API URL. \"https://devapi.currencycloud.com/v2\" for the development environment or \"https://api.thecurrencycloud.com/v2\" for the live environment"
		//_________________________________________
		
		
		
	: ($key="BisN.isActive")
		$description:="To activate Bisnode Integration, value should be 'active'"
		
	: ($key="BisN.environment")
		$description:="Determines environment for Bisnode Integration. Acceptable values: 'test' and 'prod'. Default is 'prod'"
		
	: ($key="BisN.prod.client.id")
		$description:="Bisnode Integration Client ID credential for production environment"
		
	: ($key="BisN.prod.client.secret")
		$description:="Bisnode Integration Client Secret credential for production environment"
		
	: ($key="BisN.test.client.id")
		$description:="Bisnode Integration Client ID credential for test environment"
		
	: ($key="BisN.test.client.secret")
		$description:="Bisnode Integration Client Secret credential for test environment"
		
	: ($key="BisN.country")
		$description:="Country for Bisnode Integration. Use two letter format: for example 'SE' for Sweden. Currently search person by legal ID only works for Sweden."
		
		//_________________________________________
		
	: ($key="Invoice.TransactionCode.Required")
		$description:="Makes the Transaction Code Mandatory during the invoicing. Default is True"
		
	: ($key="Invoice.CustomerType.Required")
		$description:="Makes the Customer Type Mandatory during the invoicing. Default is True"
		
	: ($key="Invoice.print.PDF")
		$description:="You can override what print format to use for printing (or emailing) to PDF. e.g.: printInvoice_Large; printInvoice_Thermal"
		
	: ($key="Invoice.print.PDF.pageFormat")
		$description:="You can override what page format to use for printing (or emailing) to PDF. e.g.: Letter; A5"
		
	: ($key="Invoice.email")
		$description:="Send email attachment; Values can be {PDF, Alert} ; in the future we may include other possible formats (e.g. XPS)"
		
		//_________________________________________
		
		
	: ($key="twilio.accountSid")
		$description:="Account Sid for the current twilio SMS sending account."
		
	: ($key="twilio.authToken")
		$description:="Authentication Token for the current twilio SMS sending account."
		
	: ($key="twilio.fromNumber")
		$description:="Default from Number for the current twilio SMS sending account. Only used if a working from number is not provided"
		
	: ($key="twilio.accountTextBalance")
		$description:="Number of texts left available to send. This is calculated via the account balance pulled from Twilio"
		
	: ($key="twilio.useInternalValues")
		$description:="True: use keyValues for twilio account; False: use serverPrefs for twilio account"
		
	: ($key="twilio.subAccount.sid")
		$description:="Account Sid for the current twilio accounting sub account"
		
	: ($key="twilio.subAccount.activated")
		$description:="True: Use the sub account Id for all twilio purposes; False: use the main account Id for Twilio"
		
		//_________________________________________
		
		
	: ($key="auth.designerEnabled")
		$description:="True: designer account is enabled and able to log in; False: designer account is locked"
		
	: ($key="auth.designerTries")
		$description:="number of unsucessful attempts to log into the designer account. Account will be locked when tries >=10"
		
		
	: ($key="CanadaPost.AddressComplete.api.key")
		$description:="Canada Post AddressComplete API key. Used for address search."
		
	: ($key="Google.geocode.api.key")
		$description:="API key for using Google geocoding service."
		//_________________________________________
		
	: ($key="address.enable.google.geocode")
		$description:="Default is false. If set to true, when new address is searched, the latitude and longitude coordinates are fetched from Google API and saved with the address."
		
	: ($key="address.search.proximity.radius.in.meter")
		$description:="Default is 1000 Meters. The search radius, in meters, that is used for finding close addresses. It will not be very accurate bellow 1000 Meters."
		
		//_________________________________________
		
		
	: ($key="JAM.default.Report.description")
		$description:="Default Report Description for GL Report (Bank Of Jamaica)"
		
	: ($key="JAM.Equalization.Exchange.Acct")
		$description:="Default Account number for reporting exchange diffs in GL Report (Bank Of Jamaica)"
		
		//__________________________________________
		
	: ($key="ral.terminate")
		$description:="Determines if the RAL system will terminate when an exception is caused. Values are true or false (default false)"
		
	: ($key="topaz.active")
		$description:="Determines if the Topaz Signature Pad is used; values:{true; false}; make sure to add FilePaths for Topaz"
		
	: ($key="signatureEnabled")
		$description:="true; false ; topaz (make sure to add filePaths for Topaz)"
		
	: ($key="Bookings.print.form")
		$description:="This is the print format to use for printing Bookings; values:{print; print_Large}"
		
		//_________________________________________
	: ($key="check.same.location.same.lastname")
		$description:="When set to true, enables checking for customers having same location and same lastname"
		
	: ($key="check.same.location.different.lastname")
		$description:="When set to true, enables checking for customers having same location but different lastname"
		
	: ($key="check.close.location.same.lastname")
		$description:="When set to true, enables checking for customers having close location and same lastname"
		
		//____________________________________________
	: ($key="email.greetings.birthday.from")
		$description:="When Birthday Emails are sent, this email is used as the 'from' email"
		
	: ($key="email.greetings.birthday.subject")
		$description:="This is where you can customize the subject of the birthday email"
		
	: ($key="email.stop.marketing.after.inactive.months")
		$description:="This is where you can define how many months of no activity will define a customer as 'inactive'. Takes in a number(eg. 12 or 18)."
		//____________________________________________
		
	: ($key="zeroBounce.apiKey")
		$description:="The API Key associated with the Zero Bounce account."
		
		//_________________________________________
		// b2 bucket key values
		
	: ($key="b2.keyID")
		$description:="Key for BackBlaze B2 account"
		
	: ($key="b2.keyName")
		$description:="Name of the BackBlaze B2 key for account"
		
	: ($key="b2.key")
		$description:="Actual BackBlaze B2 key"
		
	: ($key="b2.bucketName")
		$description:="Name of the bucket we use for this installation of CXR/client using it"
		
	: ($key="b2.syncBackups")
		$description:="Should 4D Server upload .4BK and .4BL files to bucket. true or false"
		//_________________________________________
		
	: ($key="cab.ws.url")
		$description:="URL used to access cab web services. Example: http://10.1.101.110:7006/FCUBSCustomerService/FCUBSCustomerService"
		
	: ($key="odbc.dsn.name")
		$description:="Generic DSN name for a ODBC Access. Must be defined by ODBC Administrator tool"
		
	: ($key="odbc.username")
		$description:="Generic user name for a ODBC Access. Used by CAB"
		
	: ($key="odbc.password")
		$description:="Generic Password name for a ODBC Access. Used by CAB"
		
		
		
		
		//: ($key="")
		//$description:=
		
	Else 
		$description:="unknown key"
End case 


$0:=$description