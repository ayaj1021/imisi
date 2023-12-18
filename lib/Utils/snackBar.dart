// import 'package:flutter/material.dart';
// import 'package:imisi/Styles/app_colors.dart';

// import 'package:scaled_size/scaled_size.dart';

// showSnackBar({
//   BuildContext? context,
//   required String message,
//   bool? isError,
// }) {
//    ScaffoldMessenger.of(context!).showSnackBar(
//     SnackBar(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(100),
//       ),
//       backgroundColor:
//           isError! ? const Color(0xffFFECEC) : const Color(0xffECFCFF),
//       behavior: SnackBarBehavior.floating,
//       content: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           isError == true
//               ? const CircleAvatar(
//                   backgroundColor: Colors.red,
//                   radius: 15,
//                   child: Icon(
//                     Icons.close,
//                     color: Colors.white,
//                   ),
//                 )
//               : const CircleAvatar(
//                   backgroundColor: AppColors.primaryColor,
//                   radius: 15,
//                   child: Icon(
//                     Icons.check,
//                     color: Colors.white,
//                   ),
//                 ),
//           SizedBox(width: 10.rw),
//           Text(
//             message,
//             style: const TextStyle(
//               color: Color(0xff03172B),
//               fontFamily: "Poppins",
//               fontWeight: FontWeight.w400,
//               fontSize: 13,
//             ),
//           ),
//         ],
//       ),
//       margin: const EdgeInsets.only(left: 10, bottom: 20, right: 20),
//     ),
//   );
// }

// showSnackBar({
//   required BuildContext context,
//   required String message,
//   bool? isError,
// }) {
//   return ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(100),
//       ),
//       backgroundColor:
//           isError! ? const Color(0xffFFECEC) : const Color(0xffECFCFF),
//       behavior: SnackBarBehavior.floating,
//       content: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           isError == true
//               ? const CircleAvatar(
//                   backgroundColor: Colors.red,
//                   radius: 15,
//                   child: Icon(
//                     Icons.close,
//                     color: Colors.white,
//                   ),
//                 )
//               : const CircleAvatar(
//                   backgroundColor: AppColors.primaryColor,
//                   radius: 15,
//                   child: Icon(
//                     Icons.check,
//                     color: Colors.white,
//                   ),
//                 ),
//           SizedBox(width: 10.rw),
//           Text(
//             message,
//             style: const TextStyle(
//               color: Color(0xff03172B),
//               fontFamily: "Poppins",
//               fontWeight: FontWeight.w400,
//               fontSize: 13,
//             ),
//           ),
//         ],
//       ),
//       margin: const EdgeInsets.only(left: 10, bottom: 20, right: 20),
//     ),
//   );
// }

