import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Form validation Demo',
      theme: new ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: new FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final TextEditingController textEditingController=new TextEditingController();
  final scaffoldKey=new GlobalKey<ScaffoldState>();
  final formKey=new GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.addListener(printSomeValue);
  }

  printSomeValue(){
    print("Controllar value ${textEditingController.text}");
  }
  @override
  void dispose() {
    // TODO: implement dispose
     textEditingController.removeListener(printSomeValue);
     textEditingController.dispose();
    super.dispose();

  }

  void _submit(){
    final form=formKey.currentState;
    if(form.validate()){
      form.save();

      performLogin();
    }
  }
  void performLogin(){
    final snackbar=new SnackBar(
        content:new Text("Email :$_email,password :$_password" )
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Form page"),

      ),
      body:new Padding(padding: const EdgeInsets.all(20.0),
      child: new Form(
          key: formKey,
         child: new Column(
           children: <Widget>[
             new TextFormField(
               decoration: new InputDecoration(labelText: "Email"),
                validator: (val)=>!val.contains("@")?'Invalid Email' :null,
               onSaved: (val)=>_email=val,

             ),
             new TextFormField(
               decoration: new InputDecoration(labelText: "Password"),
               validator: (val)=>val.length<6?'password to short':null,
               onSaved: (val)=>_password=val,
               obscureText: true,

             ),
             new Padding(padding: const EdgeInsets.only(top: 20.0)),
             new RaisedButton(
                 onPressed: _submit,
               child: new Text("Login"),
             )
           ],
         ),
      ))
    );
  }
}


