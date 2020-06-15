import 'package:arab_canada_new/Services/api_service.dart';
import 'package:arab_canada_new/model/contactUs.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactUsView extends StatefulWidget {
  ContactUsView({Key key}) : super(key: key);

  @override
  _ContactUsViewState createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSubject = TextEditingController();
  TextEditingController _controllerContent = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تواصل معنا",
        ),
      ),
      backgroundColor: Color(0xffeef4f8),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: validateName,
                    controller: _controllerName,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "الإسم",
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: validateEmail,
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "البريد الإلكتروني",
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: validateSub,
                    controller: _controllerSubject,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "الموضوع",
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'يرجى كتابة نص الرسالة بشكل صحيح';
                        }
                        return null;
                      },
                      maxLines: 6,
                      controller: _controllerContent,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "نص الرسالة", //kkk
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          ContactUs c = ContactUs(
                              _controllerName.text,
                              _controllerEmail.text,
                              _controllerSubject.text,
                              _controllerContent.text);
                          ApiService()
                            ..contactUs(c).then((value) {
                              BotToast.showSimpleNotification(
                                  title: "تم إرسال الرسالة بنجاح ❤");
                              HapticFeedback.heavyImpact();
                            });
                          _controllerName.clear();
                          _controllerEmail.clear();
                          _controllerSubject.clear();
                          _controllerContent.clear();
                        }
                      },
                      child: Text('إرسال رسالة'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'يرجى كتابة بريد إلكتروني صحيح';
    else
      return null;
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'يرجى كتابة الإسم بشكل صحيح';
    else
      return null;
  }

  String validateSub(String value) {
    if (value.length < 3)
      return 'يرجى كتابة الموضوع بشكل صحيح';
    else
      return null;
  }
}
