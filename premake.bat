@echo off
setlocal



call "tools\packman\packman" pull "tools\packman\host-deps.packman.xml" -p windows-x86_64
if errorlevel 1 ( goto ErrorPullingPackmanFile )


"%PM_premake_PATH%\premake5.exe" --file=premake5.lua --os=windows vs2015
if errorlevel 1 ( goto ErrorRunningPremake )

:Success
exit /b 0


:ErrorPullingPackmanFile
echo There was an error pulling a packman deps file
exit /b 1


:ErrorRunningPremake
echo There was an error running premake
exit /b 1