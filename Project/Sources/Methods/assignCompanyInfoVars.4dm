//%attributes = {}
C_TEXT:C284(<>CountryCode; <>XMLFolderPath; <>RootFolderPath; <>TimeZone; <>CompanyName; <>CompanyAddress; <>CompanyCity; <>CompanyCountry; <>CompanyTel1; <>CompanyTel2; <>CompanyFax; <>CompanyEmail; <>CompanyWebAddress; <>CompanyURL; <>CompanyFullAddress)
C_PICTURE:C286(<>CompanyLogo)
C_TEXT:C284(<>baseCurrency)
C_TEXT:C284(<>clientCode; <>clientKey)
C_TEXT:C284(<>organizationNo)
C_DATE:C307(<>SLA_ExpiryDate; <>licenseExpiryDate)
C_TEXT:C284(<>highestVersionAllowed)
C_TEXT:C284(<>LocalCountry)
C_PICTURE:C286(<>baseCurrencyFlag)


<>baseCurrency:=[CompanyInfo:7]Currency:11
QUERY:C277([Flags:19]; [Flags:19]CurrencyCode:1=<>baseCurrency)  //4/12/18
<>baseCurrencyFlag:=[Flags:19]flag:4  //4/12/18

//[CompanyInfo];"CompanyInfo"

<>CompanyName:=[CompanyInfo:7]CompanyName:1
<>CompanyAddress:=[CompanyInfo:7]Address:2
<>CompanyTel1:=[CompanyInfo:7]Tel1:3
<>CompanyTel2:=[CompanyInfo:7]Tel2:4
<>CompanyFax:=[CompanyInfo:7]Fax:5
<>CompanyEmail:=[CompanyInfo:7]Email:6
<>CompanyWebAddress:=[CompanyInfo:7]WebAddress:7
<>CompanyURL:=[CompanyInfo:7]WebAddress:7
<>CompanyFullAddress:=env_makeAddressText([CompanyInfo:7]Address:2; [CompanyInfo:7]City:9; ""; ""; [CompanyInfo:7]Country:10)
<>CompanyLogo:=[CompanyInfo:7]Logo:8
<>CompanyCity:=[CompanyInfo:7]City:9
<>CompanyCountry:=[CompanyInfo:7]Country:10
<>CountryCode:=[CompanyInfo:7]CountryCode:28
<>TimeZone:=[CompanyInfo:7]TimeZone:12
<>RootFolderPath:=[CompanyInfo:7]RootFolderPath:13
<>XMLFolderPath:=[CompanyInfo:7]xmlFolderPath:14
<>clientCode:=[CompanyInfo:7]ClientCode:15
<>clientKey:=[CompanyInfo:7]ClientKey:16
<>clientCode2:=[CompanyInfo:7]ClientCode2:25
<>clientKey2:=[CompanyInfo:7]ClientKey2:26
<>MaxPEPSanctionListCalls:=[CompanyInfo:7]MaxPEPSanctionListCalls:27
<>branchPrefix:=[CompanyInfo:7]BranchPrefix:17
<>organizationNo:=[CompanyInfo:7]organizationNo:18
<>licenseExpiryDate:=[CompanyInfo:7]LicenseExpiryDate:23
<>SLA_ExpiryDate:=[CompanyInfo:7]SLA_ExpiryDate:21
<>highestVersionAllowed:=[CompanyInfo:7]HighestVersionAllowed:24
