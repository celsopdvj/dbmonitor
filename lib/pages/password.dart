import 'package:dbmonitor/dialogs/customdialog.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordPage extends StatefulWidget {
  PasswordPage({Key key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  var cntEmail = TextEditingController();
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
                Builder(
                  builder: (ctx) => Container(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: cntEmail.text);
                            CustomDialog.show(
                                message:
                                    "E-mail para recuperação de senha enviado",
                                context: context);
                          } catch (e) {
                            if (e.code == "ERROR_USER_NOT_FOUND") {
                              CustomDialog.show(
                                  message: "E-mail não cadastrado.",
                                  context: context);
                            }
                            if (e.code == "ERROR_INVALID_EMAIL") {
                              CustomDialog.show(
                                  message: "E-mail mal formatado.",
                                  context: context);
                            }
                            CustomDialog.show(
                                message: e.code, context: context);
                          }
                        }
                      },
                      child: Text('Enviar e-mail'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      title: "Esqueci minha senha",
      leading: false,
      signOut: false,
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
      controller: controller,
      obscureText: obscure,
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
