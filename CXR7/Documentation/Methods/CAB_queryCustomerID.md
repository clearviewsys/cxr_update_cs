<!-- Access http://10.1.101.110:7006/FCUBSCustomerService/FCUBSCustomerService and execute the ws to get Information about the CAB customer -->

#### ws_QueryCustomerIO ($customerNo)

| Parameter | Type   | in/out | Description |
| --------- | ------ | ------ | ----------- |
| customerNo      | Text | in | Customer Number  |

## Description

This method returns information about a customer stored into the CAB FlexCube Database.
In case of error the file: Temporary folder+"response.xml" will be created with the response
## Example

```4d
$customer:=ws_QueryCustomerIO ("000033557")
```
## Response

```xml
<?xml version='1.0' encoding='UTF-8'?>
<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">
    <S:Body>
        <QUERYCUSTOMER_IOFS_RES xmlns="http://fcubs.ofss.com/service/FCUBSCustomerService">
            <FCUBS_HEADER>
                <SOURCE>EXTSYS</SOURCE>
                <UBSCOMP>FCUBS</UBSCOMP>
                <MSGID>6122333000616086</MSGID>
                <CORRELID>null</CORRELID>
                <USERID>ADMINUSER1</USERID>
                <ENTITY>null</ENTITY>
                <BRANCH>000</BRANCH>
                <MODULEID>ST</MODULEID>
                <SERVICE>FCUBSCustomerService</SERVICE>
                <OPERATION>QueryCustomer</OPERATION>
                <DESTINATION>EXTSYS</DESTINATION>
                <FUNCTIONID>STDCIF</FUNCTIONID>
                <ACTION>EXECUTEQUERY</ACTION>
                <MSGSTAT>SUCCESS</MSGSTAT>
            </FCUBS_HEADER>
            <FCUBS_BODY>
                <Customer-Full>
                    <CUSTNO>000033667</CUSTNO>
                    <CTYPE>I</CTYPE>
                    <NAME>LEE JEONGHO</NAME>
                    <ADDRLN3>Boeng Keng Kang</ADDRLN3>
                    <ADDRLN2>Olympic</ADDRLN2>
                    <ADDRLN4>Phnom Penh</ADDRLN4>
                    <COUNTRY>KH</COUNTRY>
                    <SNAME>000033667</SNAME>
                    <NLTY>KR</NLTY>
                    <LBRN>010</LBRN>
                    <CCATEG>INDIRES</CCATEG>
                    <FULLNAME>LEE JEONGHO</FULLNAME>
                    <CIFCREATIONDT>2021-06-10</CIFCREATIONDT>
                    <FROZEN>N</FROZEN>
                    <DEAD>N</DEAD>
                    <WHRUNKN>N</WHRUNKN>
                    <MEDIA>MAIL</MEDIA>
                    <LOC>KHR</LOC>
                    <CUSTCLASSFN>RETAIL</CUSTCLASSFN>
                    <CLSPARTICIPANT>N</CLSPARTICIPANT>
                    <FXNETTCUST>000033667</FXNETTCUST>
                    <XREF>000033667</XREF>
                    <RELPRICING>N</RELPRICING>
                    <CREATEACC>N</CREATEACC>
                    <TRACK_LIMITS>Y</TRACK_LIMITS>
                    <LIABID>000033667</LIABID>
                    <LMCCY>USD</LMCCY>
                    <OVRLIM>0</OVRLIM>
                    <FLGUTLTYPRVDR>N</FLGUTLTYPRVDR>
                    <AMLREQD>N</AMLREQD>
                    <FTACCASOF>M</FTACCASOF>
                    <CUSTUNADV>N</CUSTUNADV>
                    <CONSTAXCERTRQD>N</CONSTAXCERTRQD>
                    <INDTAXCERTRQD>N</INDTAXCERTRQD>
                    <CLSCCYALLWD>D</CLSCCYALLWD>
                    <NETTREQD>N</NETTREQD>
                    <LIABUNADV>N</LIABUNADV>
                    <SSTAFF>N</SSTAFF>
                    <MAKER>UPLOAD</MAKER>
                    <MAKERSTAMP>2021-06-10 14:28:57</MAKERSTAMP>
                    <CHECKER>UPLOAD</CHECKER>
                    <CHECKERSTAMP>2021-06-10 14:28:57</CHECKERSTAMP>
                    <MODNO>1</MODNO>
                    <TXNSTAT>O</TXNSTAT>
                    <AUTHSTAT>A</AUTHSTAT>
                    <Custpersonal>
                        <DOB>1959-07-30</DOB>
                        <GENDR>M</GENDR>
                        <FAXNUMBER>...</FAXNUMBER>
                        <PCNTRY>KR</PCNTRY>
                        <RESSTATUS>N</RESSTATUS>
                        <CUST_COMM_MODE>M</CUST_COMM_MODE>
                        <LANG>ENG</LANG>
                        <SAME_CORR_ADDR>N</SAME_CORR_ADDR>
                        <Custprof/>
                    </Custpersonal>
                    <Custcorp/>
                    <Custsegment/>
                    <Custmis>
                        <CUST>000033667</CUST>
                        <CUSTNO>000033667</CUSTNO>
                        <BRNCD>010</BRNCD>
                        <Customermis>
                            <MISCLS>AMLRISK</MISCLS>
                        </Customermis>
                        <Customermis>
                            <MISCLS>CBS</MISCLS>
                        </Customermis>
                        <Customermis>
                            <MISCLS>LOANTYPE</MISCLS>
                        </Customermis>
                        <Customermis>
                            <MISCLS>CUST_SEG</MISCLS>
                        </Customermis>
                        <Customermis>
                            <MISCLS>INDUSTRY</MISCLS>
                        </Customermis>
                        <Compositemis>
                            <MISCLS>CUSPVTY</MISCLS>
                        </Compositemis>
                        <Compositemis>
                            <MISCLS>CRD_OFC</MISCLS>
                        </Compositemis>
                        <Compositemis>
                            <MISCLS>SAV_OFC</MISCLS>
                        </Compositemis>
                        <Compositemis>
                            <MISCLS>REPAYMODE</MISCLS>
                        </Compositemis>
                        <Compositemis>
                            <MISCLS>COSTCENTR</MISCLS>
                        </Compositemis>
                        <Compositemis>
                            <MISCLS>SEG_DETAL</MISCLS>
                        </Compositemis>
                        <Compositemis>
                            <MISCLS>LOANSCHEM</MISCLS>
                        </Compositemis>
                        <Compositemis>
                            <MISCLS>REF_OFC</MISCLS>
                        </Compositemis>
                    </Custmis>
                    <Jointcustomer>
                        <CUSTNO>000033667</CUSTNO>
                    </Jointcustomer>
                    <Cust-Acc-Det>
                        <CUSTNO>000033667</CUSTNO>
                    </Cust-Acc-Det>
                    <Custaccdet>
                        <CUSTNO>000033667</CUSTNO>
                        <Relationship-Linkage>
                            <CUSTOMER>000033667</CUSTOMER>
                            <RELATIONSHIP>PRIMARY</RELATIONSHIP>
                            <INHERIT>N</INHERIT>
                            <DESCP>LEE JEONGHO</DESCP>
                            <CATEGORY>C</CATEGORY>
                        </Relationship-Linkage>
                        <Reverse-Relationship>
                            <INHERIT>N</INHERIT>
                            <REF_NO>000033667</REF_NO>
                            <RELATIONSHIP>PRIMARY</RELATIONSHIP>
                            <BRANCH>010</BRANCH>
                            <CUSTOMER>000033667</CUSTOMER>
                            <CATEGORY>C</CATEGORY>
                            <DESC>LEE JEONGHO</DESC>
                        </Reverse-Relationship>
                    </Custaccdet>
                    <Custacdetail>
                        <CUSTNO>000033667</CUSTNO>
                    </Custacdetail>
                    <UDFDETAILS>
                        <FLDNAM>FATCA</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CO_BORROWER_NUMBER</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>GUARANTOR_NUMBER</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>ID_EXPIRY_DATE</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>MAIN_ACTIVITY</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>MORTGAGER_NUMBER</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>OCCUPATION</FLDNAM>
                        <FLDVAL>OTHER_COM</FLDVAL>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>ORGANIZATION_TYPE</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>ORGANIZATION_FORM</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>TIN_NO</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>KHMER_NAME</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>MARITAL_STATUS</FLDNAM>
                        <FLDVAL>Married</FLDVAL>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>INCOME_AMOUNT</FLDNAM>
                        <FLDVAL>0</FLDVAL>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_ID_EXPIRY_DATE</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_APPLICANT_TYPE</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_MARITAL_STATUS</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_NATIONALITY_CODE</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_EMPLOYER_TYPE</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_SELF_EMPLOYED</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_CURRENCY</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_MTHLY_BAS_SAL_INC</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_OTHER_INCOME</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_TOTAL_MONTHLY_INCOME</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_COM_REGIST_NO</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_COM_STATUS</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_COM_ECO_SEC</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_NUM_OF_EMPLOYEES</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_ID_PASS_TYPE</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_ID_PASS_NO</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_GENDER</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_NATION_CODE_COUNTRY_INCORP</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_MORTGACER_NUMBER</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_SECURITY_NUMBER1</FLDNAM>
                    </UDFDETAILS>
                    <UDFDETAILS>
                        <FLDNAM>CBC_COM_TAX_REGISTRATION_NO</FLDNAM>
                    </UDFDETAILS>
                </Customer-Full>
                <FCUBS_WARNING_RESP>
                    <WARNING>
                        <WCODE>ST-SAVE-023</WCODE>
                        <WDESC>Record Successfully Retrieved</WDESC>
                    </WARNING>
                </FCUBS_WARNING_RESP>
            </FCUBS_BODY>
        </QUERYCUSTOMER_IOFS_RES>
    </S:Body>
</S:Envelope> 
```