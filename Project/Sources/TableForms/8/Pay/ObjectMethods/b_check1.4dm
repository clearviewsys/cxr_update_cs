//handleBeneficiaryBankCompliance (True)
//handleCustomerEntityCompliance(True;[Wires]BeneficiaryBankName;->[Wires]CXR_WireID;->latestListCheckBeneficiary2)
//sl_handleCompanyNameCompliance(True; [Wires]BeneficiaryBankName; ->[Wires]CXR_WireID; \
New object("pointers"; New object("resultIconPtr"; ->latestListCheckBeneficiary2))\
)
sl_handleWiresScreening(sl_WiresBank+sl_ForSLButton)