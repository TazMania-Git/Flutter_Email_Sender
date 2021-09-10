import 'package:flutter/material.dart';

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
        body: ListView(
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
    );
  }

  Widget _createSubjectInput() {
    return TextField(
      // autofocus: true,
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
    return TextField(
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
      onPressed: () {},
      child: Text('Submit', style: TextStyle(fontSize: 20),),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(50, 50),
        primary: Colors.blue,
        shape: StadiumBorder(),
      ),
    );
  }
}
