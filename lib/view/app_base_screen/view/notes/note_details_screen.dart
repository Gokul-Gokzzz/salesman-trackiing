// ui/note_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/model/note_detail_model.dart';
import 'package:salesman/controller/note_controller.dart'; // Import NoteController for refresh

class NoteDetailsScreen extends StatefulWidget {
  final String noteId;

  const NoteDetailsScreen({super.key, required this.noteId});

  @override
  _NoteDetailsScreenState createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  bool isEditing = false;
  late TextEditingController _titleController;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NoteController>(context, listen: false)
          .fetchSingleNote(widget.noteId);
    });
    _titleController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Consumer<NoteController>(
        builder: (context, controller, child) {
          if (controller.isLoading && !isEditing) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.singleNote == null) {
            return const Center(child: Text("Note not found"));
          }

          SingleNoteModel note = controller.singleNote!;

          if (!isEditing) {
            _titleController.text = note.title ?? "";
            _noteController.text = note.note ?? "";
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 318,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        image: DecorationImage(
                          image: AssetImage("assets/images/notes.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Note Details",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 35,
                      left: 15,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset("assets/images/backbutton.svg"),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30.75),
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: const Color(0XFFFFFFFF),
                            borderRadius: BorderRadius.circular(7)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                "Title",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 10),
                              isEditing
                                  ? TextField(controller: _titleController)
                                  : Text(
                                      note.title ?? "No Title",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                              const SizedBox(height: 20),
                              const Text(
                                "Note",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 10),
                              isEditing
                                  ? TextField(
                                      controller: _noteController,
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                    )
                                  : Text(
                                      note.note ?? "No Note",
                                      style: const TextStyle(fontSize: 15),
                                    ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (!isEditing)
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isEditing = true;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        'assets/images/lucide_edit.svg',
                                        height: 22,
                                        width: 22,
                                      ),
                                    ),
                                  if (!isEditing) const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Confirm Delete"),
                                            content: const Text(
                                                "Are you sure you want to delete this note?"),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text("Delete"),
                                                onPressed: () async {
                                                  bool success =
                                                      await controller
                                                          .deleteNote(note.id!);
                                                  if (success) {
                                                    Provider.of<NoteController>(
                                                            context,
                                                            listen: false)
                                                        .fetchNotesForSalesman();
                                                    Navigator.of(context)
                                                        .pop(); // Close dialog
                                                    Navigator.of(context)
                                                        .pop(); // Go back
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    "Note Deleted")));
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    "Note Deletion Failed")));
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/material-symbols_delete-outline.svg',
                                      height: 22,
                                      width: 22,
                                      color: Colors.red,
                                    ),
                                  ),
                                  if (isEditing)
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            bool success =
                                                await controller.updateNote(
                                              note.id!,
                                              _titleController.text,
                                              _noteController.text,
                                            );
                                            if (success) {
                                              setState(() {
                                                isEditing = false;
                                              });
                                              Provider.of<NoteController>(
                                                      context,
                                                      listen: false)
                                                  .fetchNotesForSalesman();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Note Updated")));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Note Update Failed")));
                                            }
                                          },
                                          child: const Text("Save"),
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              isEditing = false;
                                            });
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 31),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
