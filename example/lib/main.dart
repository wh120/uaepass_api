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

  String _token = "";
  bool _isLoading = false;
  void _login() async{
    if(_isLoading){
      return;
    }

    UaePassAPI uaePassAPI =UaePassAPI(
        clientId: "sandbox_stage",
        redirectUri: "https://stg-ids.uaepass.ae",
        clientSecrete: "sandbox_stage",
        appScheme: "example_scheme",
        isProduction: false
    );
    setState(() {
      _isLoading = true;

    });
   try {
     String? code = await  uaePassAPI.signIn(context);
     if(code != null){
       _token = await uaePassAPI.getAccessToken(code)??"";
       setState(() {
         _isLoading = false;

       });
     }
   }  catch (e) {
     // TODO
   }

    setState(() {
      _isLoading = true;

    });


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
            const Text(
              'Press Login to get token:',
            ),
            Text(
              '$_token',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _login,
        tooltip: 'login',
        child: const Icon(Icons.login),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
