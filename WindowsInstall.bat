choco install git -y
choco install vim -y

rmdir /S "%HOMEDRIVE%%HOMEPATH%\vimfiles"
mkdir "%HOMEDRIVE%%HOMEPATH%\vimfiles"
xcopy /E /Y * "%HOMEDRIVE%%HOMEPATH%\vimfiles"
