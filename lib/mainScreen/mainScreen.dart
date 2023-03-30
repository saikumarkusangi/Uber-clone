import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uber_userside_clone/screens/activityScreen.dart';
import 'package:uber_userside_clone/screens/homeScreen.dart';
import 'package:uber_userside_clone/screens/profileScreen.dart';


class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> with SingleTickerProviderStateMixin{
  TabController? tabController ;
  int selectedIndex = 0;
  onItemClicked(int index){
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
     body: TabBarView(
      
      physics: NeverScrollableScrollPhysics(),
     controller: tabController,
     children: 
     [
         const homeScreen(),
        const ActivityScreen(),
         const ProfileScreen(),
         
     ],
      
      ),
      bottomSheet: BottomNavigationBar(
        
        elevation: 10,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled,size: 32,),
            label: 'Home'
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.event_note,size: 32,),
            label: 'Activity'
          ),
          
           BottomNavigationBarItem(
            icon: Icon(Icons.person,size: 32,),
            label: 'Account'
          ),
        ],
        unselectedItemColor: Color.fromARGB(137, 129, 127, 127),
        selectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 14),
      showSelectedLabels: true,
      currentIndex: selectedIndex,
      
      onTap: onItemClicked,
        ),
    );
  }
}