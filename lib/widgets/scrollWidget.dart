// // ignore_for_file: file_names
// import 'package:flutter/material.dart';

// class BannerWidgetAreaTwo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//     PageController controller =
//         PageController(viewportFraction: 0.6, initialPage: 1);

//     List<Widget> banners = new List<Widget>();
//     for (int i = 0; i < bannerTwoItems.length; i++) {
//       var twoBannerView = InkWell(
//         onTap: () {
//           Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => Spisok(values: bannerTwoItemsss[i])));
//         },
//         child: Container(
//           child: Container(
//             color: Colors.white10,
//             width: 150,
//             child: Column(
//               children: [
//                 Image.asset(
//                   bannerTwoImage[i],
//                   width: 120,
//                   height: 120,
//                 ),
//                 Center(
//                   child: Text(
//                     bannerTwoItems[i],
//                     style: TextStyle(fontSize: 30),
//                   ),
//                 ),
//                 Center(
//                   child: Text(
//                     bannerTwoText[i],
//                     style: TextStyle(fontSize: 15),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );

//       banners.add(twoBannerView);
//     }

//     return Padding(
//         padding: EdgeInsets.only(top: 30),
//         child: Container(
//           width: screenWidth,
//           height: screenHeight / 3.2,
//           child: PageView(
//             controller: controller,
//             scrollDirection: Axis.horizontal,
//             children: banners,
//           ),
//         ));
//   }
// }
