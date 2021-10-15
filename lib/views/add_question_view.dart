import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:questions_reponses/model/question.dart';
import 'package:questions_reponses/provider/image_provider.dart';
import 'package:questions_reponses/provider/questions_firebase_provider.dart';
import 'package:questions_reponses/repositories/questions_repositories.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  File? image;
  bool _isSwitchOn = false;
  final QuestionsFirebaseProvider _questionsFirebaseProvider =
      new QuestionsFirebaseProvider();
  final ImageFirebaseProvider _imageFirebaseProvider =
      new ImageFirebaseProvider();
  @override
  Widget build(BuildContext context) {
    var _themeController = new TextEditingController();
    var _questionController = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Ajout d'une question"),
      ),
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Builder(
            builder: (BuildContext ctxScaffold) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text("Ajouter une thématique et une question"),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: _themeController,
                      decoration: InputDecoration(
                          fillColor: Color.fromRGBO(255, 255, 255, 1),
                          hintText: "Ajouter un thème"),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text("Ajouter une question"),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: _questionController,
                      decoration: InputDecoration(
                          fillColor: Color.fromRGBO(255, 255, 255, 1),
                          hintText: "Ajouter une question"),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  if (image != null)
                    Image.file(
                      image!,
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  if (image != null)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                  (image != null)
                      ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              image = null;
                            });
                          },
                          child: Text("Enlever l'image"))
                      : ElevatedButton(
                          onPressed: () {
                            _showPicker(context);
                          },
                          child: Text("Ajouter une image")),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("La réponse à votre question"),
                        Switch(value: _isSwitchOn, onChanged: _updateAnswer)
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print(_questionController.text);
                        if (_questionController.text != "" && image != null) {
                          print("Je suis ici 3");
                          _imageFirebaseProvider
                              .uploadImage(image!)
                              .then((value) {
                            print("Je suis ici 2");
                            _questionsFirebaseProvider
                                .addQuestion(new Question(
                                    _questionController.text,
                                    "/" + basename(image!.path),
                                    _isSwitchOn))
                                .then((value) => print("Je suis ici"));
                          });
                        } else {
                          Scaffold.of(ctxScaffold).showSnackBar(SnackBar(
                            content: Text("Veuillez remplir tout les liens"),
                            duration: Duration(milliseconds: 500),
                          ));
                        }
                      },
                      child: Text("Ajouter la question")),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _imgFromGallery() async {
    // ignore: deprecated_member_use
    File imageFromGallery = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      image = imageFromGallery;
    });
  }

  _imgFromCamera() async {
    // ignore: deprecated_member_use
    File imageFromCamera = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      image = imageFromCamera;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _updateAnswer(bool value) {
    setState(() {
      _isSwitchOn = value;
      print("Switch ->" + _isSwitchOn.toString());
    });
  }
}
