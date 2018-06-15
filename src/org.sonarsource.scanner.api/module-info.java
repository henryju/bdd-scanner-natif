module org.sonarsource.scanner.api {
  // logback
  requires java.logging;
  requires java.xml;
  requires java.naming;
  // gson
  requires java.sql;// https://github.com/google/gson/issues/134
  
  //cglib
  requires java.desktop;
  
  // persisit
  requires java.management;
  requires java.rmi;
  
  exports org.sonarsource.scanner.api;
  exports org.sonarsource.scanner.api.internal.batch;
  
}
