import 'package:app_gym_yt/components/custom_form_field.dart';
import 'package:app_gym_yt/services/auth_service.dart';
import 'package:app_gym_yt/components/custom_snackbar.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.teal],
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    Image.asset('assets/logo.png', height: 100),
                    const Text("Gym Diary",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: !_isLogin,
                      child: CustomFormField(
                          controller: nameController, label: "Nome"),
                    ),
                    CustomFormField(
                        controller: emailController, label: 'E-mail'),
                    CustomFormField(
                        controller: passwordController,
                        label: 'Senha',
                        isPassword: true),
                    Visibility(
                      visible: !_isLogin,
                      child: CustomFormField(
                          controller: passwordController,
                          label: 'Confirme a senha',
                          isPassword: true,
                          confirmPassword: true),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (_isLogin) {
                              AuthService()
                                  .signIn(emailController.text,
                                      passwordController.text)
                                  .then((value) {
                                if (value != null) {
                                  Navigator.pushReplacementNamed(
                                      context, '/home');
                                } else {
                                  customSnackBar(
                                      context: context,
                                      message: 'Usuário ou senha inválidos');
                                }
                              });
                            } else {
                              AuthService()
                                  .register(emailController.text,
                                      passwordController.text)
                                  .then((value) {
                                if (value != null) {
                                  customSnackBar(
                                      context: context,
                                      message: 'Cadastro efetuado com sucesso',
                                      error: false);
                                  AuthService().saveUser(nameController.text);
                                  setState(() {
                                    _isLogin = !_isLogin;
                                    emailController.clear();
                                    passwordController.clear();
                                    nameController.clear();
                                  });
                                } else {
                                  customSnackBar(
                                      context: context,
                                      message: 'Erro ao fazer cadastro');
                                }
                              });
                            }
                          }
                        },
                        child: Text(_isLogin ? 'Entrar' : 'Cadastrar')),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                          _isLogin
                              ? 'Ainda não tem uma conta? Cadastre-se'
                              : 'Já tem uma conta? Faça login',
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
