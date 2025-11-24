import 'package:diet_plan_app/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Home_Page.dart';

class AppColors {
  AppColors._();
  static const primary = Color(0xFF00AF54);
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final mobile = TextEditingController();

  @override
  void dispose() {
    mobile.dispose();
    super.dispose();
  }

  // Future<void>? _initialization;
  //
  // Future<void> _ensureInitialized() {
  //   return _initialization ??=
  //   GoogleSignInPlatform.instance.init(const InitParameters())
  //     ..catchError((dynamic _) {
  //       _initialization = null;
  //     });
  // }
  //
  // Future<void> _handleSignIn() async {
  //   try {
  //     await _ensureInitialized();
  //     final AuthenticationResults result = await GoogleSignInPlatform.instance
  //         .authenticate(const AuthenticateParameters());
  //     _setUser(result.user);
  //   } on GoogleSignInException catch (e) {
  //     setState(() {
  //       _errorMessage = e.code == GoogleSignInExceptionCode.canceled
  //           ? ''
  //           : 'GoogleSignInException ${e.code}: ${e.description}';
  //     });
  //   }
  // }

  // Future<bool>login() async{
  //   final user = await GoogleSignIn().signIn();
  //   GoogleSignInAuthentication userAuth = await user?.authentication;
  //   var credential = GoogleAuthProvider.credential(idToken: userAuth.idToken,accessToken:userAuth.accessToken);
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  //   return FirebaseAuth.instance.currentUser != null;
  //
  //
  // }


  Widget buildOrDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: Colors.grey.shade400)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "OR",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: Colors.grey.shade400)),
      ],
    );
  }

  Widget buildSignupDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: Colors.grey.shade400)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Log in or sign up",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: Colors.grey.shade400)),
      ],
    );
  }

  Future<void> _sendOtp() async {
    final phoneNumber = mobile.text.trim();

    if (phoneNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a valid 10-digit mobile number")),
      );
      return;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException ex) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ex.message ?? "Verification failed")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("OTP sent to +91 $phoneNumber")),
        );

        print("Phone: $phoneNumber");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => OtpScreen(verificationId: verificationId),
          ),
        );
      },

      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 320,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 140),
                      Image(image: AssetImage("assets/images/logo.webp")),
                      SizedBox(height: 30),
                      buildSignupDivider(),
                      const SizedBox(height: 20),

                      TextField(
                        keyboardType: TextInputType.phone,
                        controller: mobile,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Mobile',
                          labelStyle: const TextStyle(color: Colors.grey),
                          floatingLabelStyle: TextStyle(
                            color: AppColors.primary,
                          ),
                          prefixText: "+91 ",
                          prefixStyle: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 115,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: _sendOtp,
                        child: const Text(
                          "Generate Otp",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),

                      SizedBox(height: 20),
                      buildOrDivider(),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Gmail Avatar
                          GestureDetector(
                            onTap: () {
                              // bool isLogged = await login();
                              // if(isLogged){
                              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
                              // }
                              print("Login with Google");
                            },
                            child: CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.white,
                              child: Image.asset(
                                "assets/images/google.webp",
                                height: 32,
                                width: 32,
                              ),
                            ),
                          ),

                          SizedBox(width: 30),

                          // Email Avatar
                          GestureDetector(
                            onTap: () {
                              print("Login with Email");
                            },
                            child: CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.email_outlined,
                                color: AppColors.primary,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
