import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:romaanproject/data_model_class.dart';
import 'package:romaanproject/fibonacci_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Assignment Task | Verstrade'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<DataModelClass> fetchDateTime() async {
    final response = await http.get(Uri.parse('https://us-central1-app-verstrade.cloudfunctions.net/vtApiDevServer/api/v1/utilities/server-time'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return DataModelClass.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  late Future<DataModelClass> futureDateTime;

  @override
  void initState(){
    super.initState();
    futureDateTime = fetchDateTime();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FibonacciView()),
          );
        },
        label: const Text('Go to Fibonacci View'),
        icon: const Icon(Icons.navigation),
        backgroundColor: Colors.blue,
      ) ,
      body: FutureBuilder<DataModelClass>(
        future: futureDateTime,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Text('question not cleared\n\n'+snapshot.data!.data.timestamp.toString(),textAlign: TextAlign.center,),
                  ),
                ),

                Flexible(
                  flex: 1,
                  child: Center(
                    child: Text(DateFormat('dd MMMM yyyy, (hh:mm a)').format(snapshot.data!.data.timestamp)),
                  ),
                ),


                Flexible(
                  flex: 1,
                  child: Center(
                    // child: Text(DateFormat('dd MMMM yyyy (hh:mm a)').format((DateTime.now().subtract(Duration(milliseconds:snapshot.data!.data.ms)) ))),
                    child: Text('question not cleared\n\n'+Jiffy(snapshot.data!.data.timestamp).fromNow(),textAlign: TextAlign.center,),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      )





    );
  }
}
