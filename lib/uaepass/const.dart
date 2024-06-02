class Const {
  static const String uaePassMobileACR =
      "urn:digitalid:authentication:flow:mobileondevice";
  static const String uaePassWebACR =
      "urn:safelayer:tws:policies:authentication:level:low";

  static String uaePassProdScheme = 'uaepass://';
  static String uaePassStgScheme = 'uaepassstg://';

  static const String _uaePassProdBaseUrl = 'https://id.uaepass.ae';
  static const String _uaePassStgBaseUrl = 'https://stg-id.uaepass.ae';

  static String baseUrl(bool isProduction) {
    return isProduction ? _uaePassProdBaseUrl : _uaePassStgBaseUrl;
  }

  static String uaePassScheme(bool isProduction) {
    return isProduction ? uaePassProdScheme : uaePassStgScheme;
  }
}
