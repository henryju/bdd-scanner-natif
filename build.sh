#!/bin/bash

# JAVA_HOME is supposed to point to a JDK9 install
# And $JAVA_HOME/bin is supposed to be in the PATH
export JAVA_HOME=/usr/java/jdk-10.0.1
export PATH=$JAVA_HOME/bin:$PATH

echo "Cleaning..."
rm -rf mods
rm -rf mlib
rm -rf app
rm -rf lib-patched

mkdir lib-patched
cp -f lib/sonar-scanner-api-2.10.0.1189.jar lib-patched/org.sonarsource.scanner.api.jar

echo "Compiling fake scanner-api..."
javac -d mods/org.sonarsource.scanner.api \
        src/org.sonarsource.scanner.api/module-info.java \
        src/org.sonarsource.scanner.api/org/sonarsource/scanner/api/Foo.java \
        src/org.sonarsource.scanner.api/org/sonarsource/scanner/api/internal/batch/Foo.java

echo "Patch scanner-api..."
cd mods/org.sonarsource.scanner.api
jar -uf ../../lib-patched/org.sonarsource.scanner.api.jar module-info.class
cd ../..

echo "Compiling..."
javac --module-path lib-patched -d mods/org.sonarsource.scanner.standalone \
        src/org.sonarsource.scanner.standalone/module-info.java \
        src/org.sonarsource.scanner.standalone/org/sonarsource/scanner/standalone/StandaloneScanner.java

echo "Packaging..."
mkdir mlib
jar --create --file mlib/org.sonarsource.scanner.standalone.jar --main-class org.sonarsource.scanner.standalone.StandaloneScanner -C mods/org.sonarsource.scanner.standalone .

echo "Linking..."
jlink --compress=2 --no-man-pages --module-path "$JAVA_HOME/jmods:mlib:lib-patched" --add-modules org.sonarsource.scanner.standalone --output app --launcher "org.sonarsource.scanner.standalone=org.sonarsource.scanner.standalone"

cd app
jar -cf sonarqube-scanner-linux-x86_64-0.3.zip .