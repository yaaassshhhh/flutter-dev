import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void log(message) => print(message);

//creating a login view to register the user;
class LoginView extends StatefulWidget {
  const LoginView({super.key});
//creating a state for the login view;
  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
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
          title: const Text('Login'),
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
                        // final userCredential = await FirebaseAuth.instance
                        //     .createUserWithEmailAndPassword(
                        //         email: userEmail, password: userPassword);
                        // print(userCredential);
                        //11-the above code was to create a user but we are now going to login the user;
                        //to handle expected errors we use try and catch block;
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: userEmail, password: userPassword);
                          log(userCredential);
                        } on FirebaseAuthException catch (e) {
                          log(e.code);
                          // if(e.code == 'user-not-found') {
                          //   log('No user found for that email');
                          // }
                          // else if(e.code == 'wrong-password') {
                          //   log('Wrong password provided for that user');
                          // }
                          switch (e.code) {
                            case 'user-not-found':
                              log('No user found for that email');
                              break;
                            case 'invalid-credential':
                              log('Wrong Email or password provided for the user');
                              break;
                            case 'invalid-email':
                              log('Please enter a valid email address');
                              break;
                          }
                        } catch (e) {
                          log('something bad happended $e');
                          log(e.runtimeType);
                        }
                      },
                      child: const Text('Login'),
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
