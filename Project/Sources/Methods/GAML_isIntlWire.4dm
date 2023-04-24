//%attributes = {}
C_BOOLEAN:C305($0; $isIntlWire)
$isIntlWire:=False:C215


// International Funds Transfer Definition
// For the purposes of Prescribed Transactions Reporting, an International Funds transfer means:
// A wire transfer of NZD$1,000 or more where

// one of the following institutions is in New Zealand: 
//   The ordering institution
//   The intermediary institution
//   The beneficiary institution 

// And one of the following institutions is outside New Zealand:
//   The ordering institution
//   The intermediary institution
//   The beneficiary institution.


$isIntlWire:=$isIntlWire | ([Wires:8]originatorCountryCode:84=<>CountryCode)
$isIntlWire:=$isIntlWire | ([Wires:8]BeneficiaryBankCountryCode:77=<>CountryCode)
$isIntlWire:=$isIntlWire | ([Wires:8]BeneficiaryBankCountryCode:77=<>CountryCode)
$isIntlWire:=$isIntlWire | (([Wires:8]originatorCountryCode:84#[Wires:8]BeneficiaryBankCountryCode:77) & ([Wires:8]originatorCountryCode:84#"") & ([Wires:8]BeneficiaryBankCountryCode:77#""))
$isIntlWire:=$isIntlWire | ([Customers:3]CountryCode:113#[Wires:8]BeneficiaryBankCountryCode:77)
$isIntlWire:=$isIntlWire | (([Customers:3]CountryCode:113#[Wires:8]BeneficiaryCountryCode:78) & ([Customers:3]CountryCode:113=<>CountryCode))
$isIntlWire:=$isIntlWire | (([Customers:3]CountryCode:113#[Wires:8]BeneficiaryCountryCode:78) & ([Wires:8]BeneficiaryCountryCode:78=<>CountryCode))

$0:=$isIntlWire




