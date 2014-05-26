rmdir /S "%USERPROFILE%\AppData\Roaming\.emacs.d\"
mkdir "%HOMEDRIVE%%HOMEPATH%\.vim"
xcopy /E /Y * "%HOMEDRIVE%%HOMEPATH%\.vim"
move /Y "%HOMEDRIVE%%HOMEPATH%\.vim\vimrc" "%HOMEDRIVE%%HOMEPATH%\.vimrc"

REM set PATH=C:\msysgit\bin;%PATH%
REM %HOMEDRIVE%%HOMEPATH%\.vim\bundle\neobundle.vim\bin\neoinstall.bat

