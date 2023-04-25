// import 'package:flutter/material.dart';
//
// import '../../commanWidget/common_appbar.dart';
//
// class ImagesModel {
//   final String image;
//
//   ImagesModel({required this.image});
// }
//
// class ProfileScreen3 extends StatelessWidget {
//   ProfileScreen3({Key? key}) : super(key: key);
//   final List<ImagesModel> imagesList = [
//     ImagesModel(
//         image:
//             'https://thumbs.dreamstime.com/b/panoramic-landscap…flowers-nature-backg-park-background-91174058.jpg'),
//     ImagesModel(
//         image:
//             'https://thumbs.dreamstime.com/b/panoramic-landscap…flowers-nature-backg-park-background-91174058.jpg'),
//     ImagesModel(
//         image:
//             'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg'),
//     ImagesModel(
//         image:
//             'https://thumbs.dreamstime.com/b/beautiful-rain-for…-doi-inthanon-national-park-thailand-36703721.jpg'),
//     ImagesModel(
//         image:
//             'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg'),
//     ImagesModel(
//         image:
//             'https://thumbs.dreamstime.com/b/environment-earth-…male-hand-holding-tree-nature-field-118143566.jpg'),
//     ImagesModel(
//         image:
//             'https://thumbs.dreamstime.com/b/environment-earth-…male-hand-holding-tree-nature-field-118143566.jpg'),
//     ImagesModel(
//         image:
//             'https://thumbs.dreamstime.com/b/panoramic-landscap…flowers-nature-backg-park-background-91174058.jpg'),
//     ImagesModel(
//         image:
//             'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg'),
//   ];
//
//   final isCheck = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(15.w),
//         child: CommonAppBar(title: 'Profile'),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             Stack(
//               children: [
//                 Container(
//                     margin: const EdgeInsets.only(bottom: 30),
//                     child: Image.asset('assets/images/bgProfile.png')),
//                 Positioned(
//                   bottom: 0,
//                   left: 50,
//                   right: 70,
//                   child: CircleAvatar(
//                     radius: 40,
//                     child: Image.asset(
//                       'assets/images/profileimages.png',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const AdoroText(
//                   'Rahul Singh',
//                   color: ColorUtils.black2E,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//                 Checkbox(
//                     // shape: (),
//                     value: isCheck,
//                     onChanged: (value) {})
//               ],
//             ),
//             const AdoroText(
//               '@rahulsingh',
//               color: ColorUtils.black92,
//               fontSize: 15,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Column(
//                   children: const [
//                     AdoroText('Posts', color: ColorUtils.black92),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     AdoroText('1,286',
//                         color: ColorUtils.black2E,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18),
//                   ],
//                 ),
//                 Column(
//                   children: const [
//                     AdoroText('Followers', color: ColorUtils.black92),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     AdoroText('2m',
//                         color: ColorUtils.black2E,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18),
//                   ],
//                 ),
//                 Column(
//                   children: const [
//                     AdoroText('Following', color: ColorUtils.black92),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     AdoroText('1.1k',
//                         color: ColorUtils.black2E,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18),
//                   ],
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 InkWell(
//                   onTap: () {},
//                   child: Container(
//                       height: 40,
//                       width: 150,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: ColorUtils.white),
//                       child: const Center(
//                         child: AdoroText('Following',
//                             fontSize: 17,
//                             color: ColorUtils.black92,
//                             fontWeight: FontWeight.bold),
//                       )),
//                 ),
//                 InkWell(
//                   onTap: () {},
//                   child: Container(
//                       height: 40,
//                       width: 130,
//                       decoration: BoxDecoration(
//                           color: ColorUtils.black92,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: const Center(
//                         child: AdoroText('Message ',
//                             fontSize: 17,
//                             color: ColorUtils.white,
//                             fontWeight: FontWeight.bold),
//                       )),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const DefaultTabController(
//               length: 2,
//               child: TabBar(
//                 tabs: [
//                   Tab(
//                     child: AdoroText('All Post', color: ColorUtils.black92),
//                   ),
//                   Tab(
//                     child: AdoroText('Mentions', color: ColorUtils.blueB9),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: GridView(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3, crossAxisSpacing: 8),
//                   children: imagesList
//                       .map((e) => Column(
//                             children: [
//                               SizedBox(
//                                 height: 100,
//                                 width: 200,
//                                 child: Image.network(
//                                   e.image,
//                                   fit: BoxFit.fill,
//                                 ),
//                               )
//                             ],
//                           ))
//                       .toList(),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
