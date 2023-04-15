import 'package:flutter/material.dart';
import './Widgets/new_note.dart';
import './models/Note.dart';
import './Widgets/note_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final ref = FirebaseFirestore.instance.collection('notes');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                //  button: TextStyle(color: Colors.white)
              ),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Note> _userNote = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 59.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Grocery',
    //   amount: 15.25,
    //   date: DateTime.now(),
    // ),
  ];

  // FirebaseFirestore.initializeApp();

  void _addNewNote(String noteTitle, String description) {
    final newNote = Note(
      title: noteTitle,
      description: description,
    );

    setState(() {
      _userNote.add(newNote);
    });
  }

  // void _deleteNote(String id) {
  //   setState(() {
  //     _userNote.removeWhere((note) {
  //       return note.id == id;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // final noteListWidget = Container(
    //     height: (mediaQuery.size.height -
    //             appBar.preferredSize.height -
    //             mediaQuery.padding.top) *
    //         0.7,
    //     child: NoteList(_userNote, _deleteNote));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: ref.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text('No notes'),
              );
            }

            final userNotes = snapshot.data!.docs.reversed;

            List<Note> notesCollection = [];

            for (var note in userNotes) {
             final noteTitle = note.get('title');
             final noteDescription = note.get('description');

          final noteCollection = Note(
            title: noteTitle,
            description : noteDescription,
          );
          notesCollection.add(noteCollection);
        }

            return ListView.builder(
              itemBuilder: (_, index) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: Text(
                      notesCollection[index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(6),
                      child:
                          Text('${notesCollection[index].description}'),
                    ),
                    // trailing: IconButton(
                    //   icon: Icon(Icons.delete),
                    //   color: Theme.of(context).errorColor,
                    //   onPressed: () => deletenote(note[index].id),
                    // ),
                  ),
                );
              },
              itemCount: notesCollection.length
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => NewNote()));
        },
      ),
    );
  }
}
