import 'package:flutter/material.dart';

class Profile1 extends StatelessWidget {
  const Profile1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.add_card))
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.white,
            ],
          )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Text(
                          'MDY',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: const [
                          Text('Mhd Dedek Yansyah'),
                          Text('62231148'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const ListTile(
                  leading: Icon(Icons.home),
                  title: Text('PT. Wilmar Consultasy services (WCS)'),
                ),
                const ListTile(
                  leading: Icon(Icons.person),
                ),
                const ListTile(
                  leading: Icon(Icons.phone_android),
                  title: Text('1234567'),
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      const Text('Allow notifications whatsapp')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
