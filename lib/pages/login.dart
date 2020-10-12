import 'package:dbmonitor/pages/cadastro.dart';
import 'package:dbmonitor/pages/template.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTextField(
                icon: Icons.email,
                label: "Email",
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe o e-mail';
                  }
                  return null;
                },
              ),
              buildTextField(
                icon: Icons.lock,
                label: "Senha",
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe a senha';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  child: Text("Login"),
                  onPressed: () => true,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CadastroPage()));
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
      title: "Login",
      appBar: false,
    );
  }

  Widget buildTextField({String label, IconData icon, Function validator}) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
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
