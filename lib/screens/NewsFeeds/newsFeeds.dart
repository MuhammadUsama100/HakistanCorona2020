import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronavirus/Utils/localStorage.dart';
import 'package:coronavirus/constants/constantcolor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewesFeeds extends StatefulWidget {
  NewesFeeds({Key key}) : super(key: key);

  @override
  _NewesFeedsState createState() => _NewesFeedsState();
}

class _NewesFeedsState extends State<NewesFeeds> {
  var data;
  final Firestore _db = Firestore();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData().then((val) {
      setState(() {});
    });
  }

  fetchData() async {
    print("usama");
    DocumentReference ref =
        _db.collection("user").document(Storage.getValue("UserID"));

    this.data = await ref.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NewesFeeds"),
          backgroundColor: theamColor,
        ),
        body: this.data == null
            ? Center(child: Container(child: CircularProgressIndicator()))
            : Container(
                child: ListView.builder(
                    itemCount: this.data.NewesFeedss.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 200,
                          child: Card(
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Text(
                                          this.data.NewesFeedss[index].title,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Container(
                                    child: Image.network(
                                        this.data.NewesFeedss[index].thumbnail),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(this
                                        .data
                                        .NewesFeedss[index]
                                        .description),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () async {
                                        var url = this
                                            .data
                                            .NewesFeedss[index]
                                            .applink
                                            .toString();
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: Text(
                                          this.data.NewesFeedss[index].applink,
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          )),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      );
                    })));
  }
}
