//%attributes = {}
// display the Red Flag Signs
C_BOOLEAN:C305($isPEP; $isHighRisk; $isOnHold; isSuspicious; $isFavorite; $isExpired; $isAccount; $isSuspicious; $isDueForReview)
C_BOOLEAN:C305($isCreatedOnWeb)

$isPEP:=(([Customers:3]AML_isPEP:80=1) | ([Customers:3]AML_isHIO:124=1))
$isHighRisk:=(([Customers:3]AML_HighRisk:24=1) | ([Customers:3]AML_RiskRating:75>3))
$isOnHold:=(([Customers:3]isOnHold:52) | ([Customers:3]AML_isInBusinessRelation:115=2))  // relationship terminated or on hold
$isSuspicious:=[Customers:3]AML_isSuspicious:49
$isDueForReview:=isCustomerDueForKYCReview
$isFavorite:=[Customers:3]isFavorite:68
$isExpired:=isPictureIDExpired([Customers:3]PictureID_ExpiryDate:71)
$isCreatedOnWeb:=[Customers:3]CreatedByUserID:58="WEB-@"

setVisibleIff($isOnHold; "l_onHOLD")
setVisibleIff($isSuspicious; "l_isSuspicious")
setVisibleIff(($isHighRisk | $isPEP); "l_highRisk")
setVisibleIff($isPEP; "l_pep")
setVisibleIff($isDueForReview; "l_needsReview")

setVisibleIff($isCreatedOnWeb; "ICON_createdOnWeb")

setVisibleIff($isHighRisk; "Icon_HighRisk")
setVisibleIff($isPEP; "Icon_PEP")

//setTitleIff ($isFavorite;"l_flagged";)
stampText("stamp_isFlagged"; "🏁"; ""; $isFavorite)
stampText("stamp_isOnHold"; "ON HOLD ⛔"; "red"; $isOnHold)
stampText("stamp_isIDExpired"; "Picture ID Expired ⛔"; "red"; $isExpired)

stampText("stamp_isHighRisk"; "High Risk 🚥"; "red"; ($isHighRisk | $isPEP))
stampText("stamp_AML_isSuspicious"; "Suspicious ⚠"; "orange"; $isSuspicious)
stampText("stamp_AML_isPEP"; "💁 PEP"; "black"; $isPEP)
stampText("stamp_KYC_needsReview"; "Needs Review ✖"; "green_test_dependencies"; $isDueForReview)
stampText("stamp_KYC_isAccount"; "External Account"; "orange"; $isAccount)
