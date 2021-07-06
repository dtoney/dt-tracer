@echo off
setlocal

:: Automatically create the projects.
call make_projects.bat %*

:: Configure the Visual Studio environment settings.
set "MSBUILD_VS2017_BUILD_TOOLS_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin"
set "MSBUILD_VS2017_PRO_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin"
set "MSBUILD_VS2017_COMMUNITY_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin"
set "PREMAKE_PATH=%CD%\tools\premake5"

set "PATH=%MSBUILD_VS2017_BUILD_TOOLS_PATH%;%MSBUILD_VS2017_PRO_PATH%;%MSBUILD_VS2017_COMMUNITY_PATH%;%PREMAKE_PATH%;%PATH%"

pushd _build\windows
msbuild SimpleRayTracer.sln /p:Configuration=Release /p:Platform=x64
if %errorlevel% neq 0 (
    exit /b 1
)
popd