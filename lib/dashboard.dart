import 'package:flutter/material.dart';
import '/sidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Future<List>getstring() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    var table = prefs.getString('table');
    var employee_code = prefs.getString('username');
   var token = prefs.getString('token');
   var data=profile(table,employee_code,token);

return data;
  }
  Future <List> profile(String? table,String? employee_code, String? token ) async{
    final response = await http.post(
        Uri.parse('http://192.168.43.16/pgproject/api/read.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
    'table': '$table',
    'username': '$employee_code',
    'token': '$token',
    }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
        List data = jsonDecode(response.body.toString());
        print(data);
        return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  var titile = 'Dashboard';
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$titile'),
      ),
      body: SingleChildScrollView(
     child: Container(
        width: 400,
        height: 720,
        color: Colors.black12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Container(
              margin: EdgeInsets.only(top:10),
                color: Colors.white
                ,
              width:380 ,
              height: 700,
              child:FutureBuilder(
                  future: getstring(),
          builder: (context, snapshot){

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.connectionState == ConnectionState.done){
            var name=snapshot.data![0]['name'].toString();
            var employee_code=snapshot.data![0]['employee_code'].toString();
            var addres=snapshot.data![0]['present_place_of_posting'].toString();
            var Whatsapp_no=snapshot.data![0]['whats_no'].toString();
            var mob_no=snapshot.data![0]['mob_no'].toString();

            var image=snapshot.data![0]['image_path'].toString();
            var url='http://192.168.43.16/pgproject/$image';
            var sign=snapshot.data![0]['signature_path'];
            var surl='http://192.168.43.16/pgproject/$sign';
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      CircleAvatar(
                        //child: Image.network('https://www.pmindia.gov.in/wp-content/uploads/2022/12/twitter_2.jpg',height: 200,width: 200),
                        foregroundImage: NetworkImage(url),
                        radius: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:10.0,horizontal:0.0),
                        child: Text('Profile Photo',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,


                        ),),

                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(

                                child: Image.network('$surl',height: 50,width: 300)),
                      ],
                    ),
                    Text('Sgnature Photo'),
                  ],
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Container(

                                    child:  Text('Employee Code',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,


                                        ),),



                          ),


                  Container(

                    child: Text('Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,


                      ),),


                  ),
                  Container(

                    child: Text('Address',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,


                      ),),


                  ),
                  Container(

                    child: Text('Whatsapp no.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,


                      ),),


                  ),
                  Container(

                    child: Text('Mobile No.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,


                      ),),


                  )
                    ],
                  ),
                      Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [

                          Container(


                            child:  Text(' : $employee_code',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,


                              ),),



                          ),


                          Container(

                            child: Text(' : $name',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,


                              ),),


                          ),
                          Container(

                            child: Text(' : $addres',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,


                              ),),


                          ),
                          Container(

                            child: Text(' : $Whatsapp_no',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,


                              ),),


                          ),
                          Container(

                            child: Text(' : $mob_no',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),),


                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Text('');
          }
            )
            ),
          ],
        ),
      ),
      ),
      drawer: Sidebar(titile: titile),
    );
  }
}
