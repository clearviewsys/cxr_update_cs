//%attributes = {}
//
//FT_SetEntityAndContactInfo
//
//  // Set Entity Information
//($objEntityInfo)
//$objEntityInfo:=(Test_setEntityInfo )
//
//  // Set Contact Information
//($objContactInfo)
//$objContactInfo:=(Test_setContactInfo )
//
//  // Set Report Information
//($objReportInfo)
//$objReportInfo:=(Test_setReportInfo )
//
//
//  // --------------------------------------------------------------------------------------------------
//  // Transaction Information
//  // Information About transactions: Conducted by Individual, Disposition: Individual (self) 
//  // --------------------------------------------------------------------------------------------------
//
//  // FOR EACH TRANSACTION PLEASE CREATE A NEW $objTxInfo Object and Push it into the array $arrTxs
//
//($objTxInfo)
//
//  // For ($k;1; ....
//
//CLEAR VARIABLE($objTxInfo)
//$objTxInfo:=(Test_setTxsIndividualSelf)
//($arrTxs;0)
//APPEND TO ARRAY($arrTxs;$objTxInfo)  // For each transaction
//
//  // End For
//
//FT_REPORT_INDIVIDUAL_SELF ($objEntityInfo;$objContactInfo;$objReportInfo;->$arrTxs)
//
//ALERT("File generation finished")
