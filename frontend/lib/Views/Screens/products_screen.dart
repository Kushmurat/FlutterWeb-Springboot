import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Common/constants.dart';
import 'package:flutterapp/Providers/product_provider.dart';
import 'package:flutterapp/Views/Widgets/add_product_drawer.dart';
import 'package:flutterapp/Views/Widgets/elev_button.dart';
import 'package:flutterapp/Views/Widgets/product_container.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> sortBy = ['Price Ascending', 'Price Descending', 'none'];
  SortTypes? sortType;
  String? sortValue;
  String? searchValue;
  int pagesNum = 0;
  int nextPage = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<ProductProvider>(context, listen: false)
          .getProducts(0, null, null, GetTypes.PAGING);
      pagesNum =
          Provider.of<ProductProvider>(context, listen: false).pagesNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A148C), Color(0xFF880E4F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Amazon',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: FirebaseAuth.instance.signOut,
            child: const Text('Sign Out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      endDrawer: const AddProductDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Products 💰',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                ElevButton(
                  text: 'Add Product',
                  textColor: Colors.black54,
                  color: Colors.white,
                  icon: Icons.add,
                  onPressed: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .productToEdit = null;
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 180,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          hintText: 'Search by name...',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (input) {
                          searchValue = input;
                          print('🔍 Input updated: $searchValue');
                        },

                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 200,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        hint: const Text("Sort By"),
                        value: sortValue,
                        items: sortBy.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          sortValue = value as String?;
                          if (value == sortBy[0]) {
                            sortType = SortTypes.ASC;
                          } else if (value == sortBy[1]) {
                            sortType = SortTypes.DESC;
                          } else {
                            sortType = null;
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevButton(
                      text: "Filter",
                      icon: Icons.filter_list,
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      onPressed: () async {
                        await Provider.of<ProductProvider>(context, listen: false)
                            .getProducts(0, searchValue, sortType, GetTypes.FILTER);
                        pagesNum =
                            Provider.of<ProductProvider>(context, listen: false).pagesNumber;
                        nextPage = 1;
                        setState(() {});
                      },
                    )

                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ResponsiveGridList(
              desiredItemWidth: 200,
              minSpacing: 20,
              children: Provider.of<ProductProvider>(context)
                  .products
                  .map<Widget>((product) {
                return GestureDetector(
                  onTap: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .productToEdit = product;
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                  child: ProductContainer(product: product),
                );
              }).toList()
                ..add(
                  pagesNum > 1
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 210,
                        child: ElevButton(
                          text: 'Load More',
                          icon: Icons.add,
                          color: Colors.grey,
                          onPressed: () {
                            Provider.of<ProductProvider>(context, listen: false)
                                .getProducts(nextPage, searchValue, sortType, GetTypes.PAGING);
                            pagesNum--;
                            nextPage++;
                          },
                        ),
                      ),
                    ],
                  )
                      : const SizedBox(),
                ),
            ),
          ),
        ],
      ),
    );
  }
}
