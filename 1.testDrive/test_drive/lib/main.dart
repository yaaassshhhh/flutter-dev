import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}
// class Person{
// String name = 'John';
// String name2;
// Person(this.name2);
// factory Person.naming(){
//   return Person('doe');
// }
// void breathe(){
//   print('I am breathing');
// }
// void run(){
//   print('I am running');
// }
// }
// class LivingThing {
//   String name = 'John';
//   final String name2;
//   LivingThing(this.name2);
//   void breathe () {
//       print('I am breathing');
//   }
// }
// class Cat extends LivingThing {
//   Cat(String name2) : super(name2);
//   void meow() {
//     print('meow');
//   }
// }
// extension Run on Cat{
//   void run  () {
//     print('$name2 is running');
//     print('$name is running');
  
// }}
// class Person {
// final String firstName;
// final String lastName;

//   Person(this.firstName,  this.lastName);
// }
// extension FullName on Person {
//   String get fullName => '$firstName $lastName';
// }
//in the function below , the functions return type is not int, the function is returning a future of int and hebce we cant just return a value of type int, we have to return a future of int that is an int that requires some time to be computed. So to awail this future of int that will delivered to us in some time we use Async and await keywords.We mark the function as async and then wait for the computaon to be done and then we print the result.
// Future<int> HeavyCompute(int a){
//   return Future.delayed(const Duration(seconds: 3),()=> a*2);
// }
// void test2() async {
//   print(HeavyCompute(10));
//   print(await HeavyCompute(10));

// }
//just like the function above the function below has the return type <Stream of String> so can not just return a string we need to return a string in the form of streams
// Stream <String> getName(){
//   // return 'Hello'; this is wrong 
//   // return Stream.value("Foo");
//   //the above return statement specifies that we have a pipe of data and the only value that pipe contains is "Foo"
//   //to send a data that is not a stream of data for example a clock ticking every sencond and updating time every minute we use Stream.periodic
//   return Stream.periodic(const Duration(seconds: 1), (value) =>  "foo");
//   //now every second its gonna print "foo"
// } 
//since stream is not a single value that is delivered over time , it is a stream of data that might never end.that ends in future or fails in returning. Unlike Future , we can not just use Await to get the result from a stream . The correct syntax is to use 'Await for' 
// void test3() async {
//   await for (final value in getName()){
//     print(value);
//   }
//   print("Stream finished working");
// } 
// // GENERATORS
// Generators in Dart are special functions that allow you to produce a sequence of values. They are efficient for handling large or infinite sequences of data because they generate values on-demand as they are requested. there are two Generator functions in Dart 
// 1. Sync* : This function is used to return a sequence of values synchronously. It is used when you want to return a sequence of values that are already available.Returns an interable object
// 2. Async* : This function is used to return a sequence of values asynchronously. It is used when you want to return a sequence of values that are not available yet. Returns a stream object

void test ()  {
  // test3();
//  test2();
// Cat('doe').run();
// print(Person('John', 'Doe').fullName);
//   int notu = aged?.;
// int age = 20;
// int ageMinusOne =  --age;
// print(age);
// print(ageMinusOne);
// print('hello what is your name');
// final name = 'John';
// final doe = name * 20;
// print(doe);
// final foo = Person("doe");
// final foo = Person.naming();
// foo.breathe();
// print(foo.name2);
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    test();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below  to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
