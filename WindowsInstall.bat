mkdir "%HOMEDRIVE%%HOMEPATH%\.vim"
xcopy /E /Y * "%HOMEDRIVE%%HOMEPATH%\.vim"
move /Y "%HOMEDRIVE%%HOMEPATH%\.vim\vimrc" "%HOMEDRIVE%%HOMEPATH%\.vimrc"

set PATH=C:\msysgit\bin;%PATH%
%HOMEDRIVE%%HOMEPATH%\.vim\bundle\neobundle.vim\bin\neoinstall.bat

