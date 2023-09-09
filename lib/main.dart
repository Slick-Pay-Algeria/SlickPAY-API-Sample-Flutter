import 'package:flutter/material.dart';
import 'app.dart';
import 'package:slickpayapi/slickpayapi.dart';

void main() {
  SlickPAYAppConfig.set(
    BaseUrl: "https://devapi.slick-pay.com/api/v2", // Set the API base URL from AppConfig
    PublicKey:  "57|74wHgIsMKIGomdIEgyBW5bSZ5Gw3vFYcfjPTF3wL", // Use your API Key from AppConfig

  );
   runApp(const App());
}
