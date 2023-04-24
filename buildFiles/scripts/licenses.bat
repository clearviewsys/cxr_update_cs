rem GET DEVELOPEFR LICENSES

echo "getting licenses from %1%"

curl -s -u %BINARIES_USER%:%BINARIES_PASSWORD% -o %HOMEDRIVE%%HOMEPATH%\Downloads\dev_lic.zip %1%

mkdir %HOMEDRIVE%%HOMEPATH%\Documents\Licenses

%sevenzip% x %HOMEDRIVE%%HOMEPATH%\Downloads\dev_lic.zip -o%HOMEDRIVE%%HOMEPATH%\Documents\Licenses\

mkdir %ProgramData%\4D
mkdir %ProgramData%\4D\Licenses

copy /Y %HOMEDRIVE%%HOMEPATH%\Documents\Licenses\*.* %ProgramData%\4D\Licenses\
