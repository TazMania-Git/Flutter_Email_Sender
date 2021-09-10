import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  bool _enableBtn = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Email Sender',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Email Sender'),
        ),
        body: Form(
          key: _formKey,
          onChanged: () {
            setState() {
              _enableBtn = _formKey.currentState!.validate();
            }
          },
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
        ),
      ),
    );
  }

  Widget _createSubjectInput() {
    return TextField(
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
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email is required';
        } else if (!value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
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
    return TextField(
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
      onPressed: _enableBtn
          ? (() async {
              final Email email = Email(
                body: messageController.text,
                subject: subjectController.text,
                recipients: [emailController.text],
                isHTML: false,
              );

              await FlutterEmailSender.send(email);
            })
          : null,
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
}
