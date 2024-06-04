import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/views/login_view.dart';
import 'firebase_options.dart';

void log(message) => print(message);
void main() {
  //5 - we need to initialize the firebase app before we run the app and for that we will need this WidgetsFlutterBinding.ensureInitialized() method to be called before runApp() method in orderr to procees to future builder we need connection to the flutter engine which is provided by this method;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RegisterView(),
    ),
  );
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => RregisterViewState();
}

class RregisterViewState extends State<RegisterView> {
  //2- now we will create our text editing controllers;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  //init state is used to initialize previously defined variables for our stateful widget register view and is called when the widget is inserted into the widget tree for the first time;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

//dispose is used to clean up the resources that are used by the stateful widget when it is removed from the widget tree and is also called only once;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //build method is used to build the UI of the stateful widget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          backgroundColor: Colors.blue.shade200,
        ),
        //6-the futurreBuilder widget is used to build the UI based on the future object that is returned by the builder function we will wait for the initialization of the firebase app and then build the UI;
        body: FutureBuilder(
          //7- the future property of the futureBuilder widget is used to provide the future object that we want to wait for before building the UI
          //4-before we start authentication we need to first tell firebase about our app and thus initialize it
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          //8- the builder property of the futureBuilder widget is used to build the UI based on the future object that is returned by the future property
          builder: (context, snapshot) {
            //9- snapshot is similar to isLoading in Next.js and we can use it to check if the future object has been resolved or not
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    //1-we need to take the input from these text fields and pass it to firebase using the register button .To grab hold of the text fields in the onPressed function of the button we need to use the TextEditingController class
                    //the TextEditingController acts as a proxy and continously eads and pastes the data from the textFields to the onPressed function of the button
                    //Thus a state is to be managed and that is why our home page cannot be a stateless widget. It has to be a stateful widget;
                    TextField(
                      controller: _emailController,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter Your Email here',
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Enter Your Password here',
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final userEmail = _emailController.text;
                        final userPassword = _passwordController.text;

                        //3-creating the user with firebase
                        //createUserWithEmailAndPassword is a method that is provided by the FirebaseAuth class and returns a Future object
                        //and we have to use await here other we will get an instance of future object and not the user credentials;
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: userEmail, password: userPassword);
                          log(userCredential);
                        } on FirebaseAuthException catch (e) {
                          log(e.code);
                          switch (e.code) {
                            case 'weak-password':
                              log('Please enter a stronger password');
                              break;
                            case 'invalid-email':
                              log('The email address is badly formatted.');
                            case 'email-already-in-use':
                              log('The account already exists for that email.Try to login instead or register using a different email.');
                              break;
                          }
                        } catch (e) {
                          log('something bad happended $e');
                          log(e.runtimeType);
                        }
                      },
                      child: const Text('Register'),
                    )
                  ],
                );
              default:
                return const Text('Loading...');
            }
          },
        ));
  }
}
//(Fn + f2) to smart rename any variable or class name in the entire project;
//10-moved login view to its own folder;

