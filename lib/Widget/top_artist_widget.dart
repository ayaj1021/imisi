import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imisi/Utils/gap.dart';
import 'package:scaled_size/scaled_size.dart';

class TopArtisteWidget extends StatelessWidget {
  const TopArtisteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 110.rh,
          width: 250.rw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: AssetImage("assets/images/joe.png"),
            ),
          ),
        ),
        gapHeight(5),
        Text(
          "Joe fred",
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
