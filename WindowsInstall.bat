mkdir "%HOMEDRIVE%%HOMEPATH%\.vim"
xcopy /E /Y * "%HOMEDRIVE%%HOMEPATH%\.vim"
move /Y "%HOMEDRIVE%%HOMEPATH%\.vim\vimrc" "%HOMEDRIVE%%HOMEPATH%\.vimrc"



