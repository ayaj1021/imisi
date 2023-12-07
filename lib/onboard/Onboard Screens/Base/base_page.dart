import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imisi/Database/database.dart';
import 'package:imisi/Styles/app_colors.dart';
import 'package:imisi/onboard/Onboard%20Screens/Base/Basepages/home_page.dart';
import 'package:imisi/onboard/Onboard%20Screens/Base/Basepages/upload_pages.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int selectedIndex = 0;

  void changeFocus(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> artistPages = [
    const HomePage(),
    Container(color: Colors.black),
    const UpLoadPage(),
    Container(color: Colors.amber),
  ];

  List<Widget> listenerPages = [
    const HomePage(),
    Container(color: Colors.black),
    Container(color: Colors.amber),
  ];

  SharedPref pref = SharedPref();

  @override
  void initState() {
    getUserType();
    super.initState();
  }

  bool isArtist = true;

  getUserType() {
    pref.getUserAccountType().then((value) {
      if (value == "Listener") {
        setState(() {
          isArtist = false;
        });
      } else {
        setState(() {
          isArtist = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: isArtist == true
          ? artistPages[selectedIndex]
          : listenerPages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        backgroundColor: AppColors.secondaryColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedLabelStyle: GoogleFonts.inter(color: AppColors.primaryColor),
        onTap: changeFocus,
        unselectedItemColor: Colors.grey,
        items: isArtist == false
            ? [
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/home.png"),
                  activeIcon: Image.asset("assets/images/home_active.png"),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/search.png"),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/library.png"),
                  label: "Library",
                ),
              ]
            : [
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/home.png"),
                  activeIcon: Image.asset("assets/images/home_active.png"),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/search.png"),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/upload.png"),
                  label: "Upload",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/library.png"),
                  label: "Library",
                ),
              ],
      ),
    );
  }
}
