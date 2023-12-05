import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:scaled_size/scaled_size.dart';

class TopSongsWidget extends StatelessWidget {
  const TopSongsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130.rw,
            width: 110.rh,
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/mercy.png"),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          gapHeight(5),
          Text(
            "Mercy Chinwo",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          gapHeight(2),
          Text(
            "Excess love",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 13,
            ),
          )
        ],
      ),
    );
  }
}
