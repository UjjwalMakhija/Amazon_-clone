import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/search/screens/search_screen.dart';
import 'package:amazon_clone/features/home/widgets/CarouseImages.dart';
import 'package:amazon_clone/features/home/widgets/categories.dart';
import 'package:amazon_clone/features/home/widgets/deal_of_the_day.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScren(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appbarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScren,
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(
                                  Icons.search_sharp,
                                  color: Colors.black,
                                  size: 23,
                                )),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(
                                color: Colors.black38,
                                width: 1,
                              )),
                          hintText: "Search Amazon.in",
                          hintStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                )),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.mic,
                    color: Colors.black,
                    size: 25,
                  ),
                )
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 114, 226, 221),
                Color.fromARGB(255, 162, 236, 233),
              ], stops: [
                0.5,
                1
              ])),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.location_on_outlined,
                        size: 20,
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "Deliver to ${user.name}  -  ${user.address}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )),
                    const Padding(
                      padding: EdgeInsets.only(top: 2, left: 5),
                      child: Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Cateegories(),
            const SizedBox(
              height: 10,
            ),
            CarouselImages(),
            Dealoftheday()
          ],
          // child: Text(user.toJson()),
        ),
      ),
    );
  }
}
