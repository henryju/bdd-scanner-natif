package org.sonarsource.scanner.standalone;

import java.util.Properties;
import org.sonarsource.scanner.api.EmbeddedScanner;
import org.sonarsource.scanner.api.StdOutLogOutput;
import org.sonarsource.scanner.api.Utils;

public class StandaloneScanner {

  public static void main(String[] args) {
    Properties envProps = Utils.loadEnvironmentProperties(System.getenv());
    EmbeddedScanner scanner = EmbeddedScanner.create(new StdOutLogOutput())
      .addGlobalProperties(envProps);
    scanner.start();
    try {
      scanner.runAnalysis(envProps);
    } finally {
      scanner.stop();
    }
  }

}
