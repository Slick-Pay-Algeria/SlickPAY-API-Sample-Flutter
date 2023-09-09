class AppConfig {
  static String baseUrl = "https://devapi.slick-pay.com/api/v2";
  static String publicKey =
      "57|74wHgIsMKIGomdIEgyBW5bSZ5Gw3vFYcfjPTF3wL"; // Set your default PUBLIC_KEY here

       static void set(String defaultBaseUrl, String defaultPublicKey) {
    baseUrl = defaultBaseUrl;
    publicKey = defaultPublicKey;
  }
}
