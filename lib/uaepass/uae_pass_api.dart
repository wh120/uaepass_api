import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uaepass_api/uaepass/const.dart';
import 'package:uaepass_api/uaepass/uaepass_view.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'uaepass_user_token_model.dart';

class UaePassAPI {
  final String clientId;
  final String redirectUri;
  final String clientSecrete;
  final String appScheme;
  final bool isProduction;

  UaePassAPI(
      {required this.clientId,
      required this.redirectUri,
      required this.clientSecrete,
      required this.appScheme,
      required this.isProduction});

  Future<String> getURL() async {
    String acr = Const.uaePassMobileACR;
    String acrWeb = Const.uaePassWebACR;

    bool withApp = await canLaunchUrlString(
      '${Const.uaePassScheme(isProduction)}digitalid-users-ids',
    );
    if (!withApp) {
      acr = acrWeb;
    }
    String url = "${Const.baseUrl(isProduction)}/idshub/authorize?"
        "response_type=code"
        "&client_id=$clientId"
        "&scope=urn:uae:digitalid:profile:general"
        "&state=HnlHOJTkTb66Y5H"
        "&redirect_uri=$redirectUri"
        "&acr_values=$acr";

    return url;
  }

  Future<String?> signIn(BuildContext context) async {
    String url = await getURL();
    if (context.mounted) {
      return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UaePassLoginView(
          url: url,
          urlScheme: appScheme,
          isProduction: isProduction,
        ),
      ),
    );
    }
    return null;
  }

  Future<String?> getAccessToken(String code) async {
    try {
      const String url = "/idshub/token";

      var data = {
        'redirect_uri': redirectUri,
        'client_id': clientId,
        'client_secret': clientSecrete,
        'grant_type': 'authorization_code',
        'code': code
      };

      final response = await http.post(
        Uri.parse(Const.baseUrl(isProduction) + url),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        return UAEPASSUserToken.fromJson(jsonDecode(response.body)).accessToken;
      } else {
        return null;
      }
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }

    }
    return null;
  }

  logout() {}
}
