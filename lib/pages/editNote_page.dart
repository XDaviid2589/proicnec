import 'package:flutter/material.dart';
import 'package:proicnec/models/note.dart';

class EditnotePage extends StatefulWidget{
  final Note? note;
  const EditnotePage({super.key, this.note});

  @override
  State<EditnotePage> createState() => _EditnotePageState();

}

class _EditnotePageState extends State<EditnotePage> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    if(widget.note != null) {
      _titleController = TextEditingController(text: widget.note!.title);
      _contentController = TextEditingController(text: widget.note!.content);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
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
                      Icons.arrow_back_ios_new, 
                      color: Colors.white,),
                  )
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  TextField(
                    controller: _titleController,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 30)),
                  ),
                  TextField(
                    controller: _contentController,
                    style: TextStyle(color: Colors.white),
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type something here',
                      hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ],
              )
            )
        ],),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, [
            _titleController.text, _contentController.text
          ]);
        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.save),
      ),
    );
  }
}








