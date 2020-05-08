import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sharing_content/api/user_api.dart';
import 'package:sharing_content/models/user.dart';
import 'package:sharing_content/notifiers/auth_notifier.dart';
import 'package:sharing_content/pages/initial_pages/StartingPage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => AuthNotifier(),
          create: (BuildContext context) {
            return AuthNotifier();
          },
        ),
        // ChangeNotifierProvider(
        //   builder: (context) => BookNotifier(),
        //   create : (BuildContext context){
        //     return BookNotifier();
        //   },
        // )
      ],
      child: TaskApp(),
    ));
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(     
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
            appBarTheme: AppBarTheme(
              brightness: Brightness.light,
              elevation: 5,
              color: ThemeData.light().canvasColor,
            )
        ),
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          return notifier.user != null || notifier.guser != null ? Task() : StartingPage();
          //return notifier.guser != null ? Task() : Login();
        },
      ),
    );
  }
}


class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}

class Task extends StatelessWidget {
   //final id;
  //const Task({Key key, this.id}) : super(key: key);
  User user = User();
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Tasks'),),
      body: Column(
        children: <Widget>[
          //Center(child:Text(user.id)),
          RaisedButton(onPressed: () =>signout(authNotifier),),
          RaisedButton(onPressed: () =>handleSignOut(),),

        ],
      ),
    );
  }
}