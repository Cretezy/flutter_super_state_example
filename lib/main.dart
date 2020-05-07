import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_super_state/flutter_super_state.dart';
import 'package:state_test/src/store/auth.dart';
import 'package:state_test/src/store/counter.dart';

void main() {
  // Create the store
  final store = Store();

  // Register modules
  CounterModule(store);
  AuthModule(store);

  // Provide store to whole application
  runApp(StoreProvider(
    store: store,
    child: ExampleApp(),
  ));
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        // Login button
        child: ModuleBuilder<AuthModule>(
          builder: (context, authModule) {
            return RaisedButton(
              child: Text("Login"),
              onPressed: () async {
                // Call action
                await authModule.login();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CounterScreen()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Our counter module
          ModuleBuilder<CounterModule>(
            builder: (context, counterModule) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Increment"),
                    onPressed: () => counterModule.increment(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(counterModule.counter.toString()),
                  ),
                  RaisedButton(
                    child: Text("Decrement"),
                    onPressed: () => counterModule.decrement(),
                  ),
                ],
              );
            },
          ),
          // Logout button
          ModuleBuilder<AuthModule>(
            builder: (context, authModule) {
              return RaisedButton(
                child: Text("Logout"),
                onPressed: () async {
                  await authModule.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
