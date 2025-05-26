// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutterapp/Common/constants.dart';
// import 'package:flutterapp/Providers/product_provider.dart';
// import 'package:flutterapp/Cart/Provider/cart_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:responsive_grid/responsive_grid.dart';
// import '../Widgets/elev_button.dart';
// import '../Widgets/product_container.dart';
// import 'cart_screen.dart';
//
// class UserHomeScreen extends StatefulWidget {
//   const UserHomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<UserHomeScreen> createState() => _UserHomeScreenState();
// }
//
// class _UserHomeScreenState extends State<UserHomeScreen> {
//   List<String> sortBy = ['Price Ascending', 'Price Descending', 'none'];
//   SortTypes? sortType;
//   String? sortValue;
//   String? searchValue;
//   int pagesNum = 0;
//   int nextPage = 1;
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () async {
//       await Provider.of<ProductProvider>(context, listen: false)
//           .getProducts(0, null, null, GetTypes.PAGING);
//       pagesNum = Provider.of<ProductProvider>(context, listen: false).pagesNumber;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 4,
//         backgroundColor: Colors.transparent,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         title: const Text(
//           'Online Store',
//           style: TextStyle(
//             fontWeight: FontWeight.w700,
//             fontSize: 26,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.shopping_cart, color: Colors.white),
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.logout, color: Colors.white),
//             onPressed: FirebaseAuth.instance.signOut,
//           ),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   width: 180,
//                   child: TextField(
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//                       hintText: 'Search by name...',
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                       prefixIcon: const Icon(Icons.search),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                     onChanged: (input) {
//                       searchValue = input;
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 SizedBox(
//                   width: 200,
//                   child: DropdownButtonFormField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 12),
//                     ),
//                     hint: const Text("Sort By"),
//                     value: sortValue,
//                     items: sortBy.map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       sortValue = value as String?;
//                       if (value == sortBy[0]) {
//                         sortType = SortTypes.ASC;
//                       } else if (value == sortBy[1]) {
//                         sortType = SortTypes.DESC;
//                       } else {
//                         sortType = null;
//                       }
//                       setState(() {});
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 ElevButton(
//                   text: "Filter",
//                   icon: Icons.filter_list,
//                   color: Colors.blueAccent,
//                   textColor: Colors.white,
//                   onPressed: () async {
//                     await Provider.of<ProductProvider>(context, listen: false)
//                         .getProducts(0, searchValue, sortType, GetTypes.FILTER);
//                     pagesNum = Provider.of<ProductProvider>(context, listen: false).pagesNumber;
//                     nextPage = 1;
//                     setState(() {});
//                   },
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),
//           Expanded(
//             child: ResponsiveGridList(
//               desiredItemWidth: 200,
//               minSpacing: 20,
//               children: Provider.of<ProductProvider>(context)
//                   .products
//                   .map<Widget>((product) {
//                 return ProductContainer(
//                   product: product,
//                   showAddToCart: true,
//                 );
//               }).toList()
//                 ..add(
//                   pagesNum > 1
//                       ? Column(
//                     children: [
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         height: 60,
//                         child: ElevButton(
//                           text: 'Load More',
//                           icon: Icons.add,
//                           color: Colors.grey,
//                           onPressed: () {
//                             Provider.of<ProductProvider>(context, listen: false)
//                                 .getProducts(nextPage, searchValue, sortType, GetTypes.PAGING);
//                             pagesNum--;
//                             nextPage++;
//                             setState(() {});
//                           },
//                         ),
//                       ),
//                     ],
//                   )
//                       : const SizedBox(),
//                 ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
