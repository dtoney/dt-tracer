@setlocal
@set "PATH=%CD%\Tools\premake5;%PATH%"

premake5 clean
premake5 vs2017 %*