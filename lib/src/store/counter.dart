import 'package:flutter_super_state/flutter_super_state.dart';

// Modules extend `StoreModule`
class CounterModule extends StoreModule {
  // Read only property, to avoid accidentally setting `counter` without calling `setState`
  int get counter => _counter;
  var _counter = 0;

  // This automatically registers your module to your store
  CounterModule(Store store) : super(store);

  // Synchronous actions
  void increment() {
    setState(() {
      _counter++;
    });
  }

  void decrement() {
    setState(() {
      _counter--;
    });
  }

  // Asynchronous action
  Future<void> reset() async {
    // Fake async delay
    await Future.delayed(Duration(milliseconds: 10));

    setState(() {
      _counter = 0;
    });
  }
}
