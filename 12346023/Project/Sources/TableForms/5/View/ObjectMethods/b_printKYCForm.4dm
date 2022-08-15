//C_INTEGER(vPageSetup)
//If (doComplyWithSkatteverket )
//  // Replaced on: 2/8/2017 - BY: CVS Dev. Team
//  // myAlert ("This feature is disabled due to Skatteverket compliance.")
//myAlert (getLocalizedErrorMessage (4090))
//Else 
//setPrintSettingsDefault 
//
//pageSetupInvoice 
//If (OK=1)
//SET PRINT PREVIEW(<>previewBeforePrint)
//
//setPrintSettings (<>lastPrinterName;True;100;<>lastPageOption)
//printSelectionUsingPrinter (->[Registers];<>lastInvoiceFormat;<>lastPrinterName;0)
//End if 
//End if 


printSelection(->[Customers:3]; "Customer_KYC_SAR")
