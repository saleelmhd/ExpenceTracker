import 'package:expensenote/view/Home/More.dart';
import 'package:flutter/material.dart';
import '../Home/home_page.dart';

class BasicBottomNavBar extends StatefulWidget {
  BasicBottomNavBar({super.key, required this.uid});
  String uid;

  @override
  _BasicBottomNavBarState createState() => _BasicBottomNavBarState();
}

class _BasicBottomNavBarState extends State<BasicBottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(uid: ""), // Initialize with an empty string, update it later
     More(uid: '',)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late List<Widget> _updatedPages;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("${widget.uid}00000000000");
    _updatedPages = [
      HomePage(uid: widget.uid),
      More(
        uid: widget.uid,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: _updatedPages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey.shade600,
        selectedItemColor: Colors.indigo,
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        selectedLabelStyle: const TextStyle(fontSize: 10),
        iconSize: 20,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: 'HOME',
          ),
    
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Container(
                    height: 20,
                    width: 30,
                    decoration: BoxDecoration(
                        border: Border.all(), color: Colors.indigo),
                    child: const Center(
                        child: Icon(
                      Icons.more_horiz_outlined,
                      color: Colors.white,
                    )))
                : Container(
                    height: 20,
                    width: 30,
                    decoration: BoxDecoration(border: Border.all()),
                    child: const Center(
                        child: Icon(
                      Icons.more_horiz_outlined,
                    ))),
            label: 'MORE',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.chat),
          //   label: 'Chats',
          // ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
   Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

}
