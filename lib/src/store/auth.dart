import 'package:flutter_super_state/flutter_super_state.dart';
import 'package:state_test/src/store/counter.dart';

class AuthModule extends StoreModule<AuthModule> {
  int get isLoggedIn => isLoggedIn;
  var _isLoggedIn = false;

  AuthModule(Store store) : super(store);

  Future<void> login() async {
    // Do network request...
    await Future.delayed(Duration(milliseconds: 100));

    setState(() {
      _isLoggedIn = true;
    });
  }

  Future<void> logout() async {
    // Do network request...
    await Future.delayed(Duration(milliseconds: 100));

    setState(() {
      _isLoggedIn = true;
    });

    // Call action in other module
    await store.getModule<CounterModule>().reset();
  }
}
