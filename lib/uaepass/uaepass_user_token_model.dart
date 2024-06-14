class UAEPASSUserToken {
  String? accessToken;
  String? scope;
  String? tokenType;
  int? expiresIn;

  UAEPASSUserToken(
      {this.accessToken, this.scope, this.tokenType, this.expiresIn});

  UAEPASSUserToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    scope = json['scope'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }
}
