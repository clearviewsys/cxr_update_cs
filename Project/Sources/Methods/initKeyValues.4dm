//%attributes = {}

setKeyValue("currency.rate.source.openexchangerate.appID")
setKeyValue("currency.rate.source.openexchangerates")

setKeyValue("mg.sendConfirm.isAllowed")

setKeyValue("invoices.isinsider.rate.override.allowed")



If (True:C214)  // ----------- EWIRE DEFAULTS -------------
	setKeyValue("ewires.tomop.bank"; getKeyValue("web.customers.webewires.tomop.bank"))
	setKeyValue("ewires.tomop.cash"; getKeyValue("web.customers.webewires.tomop.cash"))
	setKeyValue("ewires.tomop.mobilewallet"; getKeyValue("web.customers.webewires.tomop.mobilewallet"))
	setKeyValue("ewire.currency.alias.prefix")
	setKeyValue("ewire.fetch.bank")
	setKeyValue("ewire.fetch.mobilewallet")
	setKeyValue("ewire.print.draft")
End if 

If (True:C214)
	setKeyValue("wire.currency.alias.prefix")
End if 


If (True:C214)  // ---- EMAIL TEMPLATE CONFIG ---
	setKeyValue("email.configuration.header.name")
	setKeyValue("email.configuration.header.text")
	setKeyValue("email.configuration.company.name")
	setKeyValue("email.configuration.company.url")
	setKeyValue("email.configuration.company.phone")
	setKeyValue("email.configuration.contact.url")
	setKeyValue("email.configuration.contact.phone")
	setKeyValue("email.configuration.css.url")
	setKeyValue("email.configuration.logo.small.url")
	setKeyValue("email.configuration.logo.medium.url")
	setKeyValue("email.configuration.logo.large.url")
	
	setKeyValue("email.configuration.booking.declaration")
	setKeyValue("email.configuration.booking.settlement")
End if 




///------------- WEB PORTAL KEY VALUES -------------
If (getKeyValue("web.modules.init")="true")
Else 
	// config basic settings
	setKeyValue("web.configuration.logging.enabled"; "true")
	setKeyValue("web.configuration.debug.enabled"; "false")
	
	setKeyValue("web.customers.module.bookings.show"; "true")
	setKeyValue("web.customers.module.links.show"; "true")
	setKeyValue("web.customers.module.webewires.show"; "true")
	setKeyValue("web.customers.module.rates.show"; "true")
	setKeyValue("web.customers.module.quotes.show"; "false")
	setKeyValue("web.customers.module.quotes.show.rateinfo")
	setKeyValue("web.customers.module.quotes.moneygram.group")
	setKeyValue("web.customers.module.ewires.show"; "false")
	setKeyValue("web.customers.module.wires.show"; "false")
	setKeyValue("web.customers.module.wiretemplates.show"; "false")
	setKeyValue("web.customers.module.webattachments.show"; "false")
	
	setKeyValue("web.configuration.password.changefreqency"; "90")
	setKeyValue("web.configuration.password.warningdays"; "7")
	setKeyValue("web.configuration.password.enforcechange"; "false")
	setKeyValue("web.configuration.password.enforcecomplexity"; "true")
	setKeyValue("web.configuration.password.numCharacters"; "12")
	setKeyValue("web.configuration.password.useUppercase"; "true")
	setKeyValue("web.configuration.password.useLowercase"; "true")
	setKeyValue("web.configuration.password.useSpecial"; "false")
	setKeyValue("web.configuration.password.useNumbers"; "true")
	setKeyValue("web.configuration.password.style"; "dark")
	setKeyValue("web.configuration.password.fadeTime"; "500")
	
	setKeyValue("web.modules.init"; "true")
End if 


