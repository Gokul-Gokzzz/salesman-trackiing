import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/add_note_controller.dart';
import 'package:salesman/controller/auth_conroller.dart';
import 'package:salesman/controller/note_controller.dart';
import 'package:salesman/model/add_note_model.dart';
import 'package:salesman/model/note_model.dart';
import 'package:salesman/view/app_base_screen/view/notes/note_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NoteController>(context, listen: false)
          .fetchNotesForSalesman();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController noteController = TextEditingController();
    // final addController = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Consumer<NoteController>(
        builder: (context, controller, child) {
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
                          "Notes",
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
                      const Text(
                        "Add Note",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        height: 3,
                        width: 46.02,
                        decoration: BoxDecoration(
                            color: const Color(0XFF094497),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const SizedBox(
                        height: 30.75,
                      ),
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
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Title",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 30,
                                child: TextField(
                                  controller: titleController,
                                  decoration: InputDecoration(
                                    hintText: "Title",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF094497)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF094497)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF094497)),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: 8.0,
                                    ),
                                  ),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Note",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 58,
                                child: TextField(
                                  controller: noteController,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF094497)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF094497)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF094497)),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5.0,
                                      horizontal: 8.0,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                  scrollPadding: const EdgeInsets.all(10.0),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  String title = titleController.text.trim();
                                  String note = noteController.text.trim();

                                  if (title.isEmpty || note.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Title and Note cannot be empty!')),
                                    );
                                    return;
                                  }

                                  try {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    String? salesmanId = prefs.getString('id');

                                    if (salesmanId == null ||
                                        salesmanId.isEmpty) {
                                      log("❌ Salesman ID is null or empty!");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Salesman ID not found")),
                                      );
                                      return;
                                    }

                                    log("✅ Salesman ID: $salesmanId");

                                    bool success =
                                        await Provider.of<AddNoteController>(
                                      context,
                                      listen: false,
                                    ).addNote(note, title, salesmanId);

                                    if (success) {
                                      // Refresh notes after adding
                                      Provider.of<NoteController>(context,
                                              listen: false)
                                          .fetchNotesForSalesman();
                                      titleController.clear();
                                      noteController.clear();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Note added successfully!')),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Failed to add note!')),
                                      );
                                    }
                                  } catch (e) {
                                    debugPrint("Error adding note: $e");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'An error occurred while adding the note!')),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0XFF094497),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 31,
                      ),
                      const Text(
                        "Notes List",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      controller.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : controller.notes.isEmpty
                              ? const Center(child: Text("No notes available"))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.notes.length,
                                  itemBuilder: (context, index) {
                                    GetNoteModel note = controller.notes[index];
                                    return NoteCard(note: note);
                                  },
                                ),
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

class NoteCard extends StatelessWidget {
  final GetNoteModel note;
  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<NoteController>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoteDetailsScreen(noteId: note.id)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Title:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                    color: Color(0XFF094497),
                  ),
                ),
                Text(
                  note.title ?? "No Title",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 11),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Date:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                    color: Color(0XFF094497),
                  ),
                ),
                Text(
                  "21-Dec-2024, 3:00 PM", // Update with actual date when available
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 11),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     SvgPicture.asset(
            //       'assets/images/lucide_edit.svg',
            //       height: 19,
            //       width: 19,
            //     ),
            //     const SizedBox(width: 10),
            //     InkWell(
            //       onTap: () {
            //         // provider.deleteNote(note.id.toString());
            //       },
            //       child: SvgPicture.asset(
            //         'assets/images/material-symbols_delete-outline.svg',
            //         height: 22,
            //         width: 22,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
