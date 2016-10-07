module org.sonarsource.scanner.api {
  // logback
  requires java.logging;
  requires java.xml;
  requires java.naming;
  // gson
  requires java.sql;
  requires jdk.unsupported;

  //cglib
  requires java.desktop;
  
  // persisit
  requires java.management;
  
  exports org.sonarsource.scanner.api;
  exports org.sonarsource.scanner.api.internal.batch;
  
}