// --- MORE WEB PORTAL KEY VALUES -----
If (True:C214)  //init keyvalues so end user can change
	
	setKeyValue("web.configuration.notification.email")  //email address(s) where new rec info is sent
	setKeyValue("web.configuration.format.currency")
	setKeyValue("web.configuration.format.date")
	
	setKeyValue("web.configuration.uselocalcdn"; "true")
	setKeyValue("web.configuration.theme")
	setKeyValue("web.configuration.baseurl")
	setKeyValue("web.configuration.timeout")
	setKeyValue("web.configuration.process.timeout")
	setKeyValue("web.configuration.session.timeout")
	setKeyValue("web.configuration.session.max")
	setKeyValue("web.configuration.process.max")
	
	setKeyValue("web.configuration.error.contact.phone")
	setKeyValue("web.configuration.error.contact.name")
	setKeyValue("web.configuration.error.contact.url")
	
	
	
	// ------ SHOULD THESE BE PORTAL SPECIFIC ??
	setKeyValue("web.configuration.header.name")
	setKeyValue("web.configuration.header.phone")
	setKeyValue("web.configuration.header.url")
	setKeyValue("web.configuration.header.logo.url")
	setKeyValue("web.configuration.footer.name")
	setKeyValue("web.configuration.footer.phone")
	setKeyValue("web.configuration.footer.logo.url")
	setKeyValue("web.configuration.footer.url")
	
	If (True:C214)  // --- PASSWORD CONFIG ---
		setKeyValue("web.configuration.password.changefreqency")
		setKeyValue("web.configuration.password.warningdays")
		setKeyValue("web.configuration.password.enforcechange")
		setKeyValue("web.configuration.password.enforcecomplexity")
		setKeyValue("web.configuration.password.numCharacters")
		setKeyValue("web.configuration.password.useUppercase")
		setKeyValue("web.configuration.password.useLowercase")
		setKeyValue("web.configuration.password.useSpecial")
		setKeyValue("web.configuration.password.useNumbers")
		setKeyValue("web.configuration.password.style")
		setKeyValue("web.configuration.password.fadeTime")
	End if 
	
	If (True:C214)  //ALERTS TO INTERNAL USERS
		setKeyValue("web.configuration.alert.customers.save.new")
		setKeyValue("web.configuration.alert.customers.save.existing")
		setKeyValue("web.configuration.alert.webewires.save.new")
		setKeyValue("web.configuration.alert.webewires.save.existing")
		setKeyValue("web.configuration.alert.links.save.new")
		setKeyValue("web.configuration.alert.links.save.existing")
	End if 
	
	If (True:C214)  // POLI CONFIG
		setKeyValue("web.configuration.payments.poli.enabled")
		setKeyValue("web.configuration.payments.depositaccount.poli")
		setKeyValue("web.configuration.payments.poli.depositaccount")
		setKeyValue("web.configuration.payments.poli.expirydays")
		setKeyValue("web.configuration.payments.poli.timeout")
		setKeyValue("web.configuration.payments.poli.testmode")
		setKeyValue("web.configuration.payments.poli.authcode")
		setKeyValue("web.configuration.payments.poli.currencycode")
	End if 
	
	If (True:C214)  // PAYMARK CONFIG
		setKeyValue("web.configuration.payments.paymark.enabled")
		setKeyValue("web.configuration.payments.paymark.testmode")
		setKeyValue("web.configuration.payments.paymark.username")
		setKeyValue("web.configuration.payments.paymark.password")
		setKeyValue("web.configuration.payments.paymark.accountid")
		setKeyValue("web.configuration.payments.paymark.buttonlabel")
	End if 
	
	If (True:C214)
		setKeyValue("web.configuration.payments.paypal.enabled")
		setKeyValue("web.configuration.payments.paypal.clientid")
	End if 
	
	If (True:C214)
		setKeyValue("web.configuration.payments.square.enabled")
		setKeyValue("web.configuration.payments.square.testmode")
		setKeyValue("web.configuration.payments.square.fee.percentage")  //add this to cost
		
		setKeyValue("web.configuration.payments.square.test.url")
		setKeyValue("web.configuration.payments.square.test.appId")
		setKeyValue("web.configuration.payments.square.test.token")
		setKeyValue("web.configuration.payments.square.test.location")
		
		setKeyValue("web.configuration.payments.square.url")
		setKeyValue("web.configuration.payments.square.appId")
		setKeyValue("web.configuration.payments.square.token")
		setKeyValue("web.configuration.payments.square.location")
	End if 
	
	
	If (True:C214)  // --- CUSTOMER PORTAL CONFIG -----
		setKeyValue("web.customers.module.rates.show")
		setKeyValue("web.customers.module.quotes.show")
		setKeyValue("web.customers.module.quotes.show.rateinfo")
		setKeyValue("web.customers.module.rates.useCurrencies")
		setKeyValue("web.customers.module.quotes.help.nz")
		setKeyValue("web.customers.module.quotes.help.au")
		setKeyValue("web.customers.module.quotes.help.fj")
		
		setKeyValue("web.customers.webewires.mop.wire")  // use true or false -- do we need country specific?
		setKeyValue("web.customers.webewires.mop.mg")
		setKeyValue("web.customers.webewires.mop.wallet")
		setKeyValue("web.customers.webewires.mop.cash")
		
		setKeyValue("web.customers.welcome.alert")
		
		setKeyValue("web.customers.contact.name")
		setKeyValue("web.customers.contact.phone")
		setKeyValue("web.customers.contact.url")
		
		setKeyValue("web.customers.login.invite.only")  //true or false
		setKeyValue("web.customers.login.invite.code")
		setKeyValue("web.customers.login.invite.message")
		setKeyValue("web.customers.login.message")
		
		setKeyValue("web.customers.login.contact.alert")
		setKeyValue("web.customers.login.onhold.alert")
		setKeyValue("web.customers.login.notapproved.alert")
		setKeyValue("web.customers.login.nowebaccess.alert")
		setKeyValue("web.customers.login.mustchange.alert")
		setKeyValue("web.customers.login.mustchangeonhold.alert")
		setKeyValue("web.customers.login.recommendchange.alert")
		setKeyValue("web.customers.login.afterloginattempts.alert")
		setKeyValue("web.customers.login.loginattempts.alert")
		setKeyValue("web.customers.login.usernotfound.alert")
		setKeyValue("web.customers.login.noconfirmation.alert")
		setKeyValue("web.customers.login.url")
		
		setKeyValue("web.customers.profile.confirmed.alert")
		setKeyValue("web.customers.profile.onhold.alert")
		setKeyValue("web.customers.profile.usernotfound.alert")
		setKeyValue("web.customers.profile.onsuccess.alert")
		setKeyValue("web.customers.profile.unabletoconfirm.alert")
		
		setKeyValue("web.customers.profile.documents.alert")
		
		setKeyValue("web.customers.profile.status.approved.alert")
		setKeyValue("web.customers.profile.status.pendingexisting.alert")
		setKeyValue("web.customers.profile.status.pendingnew.alert")
		
		setKeyValue("web.customers.profile.id.single.alert")
		setKeyValue("web.customers.profile.id.multiple.alert")
		setKeyValue("web.customers.profile.id.single.help")
		setKeyValue("web.customers.profile.id.multiple.help")
		setKeyValue("web.customers.profile.id.requires.multiple.list")
		
		
		setKeyValue("web.customers.bookings.terms")
		setKeyValue("web.customers.openbookings.terms")
		setKeyValue("web.customers.profiles.terms")
		setKeyValue("web.customers.webattachments.terms")
		setKeyValue("web.customers.webewires.terms")
		setKeyValue("web.customers.wiretemplates.terms")
		
		
		
		setKeyValue("web.customers.webewires.documents.alert")
		setKeyValue("web.customers.webewires.alert")
		setKeyValue("web.customers.webewires.confirmation.alert")
		
		
		setKeyValue("web.customers.webewires.paymentgateway")
		setKeyValue("web.customers.webewires.bank.discount")
		setKeyValue("web.customers.webewires.frommop.poli")
		setKeyValue("web.customers.webewires.frommop.paymark")
		setKeyValue("web.customers.webewires.frommop.square")
		
		setKeyValue("web.customers.webewires.tomop.bank")
		setKeyValue("web.customers.webewires.tomop.cash")
		setKeyValue("web.customers.webewires.tomop.mpaisa")
		setKeyValue("web.customers.webewires.tomop.moneygram")
		If (getKeyValue("web.customers.webewires.tomop.mpaisa")="")
			setKeyValue("web.customers.webewires.tomop.mobilewallet")
		Else 
			setKeyValue("web.customers.webewires.tomop.mobilewallet"; getKeyValue("web.customers.webewires.tomop.mpaisa"))
		End if 
		
		setKeyValue("web.customers.webewires.links.countries")
		setKeyValue("web.customers.webewires.mg.sla")
		setKeyValue("web.customers.webewires.mg.reference")
		setKeyValue("web.customers.webewires.mg.contact.phone")
		setKeyValue("web.customers.mg.contact.phone")
	End if 
	
	
	
	
	
	
End if 

setKeyValue("print.footer.text")
