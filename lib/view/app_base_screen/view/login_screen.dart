// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:salesmantracking_and_ordermanagment/app_base_screen.dart';
// import 'package:salesmantracking_and_ordermanagment/provider/forgot_password_provider.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final isForgotPasswordSelected =
//         context.watch<LoginScreenProvider>().isForgotPasswordSelected;
//
//     return Scaffold(
//       backgroundColor: const Color(0XFFE3E3E3),
//       body: Column(
//         children: [
//           Container(
//             width: double.maxFinite,
//             height: 300,
//             decoration: const BoxDecoration(
//               color: Color(0XFFFFFFFF),
//               borderRadius: BorderRadius.only(
//                 bottomRight: Radius.circular(30),
//                 bottomLeft: Radius.circular(30),
//               ),
//             ),
//             child: const Center(
//               child: Image(
//                 image: AssetImage("assets/images/tracking_plane.png"),
//                 height: 130,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//
//           Column(
//             children: [
//               Visibility(
//                 visible: !isForgotPasswordSelected,
//                 child: Expanded(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           TextField(
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: const Color(0xFFFFFFFF),
//                               hintText: "Username, Mobile Number",
//                               hintStyle: const TextStyle(
//                                   color: Color(0xFFA0A0A0),
//                                   fontWeight: FontWeight.w400),
//                               contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 15.0, horizontal: 15.0),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 borderSide: BorderSide.none,
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 borderSide: BorderSide.none,
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                             style: const TextStyle(),
//                           ),
//                           const SizedBox(
//                             height: 18,
//                           ),
//                           TextField(
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: const Color(0xFFFFFFFF),
//                               hintText: "Password",
//                               hintStyle: const TextStyle(
//                                   color: Color(0xFFA0A0A0),
//                                   fontWeight: FontWeight.w400),
//                               contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 15.0, horizontal: 15.0),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 borderSide: BorderSide.none,
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 borderSide: BorderSide.none,
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                             style: const TextStyle(),
//                           ),
//                           const SizedBox(
//                             height: 18,
//                           ),
//                           InkWell(
//                             onTap: () {
//                               context
//                                   .read<LoginScreenProvider>()
//                                   .showForgotPassword();
//                             },
//                             child: const Text(
//                               "Forgot password?",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0XFFFA4A0C)),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 25,
//                           ),
//                           SizedBox(
//                             width: double.maxFinite,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const BaseScreen()),
//                                 );
//                               },
//                               style: ElevatedButton.styleFrom(
//                                   elevation: 0,
//                                   backgroundColor: const Color(0XFF094497)),
//                               child: const Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 13.0),
//                                 child: Text(
//                                   "Login",
//                                   style: TextStyle(
//                                       color: Color(0XFFF6F6F9),
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 17),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           const Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "Or",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w600, fontSize: 18),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 25,
//                           ),
//                           SizedBox(
//                             width: double.maxFinite,
//                             child: ElevatedButton(
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                   elevation: 0,
//                                   backgroundColor: const Color(0XFF1877F2)),
//                               child: const Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 13.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Image(
//                                       image: AssetImage(
//                                           'assets/images/Facebook Logo.png'),
//                                       height: 20,
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Text(
//                                       "Log In with Facebook",
//                                       style: TextStyle(
//                                           color: Color(0XFFFFFFFF),
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 20),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 25,
//                           ),
//                           SizedBox(
//                             width: double.maxFinite,
//                             child: ElevatedButton(
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                   elevation: 0,
//                                   backgroundColor: const Color(0XFFFFFFFF)),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 13.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     const Image(
//                                       image: AssetImage(
//                                           'assets/images/Google Logo.png'),
//                                       height: 20,
//                                     ),
//                                     const SizedBox(
//                                       width: 7,
//                                     ),
//                                     Text(
//                                       "Log In with Google",
//                                       style: TextStyle(
//                                           color: const Color(0XFF000000)
//                                               .withOpacity(0.54),
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 20),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 40,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Visibility(
//             visible: isForgotPasswordSelected,
//             child: Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       InkWell(
//                           onTap: () {
//                             context.read<LoginScreenProvider>().showLoginForm();
//                           },
//                           child: SizedBox(
//                               height: 22,
//                               width: 22,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(1.0),
//                                 child: SvgPicture.asset(
//                                     "assets/images/backbutton.svg"),
//                               ))),
//                       const SizedBox(
//                         height: 36,
//                       ),
//                       const Text(
//                         "Forgot\npassword?",
//                         style: TextStyle(
//                             color: Color(0XFF094497),
//                             fontWeight: FontWeight.w700,
//                             fontSize: 36),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextField(
//                         decoration: InputDecoration(
//                           prefixIcon: Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: SvgPicture.asset(
//                               "assets/images/Mail.svg",
//                               fit: BoxFit.scaleDown,
//                             ),
//                           ),
//                           filled: true,
//                           fillColor: const Color(0xFFFFFFFF),
//                           hintText: "Enter your email address",
//                           hintStyle: const TextStyle(
//                             color: Color(0xFF676767),
//                             fontWeight: FontWeight.w400,
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                               vertical: 15.0, horizontal: 15.0),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide.none,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide.none,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         style: const TextStyle(),
//                       ),
//                       const SizedBox(
//                         height: 28,
//                       ),
//                       RichText(
//                         text: const TextSpan(
//                           children: [
//                             TextSpan(
//                               text: '* ',
//                               style: TextStyle(
//                                 color: Colors.red,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             TextSpan(
//                               text:
//                                   'We will send you a message to set or reset your new password',
//                               style: TextStyle(
//                                 color: Color(0xFF676767),
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 36,
//                       ),
//                       const Text(
//                         "Send code",
//                         style: TextStyle(
//                             color: Color(0XFFB2B2B2),
//                             fontSize: 24,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       const SizedBox(
//                         height: 33,
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: InkWell(
//                           onTap: () {},
//                           borderRadius: BorderRadius.circular(30),
//                           child: Container(
//                             width: 51,
//                             height: 51,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: const Color(0XFF094497),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color:
//                                       const Color(0XFF094497).withOpacity(0.5),
//                                   blurRadius: 15,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             child: const Icon(
//                               Icons.arrow_forward,
//                               color: Colors.white, // Icon color
//                               size: 25, // Icon size
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 50,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           /// register
//           Visibility(
//             visible: false,
//             child: Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Column(
//                     children: [
//                       const SizedBox(
//                         height: 50,
//                       ),
//                       Row(
//                         children: [
//                           const Text(
//                             "Register",
//                             style: TextStyle(
//                                 color: Color(0XFF094497),
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 36),
//                           ),
//                           const Spacer(),
//                           Container(
//                             height: 45,
//                             width: 45,
//                             decoration: BoxDecoration(
//                                 color: const Color(0xffFFFFFF),
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: SvgPicture.asset(
//                                   "assets/images/flat-color-icons_google.svg"),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 16,
//                           ),
//                           Container(
//                             height: 45,
//                             width: 45,
//                             decoration: BoxDecoration(
//                                 color: const Color(0xffFFFFFF),
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: SvgPicture.asset(
//                                   "assets/images/logos_facebook.svg"),
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextField(
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: const Color(0xFFFFFFFF),
//                           hintText: "Full Name",
//                           hintStyle: const TextStyle(
//                               color: Color(0xFFA0A0A0),
//                               fontWeight: FontWeight.w400),
//                           contentPadding: const EdgeInsets.symmetric(
//                               vertical: 15.0, horizontal: 15.0),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide.none,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide.none,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         style: const TextStyle(),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextField(
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: const Color(0xFFFFFFFF),
//                           hintText: "Mobile Number",
//                           hintStyle: const TextStyle(
//                               color: Color(0xFFA0A0A0),
//                               fontWeight: FontWeight.w400),
//                           contentPadding: const EdgeInsets.symmetric(
//                               vertical: 15.0, horizontal: 15.0),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide.none,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide.none,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         style: const TextStyle(),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextField(
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: const Color(0xFFFFFFFF),
//                           hintText: "Password",
//                           hintStyle: const TextStyle(
//                               color: Color(0xFFA0A0A0),
//                               fontWeight: FontWeight.w400),
//                           contentPadding: const EdgeInsets.symmetric(
//                               vertical: 15.0, horizontal: 15.0),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide.none,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide.none,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         style: const TextStyle(),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextField(
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: const Color(0xFFFFFFFF),
//                           hintText: "Confirm Password",
//                           hintStyle: const TextStyle(
//                               color: Color(0xFFA0A0A0),
//                               fontWeight: FontWeight.w400),
//                           contentPadding: const EdgeInsets.symmetric(
//                               vertical: 15.0, horizontal: 15.0),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide.none,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide.none,
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         style: const TextStyle(),
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: ElevatedButton(
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                   elevation: 0,
//                                   backgroundColor: const Color(0XFF094497)),
//                               child: const Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 13.0),
//                                 child: Text(
//                                   "Sign-up",
//                                   style: TextStyle(
//                                       color: Color(0XFFF6F6F9),
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 17),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           const SizedBox(
//                             width: 130,
//                             child: Text(
//                               "Already a Member? Login",
//                               style: TextStyle(
//                                   color: Color(0XFFB3B3B3),
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 16),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
