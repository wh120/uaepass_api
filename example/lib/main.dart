import 'package:flutter/material.dart';
import 'package:uaepass_api/uaepass_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAE PASS Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'UAE PASS Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _token;
  UAEPASSUserProfile? _user;
  void _loginOrLogout() async {
    UaePassAPI uaePassAPI = UaePassAPI(
        clientId: "sandbox_stage",
        redirectUri: "https://oauthtest.com/authorization/return",
        clientSecrete: "sandbox_stage",
        appScheme: "exampleScheme",
        isProduction: false);

    try {
      if (_token != null) {
        await uaePassAPI.logout(context);
        _token = null;
        _user = null;
        setState(() {});
        return;
      }
      String? code = await uaePassAPI.signIn(context);

      if (code != null) {
        _token = await uaePassAPI.getAccessToken(code);

        if (_token != null) {
          _user = await uaePassAPI.getUserProfile(_token!);
        }
      } else {}
      setState(() {});
    } catch (e, s) {
      // print(e);
      // print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _token == null
                  ? 'Press button to get token:'
                  : 'Press button to logout:',
            ),
            const SizedBox(
              height: 10,
            ),
            if (_token != null)
              ListTile(
                title: Text("Token:"),
                subtitle: Text("$_token"),
              ),
            if (_user != null)
              Column(
                children: [
                  ListTile(
                    title: Text("Full name:"),
                    subtitle:
                        Text("${_user?.firstnameEN} ${_user?.lastnameEN}"),
                  ),
                ],
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loginOrLogout,
        tooltip: 'login',
        child: const Icon(Icons.login),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
