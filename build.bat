@echo off

set JAVA_HOME=c:\Program Files\Java\jdk-9
set PATH=%JAVA_HOME%\bin;%PATH%

echo "Cleaning..."
rd mods /s/q >nul 2>nul
rd mlib /s/q >nul 2>nul
rd app /s/q >nul 2>nul

echo "Compiling..."
javac --module-path lib -d mods/org.sonarsource.scanner.standalone^
        src/org.sonarsource.scanner.standalone/module-info.java^
        src/org.sonarsource.scanner.standalone/org/sonarsource/scanner/standalone/StandaloneScanner.java
if %errorlevel% neq 0 exit /b %errorlevel%

echo "Packaging..."
mkdir mlib
jar --create --file mlib\org.sonarsource.scanner.standalone.jar --main-class org.sonarsource.scanner.standalone.StandaloneScanner -C mods\org.sonarsource.scanner.standalone .
if %errorlevel% neq 0 exit /b %errorlevel%

echo "Linking..."
jlink --module-path "%JAVA_HOME%\jmods;mlib;lib" --add-modules org.sonarsource.scanner.standalone --output app
if %errorlevel% neq 0 exit /b %errorlevel%
