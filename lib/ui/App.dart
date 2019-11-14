import 'package:flutter/material.dart';
import 'package:flutter_apps/utility/sharedpreferences.dart';

import 'list_movie.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LoginForm(),
      ),
      routes: <String, WidgetBuilder>{
        '/movie_list': (BuildContext context) => ListMovie(),
        '/login': (BuildContext context) => LoginForm(),
      },
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> keyScaffold = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper.checkKey(SharedPreferencesHelper.userLogin)
        .then((onValue) {
      if (onValue) {
        //Pindah Page Ke Movie List Tanpa Bisa Back
        Navigator.pushReplacementNamed(context, '/movie_list');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyScaffold,
      body: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  'lib/assets/background.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Container(color: Colors.white.withOpacity(0.2))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('lib/assets/logo.jpeg', height: 50),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: emailController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(hintText: 'email'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: passwordController,
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'password',
                  ),
                ),
              ),
              Flexible(
                child: RaisedButton(
                  onPressed: () =>
                      checkUser(emailController.text, passwordController.text),
                  color: Colors.green,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.blue[900]),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void checkUser(String email, String password) {
    if (email == 'enoraden@gmail.com' && password == '12345') {
      //Simpan Email ke Cache
      SharedPreferencesHelper.setPreferences(
          email, SharedPreferencesHelper.userLogin);

      Navigator.pushReplacementNamed(
          context, '/movie_list'); //Navigation ke List Movie
    } else {
      keyScaffold.currentState.showSnackBar(
        SnackBar(
          content: Text('Username not found'),
        ),
      );
    }
  }
}
