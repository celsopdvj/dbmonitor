import 'package:dbmonitor/dialogs/customdialog.dart';
import 'package:dbmonitor/pages/cadastro.dart';
import 'package:dbmonitor/pages/password.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dbmonitor/redux/globalvariables.dart' as gv;

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var cntEmail = TextEditingController();
  var cntSenha = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "DbMonitor",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  "assets/images/monitoramento.png",
                  width: 150,
                  height: 150,
                ),
                buildTextField(
                  icon: Icons.alternate_email,
                  label: "Email",
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
                    controller: cntSenha,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Informe a senha';
                      }
                      return null;
                    },
                    obscure: true),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
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
                        fontWeight: FontWeight.normal,
                      )),
                ),
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
                          var result = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: cntEmail.text,
                                  password: cntSenha.text);
                          gv.GlobalVariables.uuidUser = result.user.uid;
                        } catch (e) {
                          CustomDialog.show(message: e.code, context: context);
                        }
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CadastroPage()));
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Não tem uma conta? ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: "Cadastre",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      title: "Login",
      appBar: false,
    );
  }

  Widget buildTextField(
      {String label,
      IconData icon,
      Function validator,
      bool obscure = false,
      TextEditingController controller}) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      obscureText: obscure,
      controller: controller,
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
