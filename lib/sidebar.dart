import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget{

  const Sidebar({super.key,@required this.titile});
final titile;
  @override

  State<Sidebar> createState() => _SidebarState();

}
class _SidebarState extends State<Sidebar> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 250,
              color: Colors.blue,
              padding: EdgeInsets.zero,
              child: DrawerHeader(

                decoration: const BoxDecoration(
                  color: Colors.yellow,
                ),
                child:Column(
                  children:[
                    const CircleAvatar(
                      //child: Image.network('https://www.pmindia.gov.in/wp-content/uploads/2022/12/twitter_2.jpg',height: 200,width: 200),
                      foregroundImage: NetworkImage('https://www.pmindia.gov.in/wp-content/uploads/2022/12/twitter_2.jpg',),
                      radius: 50,
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Download Gradationlist'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_document),
              title: const Text('New Apllication'),
              onTap: () {
                //
              },
            ),
            ListTile(
              leading: const Icon(Icons.approval),
              title: const Text('Application Status'),
              onTap: () {

              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      );

  }
}