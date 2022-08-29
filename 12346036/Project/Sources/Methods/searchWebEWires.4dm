//%attributes = {}
//SET FIELD RELATION([WebEWires]CustomerID;Automatic;Manual)
searchTable(->[WebEWires:149]; ->[WebEWires:149]WebEwireID:1; ->[WebEWires:149]CustomerID:21; ->[Customers:3]FullName:40; ->[WebEWires:149]fromCountryCode:4; ->[WebEWires:149]toCountryCode:12)
//SET FIELD RELATION([WebEWires]CustomerID;Manual;Manual)
