//%attributes = {}
// populatePaymentTypes_NZ

ARRAY TEXT:C222($arrCodes; 0)
ARRAY TEXT:C222($arrValues; 0)

ALL RECORDS:C47([PaymentTypes:116])
SELECTION TO ARRAY:C260([PaymentTypes:116]Code:2; $arrCodes; [PaymentTypes:116]PaymentType:3; $arrValues)

populatePaymentTypeArrs_NZ(->$arrCodes; ->$arrValues)

ARRAY TO SELECTION:C261($arrCodes; [PaymentTypes:116]Code:2; $arrValues; [PaymentTypes:116]PaymentType:3)
UNLOAD RECORD:C212([PaymentTypes:116])

READ ONLY:C145([PaymentTypes:116])

allRecordsPaymentTypes
