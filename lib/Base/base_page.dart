import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imisi/Base/Basepages/home_page.dart';
import 'package:imisi/Base/Basepages/library.dart';
import 'package:imisi/Base/Basepages/upload_page.dart';
import 'package:imisi/Database/database.dart';
import 'package:imisi/Styles/app_colors.dart';


final AudioPlayer player = AudioPlayer();

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
    HomePage(
      player: player,
    ),
    const UpLoadPage(),
    //   SearchPage(),
    const LibraryPage(),
  ];

  List<Widget> listenerPages = [
    HomePage(player: player),
    // SearchPage(),
    const LibraryPage(),
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
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  //Image.asset("assets/images/home.png"),
                  activeIcon: Icon(Icons.home_filled),
                  //Image.asset("assets/images/home_active.png"),
                  label: "Home",
                ),
                // BottomNavigationBarItem(
                //   icon: Image.asset("assets/images/search.png"),
                //   label: "Search",
                // ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/library.png"),
                  label: "Library",
                ),
              ]
            : [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  //Image.asset("assets/images/home.png"),
                  activeIcon: Icon(Icons.home_filled),
                  //Image.asset("assets/images/home_active.png"),
                  label: "Home",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.upload_outlined),
                  activeIcon: Icon(Icons.upload),
                  //  Image.asset("assets/images/upload.png"),
                  label: "Upload",
                ),
                // const BottomNavigationBarItem(
                //   icon: Icon(Icons.search),
                //   //    Image.asset("assets/images/library.png"),
                //   activeIcon: Icon(Icons.search),
                //   label: "Search",
                // ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.local_library_outlined),
                  //    Image.asset("assets/images/library.png"),
                  activeIcon: Icon(Icons.local_library),
                  label: "Library",
                ),
              ],
      ),
    );
  }
}
