import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:uaepass_api/uaepass/const.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';

class UaePassLoginView extends StatefulWidget {
  final String url;
  final String urlScheme;
  final bool isProduction;

  const UaePassLoginView(
      {super.key,
      required this.url,
      required this.urlScheme,
      required this.isProduction});

  @override
  State<UaePassLoginView> createState() => _UaePassLoginViewState();
}

class _UaePassLoginViewState extends State<UaePassLoginView> {
  InAppWebViewController? webViewController;
  String? successUrl;
  late StreamSubscription<FGBGType> subscription;

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    subscription = FGBGEvents.stream.listen((event) {
      if (event == FGBGType.foreground) {
        if (successUrl != null) {
          final decoded = Uri.decodeFull(successUrl!);
          webViewController?.loadUrl(
            urlRequest: URLRequest(
              url: WebUri.uri(Uri.parse(decoded)),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //    appBar: buildAppBar(context),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(widget.url))),
        initialSettings: InAppWebViewSettings(
            transparentBackground: true,
            supportZoom: false,
            useShouldOverrideUrlLoading: true),
        onWebViewCreated: (controller) async {
          InAppWebViewController.clearAllCache();
          webViewController = controller;
          webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri.uri(Uri.parse(widget.url))));
        },
        shouldOverrideUrlLoading: (controller, uri) async {
          String url = uri.request.url.toString();
          if (url.contains('uaepass://')) {
            Uri uri = Uri.parse(url);
            String? successURL = uri.queryParameters['successurl'];
            successUrl = successURL;

            final newUrl =
                '${Const.uaePassScheme(widget.isProduction)}${uri.host}${uri.path}';

            String u = "$newUrl?successurl=${widget.urlScheme}"
                "&failureurl=${widget.urlScheme}"
                "&closeondone=true";

            await launchUrl(Uri.parse(u));
            return NavigationActionPolicy.CANCEL;
          }

          if (url.contains('code=')) {
            final code = Uri.parse(url).queryParameters['code']!;
            Navigator.pop(context, code);
          } else if (url.contains('cancelled')) {
            {}

            Navigator.pop(context);
          }
          return null;
        },
      ),
    );
  }
}
