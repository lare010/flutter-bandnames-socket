import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'metallicas', votes: 5),
    Band(id: '2', name: 'Queen', votes: 2),
    Band(id: '3', name: 'Heroes del silencio', votes: 3),
    Band(id: '4', name: 'Bon jovi', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print(direction);
        print('${band.id}');
      },
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Delete Band',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20.0),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (Platform.isFuchsia) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Band Name'),
            content: TextField(controller: textController),
            actions: [
              MaterialButton(
                child: Text('Add'),
                textColor: Colors.blue,
                elevation: 5,
                onPressed: () => addBandToList(textController.text),
              )
            ],
          );
        },
      );
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('New Band Name'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Add'),
                onPressed: () => addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Close'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      this.bands.add(new Band(
            id: DateTime.now().toString(),
            name: name,
            votes: 0,
          ));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
