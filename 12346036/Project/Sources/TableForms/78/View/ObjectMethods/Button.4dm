

ORDER BY:C49([TellerProofLines:79]; [TellerProofLines:79]Denomination:3; >)

BREAK LEVEL:C302(0)
ACCUMULATE:C303([TellerProofLines:79]Total:6)

printTable(->[TellerProofLines:79]; "print"; ->[TellerProofLines:79]Denomination:3)

printSelectionUsingPrinter(->[TellerProofLines:79]; "print"; getClientDefaultPrinterName; 0)
