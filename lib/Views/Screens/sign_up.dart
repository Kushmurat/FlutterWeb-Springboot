// import 'dart:developer';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutterapp/Views/Screens/auth_screen.dart';
//
// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool _isLoading = false;
//   String? _error;
//   bool _obscurePassword = true;
//
//   Future<void> _register() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       _isLoading = true;
//       _error = null;
//     });
//
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text,
//       );
//     } on FirebaseAuthException catch (e) {
//       log("error createUserWithEmailAndPassword: $e");
//       setState(() {
//         _error = e.message;
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F6F6),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF6F6F6),
//         title: const Text('Регистрация'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//           child: Form(
//             key: _formKey,
//             child: AutofillGroup(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   if (_error != null)
//                     Text(
//                       _error!,
//                       style: const TextStyle(color: Colors.red),
//                       textAlign: TextAlign.center,
//                     ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 40),
//                     child: TextFormField(
//                       controller: _emailController,
//                       autofillHints: const [AutofillHints.email],
//                       keyboardType: TextInputType.emailAddress,
//                       textInputAction: TextInputAction.next,
//                       decoration: const InputDecoration(
//                         labelText: 'Email',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) => value != null && value.contains('@')
//                           ? null
//                           : 'Введите корректный email',
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 40),
//                     child: TextFormField(
//                       controller: _passwordController,
//                       autofillHints: const [AutofillHints.newPassword],
//                       obscureText: _obscurePassword,
//                       textInputAction: TextInputAction.done,
//                       onFieldSubmitted: (_) => _register(),
//                       decoration: InputDecoration(
//                         labelText: 'Пароль',
//                         border: const OutlineInputBorder(),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscurePassword = !_obscurePassword;
//                             });
//                           },
//                         ),
//                       ),
//                       validator: (value) => value != null && value.length >= 6
//                           ? null
//                           : 'Минимум 6 символов',
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   _isLoading
//                       ? const Center(child: CircularProgressIndicator())
//                       : Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 40),
//                     child: ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurple,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 24, vertical: 12),
//                       ),
//                       onPressed: _register,
//                       icon: const Icon(Icons.app_registration),
//                       label: const Text('Зарегистрироваться'),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                             builder: (_) => const AuthScreen()), // переход к входу
//                       );
//                     },
//                     child: const Text(
//                       'Уже есть аккаунт? Войти',
//                       style: TextStyle(color: Colors.deepPurple),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
