import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proicnec/constants/colors.dart';
import 'package:proicnec/models/note.dart';
import 'package:proicnec/pages/editNote_page.dart';
import 'package:proicnec/utils/color_utils.dart';
import 'package:proicnec/utils/theme_controller.dart';

class NotePage extends StatefulWidget{
final ThemeController themeController;
const NotePage({required this.themeController, super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

  TextEditingController _searchController = TextEditingController();

  List<Note> filteredNotes = [];
  bool sorted = false;

  @override
  void initState() {
    super.initState();
      filteredNotes = sampleNotes;
  }

  List<Note> sortNotesByModifiedTime(List<Note> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    }
    else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }

    sorted = !sorted;

    return notes;
  }

  getRandomColor() {
    Random random = Random();
    return allBackgroundColors[random.nextInt((allBackgroundColors.length))];
  }

  void onSearchTextChanged(String searchText) {
    setState(() {
    if (searchText.isEmpty) {
      filteredNotes = sampleNotes;
      return;
    }
    String query = searchText.trim().toLowerCase();

    filteredNotes = sampleNotes.where((note) {
      String title = note.title.toLowerCase();
      return title.contains(query);
    }).toList();
  });
  }

  void deleteNote(Note note) {
    setState(() {
        sampleNotes.remove(note);
    filteredNotes.remove(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notes", 
                style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                IconButton(
                  onPressed: (){
                    setState(() {
                      filteredNotes = sortNotesByModifiedTime(filteredNotes);
                    });
                  },
                  padding: EdgeInsets.all(0),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800.withValues(), // color: Colors.grey.shade800.withOpacity(8), 
                      borderRadius: BorderRadius.circular(10),
                      ), 

                    child: Icon(
                      Icons.sort, 
                      color: Colors.white,),
                  )
                )
              ],
            ),

            SizedBox(height: 20,),

            TextField(
              controller: _searchController,
              onChanged: onSearchTextChanged,
              style: TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                hintText: "Search notes...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                fillColor: Colors.grey.shade800,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent)),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 30),
                itemCount: filteredNotes.length,
                itemBuilder:(context, index) {
                  final currentTheme = MediaQuery.of(context).platformBrightness;
                  final originalColor = filteredNotes[index].color;
                  final effectiveColor = currentTheme == Brightness.dark
                      ? (ColorUtils.isColorDark(originalColor)
                          ? ColorUtils.getRandomColorForTheme(allBackgroundColors, Brightness.dark)
                          : originalColor)
                      : (!ColorUtils.isColorDark(originalColor)
                          ? ColorUtils.getRandomColorForTheme(allBackgroundColors, Brightness.light)
                          : originalColor);
                  return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    color: effectiveColor,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => EditnotePage(note: filteredNotes[index]),
                            ), 
                          );
                          if (result != null) {
                            setState(() {
                              int originalIndex = sampleNotes.indexOf(filteredNotes[index]);

                              sampleNotes[originalIndex] = Note(
                                id: sampleNotes[originalIndex].id,
                                title: result[0],
                                content: result[1],
                                modifiedTime: DateTime.now(),
                                color: result[2],
                              );

                              filteredNotes[index] = Note(
                                id: filteredNotes[index].id,
                                title: result[0],
                                content: result[1],
                                modifiedTime: DateTime.now(),
                                color: result[2],
                              );
                            });
                          }
                        },
                        title: RichText(
                          maxLines: 3, // mostrar las primeras 3 lineas
                          overflow: TextOverflow.ellipsis, // mostrar 3 puntos cuando llega al maximo de pantalla 
                          text: TextSpan(
                            text: "${filteredNotes[index].title} :\n",
                            style: TextStyle(
                              color: ColorUtils.getContrastingColor(effectiveColor),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 1.5),
                              children: [
                                TextSpan(
                                  text: filteredNotes[index].content,
                                  style: TextStyle(
                                    color: ColorUtils.getContrastingColor(effectiveColor),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    height: 1.5),
                                )
                              ]
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Edited: ${DateFormat('EEE MMM d, yyyy h:mm a').format(filteredNotes[index].modifiedTime)}",
                            style: TextStyle(
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                              color: ColorUtils.getContrastingColor(effectiveColor),),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () async{
                            final result = await confirmDialog(context);
                              if (result!= null && result) {
                                deleteNote(filteredNotes[index]); 
                              }
                          },
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),
                      ),
                    ),
                  );
                },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const EditnotePage(),
            ), 
          );

          _searchController.clear();

          if (result != null) {
            setState(() {
              sampleNotes.add(Note(
                id: sampleNotes.length,
                title: result[0],
                content: result[1],
                modifiedTime: DateTime.now(),
                color: result[2],
              ));
              filteredNotes = sampleNotes;
              _searchController.clear(); 
            });
          } else {
            setState(() {
              filteredNotes = sampleNotes; 
            });
          }

        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(
          Icons.add,
          size: 38,
        )
      ),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context) {
    return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey.shade900,
        icon: const Icon(
          Icons.info,
          color: Colors.grey,
        ),
        title: const Text(
          "Are you sure you want to delete",
          style: TextStyle(color: Colors.white),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green),
              child: const SizedBox(
                width: 60,
                child: Text(
                  "Yes",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red),
              child: const SizedBox(
                width: 60,
                child: Text(
                  "No",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
          )
        ],),

      );
    });
  }
}


