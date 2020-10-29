import 'package:dbmonitor/dialogs/customdialog.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CadastroPage extends StatefulWidget {
  CadastroPage({Key key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  var cntNome = TextEditingController();
  var cntEmail = TextEditingController();
  var cntSenha = TextEditingController();
  var cntConfSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      signOut: false,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 2,
                width: 20,
              ),
              buildTextField(
                label: "Nome",
                icon: Icons.person_outline,
                controller: cntNome,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe o nome';
                  }
                  return null;
                },
              ),
              buildTextField(
                label: "E-mail",
                icon: Icons.alternate_email,
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
              buildTextField(
                label: "Senha",
                icon: Icons.lock_outline,
                controller: cntSenha,
                obscure: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe a senha';
                  }
                  if (value != cntConfSenha.text) {
                    return 'As senhas não conferem';
                  }
                  return null;
                },
              ),
              buildTextField(
                label: "Confirme a Senha",
                icon: Icons.lock_outline,
                controller: cntConfSenha,
                obscure: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Confirme a senha';
                  }
                  if (value != cntSenha.text) {
                    return 'As senhas não conferem';
                  }
                  return null;
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      try {
                        var res = await FirebaseAuth.instance
                            .fetchSignInMethodsForEmail(cntEmail.text);

                        if (res.length > 0) {
                          CustomDialog.show(
                              message: "E-mail já cadastrado",
                              context: context);
                          return;
                        }

                        UserCredential result = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: cntEmail.text, password: cntSenha.text);

                        result.user.updateProfile(displayName: cntNome.text);

                        CustomDialog.show(
                            message: "Conta criada com sucesso!",
                            context: context,
                            error: false,
                            dismissible: false);

                        await Future.delayed(
                            const Duration(seconds: 1), () => "1");

                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      } catch (e) {
                        CustomDialog.show(message: e.code, context: context);
                      }
                    }
                  },
                  child: Text('Cadastrar'),
                ),
              ),
            ],
          ),
        ),
      ),
      title: "Cadastro",
      leading: false,
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
