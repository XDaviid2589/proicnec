import 'dart:math' as math;
import 'package:proicnec/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:proicnec/constants/colors.dart';
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
  Color? selectedColor;


  @override
  void initState() {
    // TODO: implement initState
    if(widget.note != null) {
      _titleController = TextEditingController(text: widget.note!.title);
      _contentController = TextEditingController(text: widget.note!.content);
      selectedColor = widget.note!.color;
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
              // Botón de volver atrás
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: EdgeInsets.all(0),
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
              ),

              // Botón de elegir color
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.grey.shade900,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: backgroundColors.map((color) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColor = color;
                                });
                                Navigator.pop(context); // cerrar el panel
                              },
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: color,
                                child: selectedColor == color
                                    ? const Icon(Icons.check, color: Colors.white)
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  );
                },
                padding: EdgeInsets.all(0),
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: selectedColor ?? Colors.grey.shade800,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.palette,
                    color: ColorUtils.getContrastingColor(selectedColor ?? Colors.grey.shade800),
                  ),
                ),
              ),
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
        final title = _titleController.text.trim();
        final content = _contentController.text;
        final color = selectedColor ?? (backgroundColors.isNotEmpty
            ? backgroundColors[math.Random().nextInt(backgroundColors.length)]
            : Colors.grey);

        // Validación: título no puede estar vacío
        if (title.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('El título no puede estar vacío'),
              backgroundColor: Colors.redAccent,
            ),
          );
          return;
        }

        // Validación: no puede haber otro título igual (excepto si está editando y es el mismo)
        bool titleExists = sampleNotes.any((note) =>
          note.title.trim() == title &&
          (widget.note == null || note.id != widget.note!.id) // evitar compararse consigo misma
        );

        if (titleExists) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Ya existe una nota con ese título'),
              backgroundColor: Colors.orange,
            ),
          );
          return;
        }

        // Todo válido, devolver datos
        Navigator.pop(context, [title, content, color]);
      },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.save),
      ),
    );
  }
}








