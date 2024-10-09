import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager/ui/screens/views/canceled_screen.dart';
import 'package:task_manager/ui/screens/views/completed_screen.dart';
import 'package:task_manager/ui/screens/views/new_task.dart';
import 'package:task_manager/ui/screens/views/progress_screen.dart';

import '../../utility/app_colors.dart';
import '../../utility/text_style.dart';
import '../../widgets/profile_appbar.dart';


class CustomNavbar extends StatefulWidget {
  const CustomNavbar({super.key});

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  List<Widget> screen=[
NewTaskScreen(),
    CompletedScreen(),
    ProgressScreen(),
    CanceledScreen(),


  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(context),
      body: screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.themeColor,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          unselectedItemColor: Colors.black.withOpacity(0.6),
          showUnselectedLabels: true,
          // showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                activeIcon: Icon(FontAwesomeIcons.listCheck),
                icon: Icon(FontAwesomeIcons.listCheck), label: "New Task"),
            BottomNavigationBarItem(
                activeIcon: Icon(FontAwesomeIcons.clipboardCheck),
                icon: Icon(FontAwesomeIcons.clipboardList),
                label: "Completed"),
            BottomNavigationBarItem(
                activeIcon: Icon(FontAwesomeIcons.barsProgress),
                icon: Icon(FontAwesomeIcons.barsProgress), label: "In Progress"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.free_cancellation),
                icon: Icon(Icons.free_cancellation_rounded), label: "Canceled"),

          ]),
    );
  }

}