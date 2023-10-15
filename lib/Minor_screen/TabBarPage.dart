import 'package:flutter/material.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      animationDuration: Duration(milliseconds: 200),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            padding: EdgeInsets.only(left: 12),
            isScrollable: true,
            indicatorColor: Colors.black,
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            dividerColor: Colors.black,
            tabs: [
              Tab(
                child: Text(
                  'WishList',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'Course detail',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'Statistics',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text('Wishlist'),
            ),
            Center(
              child: Text('Wishlist'),
            ),
            Center(
              child: Text('Wishlist'),
            ),
          ],
        ),
      ),
    );
  }
}
