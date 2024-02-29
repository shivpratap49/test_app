import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/splashpage.dart';
import '/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gradation System',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Splashpage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // This widget is the home page of your application. It is stateful, meaning
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var username = TextEditingController();
  var password = TextEditingController();
  var dropdownValue = "";
  prfesns(String table, String username, String token )async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('table', table );
    prefs.setString('username', username );
    prefs.setString('token', token);
  }
  rom(String dropdownValue, String username, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.43.16/pgproject/api/login.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'table': '$dropdownValue',
        'username': '$username',
        'password': '$password',
      }),
    );
    print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Map data = jsonDecode(response.body.toString());
      if (data['Status'] == true) {
          prfesns(data['table'],data['username'],data['token']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
        );

      } else
        {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Credential')),
          );
        }
      return data;
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("can't reach")),
      );
    }
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 80),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Image.asset("assets/images/cuutak.jpg"),
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                              margin: const EdgeInsets.all(15.0),
                              child: //DropdownButtonExample(),
                                  DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Select Category';
                                      }
                                      return null;
                                    },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  labelText: 'Employee Catogry',
                                ),
                                items: const [
                                  DropdownMenuItem(
                                      value: 'driver',
                                      child: Text('Driver')),
                                  DropdownMenuItem(
                                      value: 'ministry',
                                      child: Text('Ministry')),
                                  DropdownMenuItem(
                                      value: 'revenue',
                                      child: Text('Revenue')),
                                ],
                                onChanged: (String? val) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValue = val!;
                                    print('$dropdownValue');
                                  });
                                },
                              ))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextFormField(
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter some text';
    }
    return null;
    },
                            controller: username,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.people),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Username',
                              hintText: 'Enter Your Employee Code',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          margin: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );
                            }
                            var _username = username.text;
                            var _pass = password.text;
                            print('$_username + $_pass +$dropdownValue');
                            var login =
                                rom('$dropdownValue', '$_username', '$_pass');
                            print('$login' +'kjkd');

                          },
                          child: const Text('Login')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = 'emp';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        labelText: 'Employee Catogry',
      ),
      items: [
        DropdownMenuItem(child: Text('Driver'), value: 'driver'),
        DropdownMenuItem(child: Text('Ministry'), value: 'ministry'),
        DropdownMenuItem(child: Text('Revenue'), value: 'revenue'),
      ],

      onChanged: (String? val) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = val!;
          print('$dropdownValue');

        });
        },
    );*/
/*DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
     }
}*/

Future<Album> fetchAlbum() async {
  final response = await http.get(Uri.parse('http://10.42.0.1/pgproject/api/'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String gender;
  final String name;
  final String proability;

  const Album({
    required this.gender,
    required this.name,
    required this.proability,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      gender: json['gender'],
      name: json['name'],
      proability: json['proability'],
    );
  }
}
