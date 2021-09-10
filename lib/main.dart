import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Email Sender',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Email Sender'),
        ),
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  bool _enableBtn = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  String? _validatorInputs(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: (() {
        setState(() {
          _enableBtn = _formKey.currentState!.validate();
        });
      }),
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          _createSubjectInput(),
          Divider(),
          _createEmailInput(),
          Divider(),
          _createTextInput(),
          Divider(),
          _createSubmitButton(),
        ],
      ),
    );
  }

  Widget _createSubjectInput() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: _validatorInputs,
      controller: subjectController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: "Subject email",
        labelText: "Subject",
        icon: Icon(Icons.subject),
      ),
    );
  }

  Widget _createEmailInput() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: _validatorInputs,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: "Email",
        labelText: "Email",
        icon: Icon(Icons.email),
      ),
    );
  }

  Widget _createTextInput() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: _validatorInputs,
      controller: messageController,
      maxLines: 10,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: "Message text",
        labelText: "Message",
        icon: Icon(Icons.text_fields),
      ),
    );
  }

  Widget _createSubmitButton() {
    return ElevatedButton(
      onPressed: _validate,
      child: Text(
        'Submit',
        style: TextStyle(fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(50, 50),
        primary: Colors.blue,
        shape: StadiumBorder(),
      ),
    );
  }

  void _validate() {
    print(_enableBtn);
    // _formKey.currentState!.validate()
    _enableBtn ? _sendEmail() : print("no funciona pa");
  }

  void _sendEmail() async {
    print("Funciona pa");
    final Email email = Email(
      body: messageController.text,
      subject: subjectController.text,
      recipients: [emailController.text],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }
}
