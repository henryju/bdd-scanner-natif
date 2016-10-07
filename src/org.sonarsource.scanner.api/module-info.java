module org.sonarsource.scanner.api {
  
  requires java.logging;
  requires java.xml;
  requires java.naming;
  requires java.sql;
  requires java.management;
  requires java.desktop;
  exports org.sonarsource.scanner.api;
  exports org.sonarsource.scanner.api.internal.batch;
  
}
