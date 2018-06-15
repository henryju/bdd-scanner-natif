package org.sonarsource.scanner.standalone;

import java.util.Properties;
import java.util.Map;
import org.sonarsource.scanner.api.EmbeddedScanner;
import org.sonarsource.scanner.api.ScanProperties;
import org.sonarsource.scanner.api.StdOutLogOutput;
import org.sonarsource.scanner.api.Utils;

public class StandaloneScanner {

  public static void main(String[] args) {
    Properties envProps = Utils.loadEnvironmentProperties(System.getenv());
    if ("true".equalsIgnoreCase(envProps.getProperty(ScanProperties.SKIP))) {
      System.out.println("SonarQube Scanner analysis skipped");
      return;
    }
    EmbeddedScanner scanner = EmbeddedScanner.create("standalone", "0.3", new StdOutLogOutput())
      .addGlobalProperties((Map) envProps);
    scanner.start();
    scanner.execute((Map) envProps);
  }

}
