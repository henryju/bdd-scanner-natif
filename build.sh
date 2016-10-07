#!/bin/bash

export JAVA_HOME=FIXME
export PATH=$JAVA_HOME/bin:$PATH

echo "Cleaning..."
rm -rf mods
rm -rf mlib
rm -rf app

echo "Compiling..."
javac --module-path lib -d mods/org.sonarsource.scanner.standalone \
        src/org.sonarsource.scanner.standalone/module-info.java \
        src/org.sonarsource.scanner.standalone/org/sonarsource/scanner/standalone/StandaloneScanner.java

echo "Packaging..."
mkdir mlib
jar --create --file mlib/org.sonarsource.scanner.standalone.jar --main-class org.sonarsource.scanner.standalone.StandaloneScanner -C mods/org.sonarsource.scanner.standalone .

echo "Linking..."
jlink --module-path "$JAVA_HOME/jmods:mlib:lib" --add-modules org.sonarsource.scanner.standalone --output app
