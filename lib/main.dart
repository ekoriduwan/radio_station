import 'package:flutter/material.dart';
import 'package:radio_at_bus_stop/radio_station.dart';
import 'package:radio_at_bus_stop/station_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(new MaterialApp(title: "Radio at Bus Stop", home: new MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List listStation = [];

  @override
  Widget build(BuildContext context) {
    print("Length lisStation :" + listStation.length.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Radio at Bus Stop"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: listStation.length != 0
              ? _buildListStation()
              : Center(
                  child: RaisedButton(
                      onPressed: () {
                        Station.requestAPI().then((value) {
                          setState(() {
                            listStation = value;
                          });
                        });
                      },
                      child: Text("Load Radio List..")),
                ),
        ),
      ),
    );
  }

  Widget _buildListStation() {
    return ListView.builder(
        itemCount: listStation.length,
        itemBuilder: (context, pos) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RadioStationPlay(
                          name: listStation[pos]['name'],
                          favicon: listStation[pos]['favicon'],
                          url: listStation[pos]['url_resolved'],
                        )),
              );
            },
            child: Card(
              elevation: 3,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    imageUrl: listStation[pos]['favicon'],
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(
                      Icons.error,
                      size: 50,
                    ),
                  ),
                ),
                title: Text(listStation[pos]['name'],
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(listStation[pos]['country']),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          );
        });
  }
}
