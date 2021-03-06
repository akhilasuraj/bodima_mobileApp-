import 'dart:ui';

import 'package:bodima/models/boarding.dart';
import 'package:bodima/scoped_models/main_scope.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BoardingContentPage extends StatefulWidget {
  final String boardingId;
  final MainModel _model;

  BoardingContentPage(this.boardingId, this._model);

  @override
  _BoardingContentPageState createState() => _BoardingContentPageState();
}

class _BoardingContentPageState extends State<BoardingContentPage> {
  bool _deleting = false;

  Widget _buildNewsContent() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        model.selectedBoarding =
            model.finalBoardingList.firstWhere((Boarding boarding) {
          return boarding.boardingId == widget.boardingId;
        }, orElse: () => null);

        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                top: 30.0, left: 10.0, right: 10.0, bottom: 80.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      color: Colors.black26,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      model.selectedBoarding.dateAdded,
                      style: TextStyle(color: Colors.black38, fontSize: 20.0),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 8.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: AspectRatio(
                    aspectRatio: 16 / 8,
                    child: Hero(
                      tag: '${model.selectedBoarding.boardingId}',
                      child: FadeInImage(
                        image:
                            NetworkImage('${model.selectedBoarding.imageUrl}'),
                        fit: BoxFit.cover,
                        alignment: FractionalOffset.center,
                        placeholder: AssetImage('assets/android.jpg'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Divider(
                  thickness: 2.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Address: ',
                      style: TextStyle(
                          fontSize: 22.0,
                          height: 1.3,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      model.selectedBoarding.address ?? 'Boarding Description',
                      style: TextStyle(
                          fontSize: 22.0,
                          height: 1.3,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Divider(
                  thickness: 2.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Description: ',
                      style: TextStyle(
                          fontSize: 22.0,
                          height: 1.3,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      model.selectedBoarding.description ??
                          'Boarding Description',
                      style: TextStyle(
                          fontSize: 22.0,
                          height: 1.3,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Divider(
                  thickness: 2.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFab() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.user.userType == 'owner'
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: 'delete',
                    backgroundColor: Colors.red,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Alert !'),
                            content:
                                Text('Do you realy want to delete this News ?'),
                            actions: <Widget>[
                              FlatButton(
                                  child: Text('Yes'),
                                  onPressed: () async {
                                    setState(() {
                                      _deleting = true;
                                    });
                                    model.isLoading = true;
                                    model.isEdit = false;
                                    await model.deleteBoarding(
                                        model.selectedBoarding.boardingId);

                                    Navigator.pushReplacementNamed(
                                        context, '/BoardingFeedPage');
                                  }),
                              FlatButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  FloatingActionButton(
                    heroTag: 'blackFab',
                    backgroundColor: Colors.black87,
                    onPressed: () {
                      model.isEdit = true;
                      Navigator.pushNamed(context, '/BoardingEditPage');
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : FloatingActionButton(
                heroTag: 'ownerDetails',
                backgroundColor: Colors.deepPurple,
                onPressed: () async {
                  await model.getOwnerDetails(model.selectedBoarding.ownerId);
                  Navigator.pushNamed(context, '/OwnerDetailsPage');
                },
                child: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return (widget._model.isLoading)
        ? Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : (_deleting == true)
            ? Scaffold(
                body: Container(),
              )
            : Scaffold(
                body: _buildNewsContent(),
                floatingActionButton: _buildFab(),
              );
  }

  @override
  void dispose() {
    widget._model.selectedBoarding = null;
    widget._model.isEdit = false;
    widget._model.owner = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget._model.isEdit = true;
  }
}
