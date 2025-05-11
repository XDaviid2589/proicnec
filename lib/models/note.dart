import 'package:flutter/material.dart';

class Note {
  int id;
  String title;
  String content;
  DateTime modifiedTime;
  Color color;

  Note ({
    required this.id,
    required this.title,
    required this.content,
    required this.modifiedTime,
    required this.color,
  });
}


List<Note> sampleNotes = [

  Note (
    id: 0,
    title: "1",
    content: "Hola1",
    modifiedTime: DateTime(2022,1,1,34,5),
    color: Colors.amber,
  ),
  Note (
    id: 1,
    title: "2",
    content: "Hola2",
    modifiedTime: DateTime(2018,1,1,34,5),
    color: Colors.red,
  ),
  // Note (
  //   id: 2,
  //   title: "3",
  //   content: "Hola3",
  //   modifiedTime: DateTime(2015,1,1,34,5),
  //   color: Colors.green,
  // ),
  //  Note (
  //   id: 3,
  //   title: "4",
  //   content: "Hola4",
  //   modifiedTime: DateTime(2026,1,1,34,5),
  //   color: Colors.blue,
  // ),
  // Note (
  //   id: 4,
  //   title: "5",
  //   content: "Hola5",
  //   modifiedTime: DateTime(2008,1,1,34,5),
  //   color: Colors.pinkAccent,
  // ),
  // Note (
  //   id: 5,
  //   title: "6",
  //   content: "Hola6",
  //   modifiedTime: DateTime(1999,1,1,34,5),
  //   color: Colors.yellow,
  // ),
  //  Note (
  //   id: 6,
  //   title: "7",
  //   content: "Hola7",
  //   modifiedTime: DateTime(1987,1,1,34,5),
  //   color: Colors.lightBlue,
  // ),
  // Note (
  //   id: 7,
  //   title: "8",
  //   content: "Hola8",
  //   modifiedTime: DateTime(2020,1,1,34,5),
  //   color: Colors.lightGreen,
  // ),
  // Note (
  //   id: 8,
  //   title: "9",
  //   content: "Hola9",
  //   modifiedTime: DateTime(2004,1,1,34,5),
  //   color: Colors.deepPurpleAccent,
  // ),
  
];