//%attributes = {}
READ WRITE:C146([eWires:13])
C_REAL:C285($sellRate)

getCurrencyRates([eWires:13]Currency:12; ->[eWires:13]destinationSpotRate:89; ->[eWires:13]destinationRate:87; ->$sellrate)
// method changed by TB on March 26, 2015; first param was [ewires]fromCurrency

vInverseRate:=calcSafeDivide(1; [eWires:13]destinationRate:87)