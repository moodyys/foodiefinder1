
import 'package:flutter/material.dart';

class Userhomepage extends StatelessWidget {
  const Userhomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Foodie Finder',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'username',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'time posted',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.keyboard_control_rounded,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  print('Options pressed');
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            '(post written)',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.thumb_up_alt_outlined,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  print('Like button pressed');
                                },
                              ),
                              SizedBox(width: 4),
                              Text(
                                '3 likes',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'My Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurants',
          ),
        ],
        onTap: (index) {
          // if (index == 0) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => const Userhomepage()),
          //   );
          // } else if (index == 1) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => const MyAccount()),
          //   );
          // } else if (index == 2) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => const Restaurants()),
          //   );
          // }
        },
      ),
    );
  }
}