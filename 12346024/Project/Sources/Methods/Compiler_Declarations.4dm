//%attributes = {"invisible":true}
// method to fix errors we find running compiled @milan

ARRAY TEXT:C222(vTitle; 0)  // used as combo boxes in several forms, wrongly typed as C_TEXT in printNoRecords and printInvoicesSTR forms
ARRAY TEXT:C222(currencyRateSource; 0)
ARRAY TEXT:C222(pd_tables; 0)  // generating typing in compiler makes this C_TEXT instead of ARRAY TEXT
