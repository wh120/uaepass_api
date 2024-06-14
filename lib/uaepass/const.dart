/// The [Const] class contains constants and utility methods related to UAE Pass integration.
class Const {
  /// A constant representing the authentication context for UAE Pass mobile authentication flow.
  static const String uaePassMobileACR =
      "urn:digitalid:authentication:flow:mobileondevice";

  /// A constant representing the authentication context for UAE Pass web authentication.
  static const String uaePassWebACR =
      "urn:safelayer:tws:policies:authentication:level:low";

  /// The scheme used for UAE Pass in production environment.
  static String uaePassProdScheme = 'uaepass://';

  /// The scheme used for UAE Pass in staging environment.
  static String uaePassStgScheme = 'uaepassstg://';

  /// The base URL for UAE Pass API in production environment.
  static const String _uaePassProdBaseUrl = 'https://id.uaepass.ae';

  /// The base URL for UAE Pass API in staging environment.
  static const String _uaePassStgBaseUrl = 'https://stg-id.uaepass.ae';

  /// Returns the base URL for UAE Pass API based on the environment.
  ///
  /// [isProduction]: A boolean indicating whether the app is running in production environment.
  static String baseUrl(bool isProduction) {
    return isProduction ? _uaePassProdBaseUrl : _uaePassStgBaseUrl;
  }

  /// Returns the scheme used for UAE Pass based on the environment.
  ///
  /// [isProduction]: A boolean indicating whether the app is running in production environment.
  static String uaePassScheme(bool isProduction) {
    return isProduction ? uaePassProdScheme : uaePassStgScheme;
  }
}
