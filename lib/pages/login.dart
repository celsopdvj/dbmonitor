import 'package:dbmonitor/dialogs/customdialog.dart';
import 'package:dbmonitor/pages/cadastro.dart';
import 'package:dbmonitor/pages/password.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var cntEmail = TextEditingController();
  var cntSenha = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _focusSenha = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: FlareActor("assets/animations/database.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          animation: "einmal"),
                      height: 300,
                    ),
                    buildTextField(
                      icon: Icons.alternate_email,
                      label: "Email",
                      onEditingComplete: () => _focusSenha.requestFocus(),
                      controller: cntEmail,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Informe o e-mail';
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    buildTextField(
                        icon: Icons.lock_outline,
                        label: "Senha",
                        focus: _focusSenha,
                        controller: cntSenha,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe a senha';
                          }
                          return null;
                        },
                        obscure: true),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        child: Text("Login"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            try {
                              UserCredential credential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                      email: cntEmail.text,
                                      password: cntSenha.text);
                              print("credential.user" +
                                  credential.user.displayName);
                            } on FirebaseAuthException catch (e) {
                              var error = e.code;
                              var errorMessage = "";

                              switch (error) {
                                case "invalid-email":
                                case "wrong-password":
                                case "user-not-found":
                                  errorMessage = "E-mail e/ou senha inválidos";
                                  break;
                                case "user-disabled":
                                  errorMessage = "Usuário invativo";
                                  break;
                                default:
                              }

                              CustomDialog.show(
                                  message: errorMessage, context: context);
                            } catch (e) {
                              CustomDialog.show(
                                  message: "Erro desconhecido",
                                  context: context);
                            }
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PasswordPage()));
                          },
                          child: Text("Esqueci minha senha",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                letterSpacing: .5,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                        ),
                        Text("|",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              letterSpacing: .5,
                              fontWeight: FontWeight.w600,
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CadastroPage()));
                          },
                          child: Text(
                            "Cadastre-se",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: .5,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      title: "Login",
      appBar: false,
    );
  }

  Widget buildTextField(
      {String label,
      IconData icon,
      Function validator,
      Function onEditingComplete,
      FocusNode focus,
      bool obscure = false,
      TextEditingController controller}) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      obscureText: obscure,
      controller: controller,
      onEditingComplete: onEditingComplete,
      focusNode: focus,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        labelText: label,
        fillColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        labelStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
          color: Colors.white,
        )),
      ),
      validator: (value) => validator(value),
    );
  }
}
