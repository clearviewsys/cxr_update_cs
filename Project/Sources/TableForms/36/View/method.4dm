handleViewForm

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	QUERY:C277([CashInOuts:32]; [CashInOuts:32]CashTransactionID:1=[CashTransactions:36]CashTransactionID:1)  // relate many
	ORDER BY:C49([CashInOuts:32]; [CashInOuts:32]Denomination:7; <)
End if 