import 'package:flutter/material.dart';

class Directory extends StatelessWidget {
  const Directory({super.key});

  @override
  Widget build(BuildContext context) {
    return DirectoryState();
  }
}

class DirectoryState extends StatefulWidget {
  const DirectoryState({super.key});

  @override
  State<DirectoryState> createState() => _DirectoryStateState();
}

class _DirectoryStateState extends State<DirectoryState>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover DXB Directory'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Text('Dubai'),
            Text('Abu Dhabi'),
            Text('Sharjah'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          screenWidth > 600
              ? GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    directoryCard(
                        context,
                        'assets/christoph-schulz-7tb-b37yHx4-unsplash-opt.jpg',
                        'Burj Khalifa',
                        'The tallest building in the world located in Dubai.'),
                    directoryCard(
                        context,
                        'assets/david-rodrigo-kZ1zThg6G40-unsplash-opt.jpg',
                        'The Dubai Mall',
                        'One of the largest shopping malls in the world.'),
                    directoryCard(
                        context,
                        'assets/garo-janboulian-qCSup4ARRg8-unsplash-opt.jpg',
                        'Palm Jumeirah',
                        'A palm inside the sea, known for its luxury hotels and residences.'),
                  ],
                )
              : ListView(
                  children: <Widget>[
                    directoryCard(
                        context,
                        'assets/christoph-schulz-7tb-b37yHx4-unsplash-opt.jpg',
                        'Burj Khalifa',
                        'The tallest building in the world located in Dubai.'),
                    directoryCard(
                        context,
                        'assets/david-rodrigo-kZ1zThg6G40-unsplash-opt.jpg',
                        'The Dubai Mall',
                        'One of the largest shopping malls in the world.'),
                    directoryCard(
                        context,
                        'assets/garo-janboulian-qCSup4ARRg8-unsplash-opt.jpg',
                        'Palm Jumeirah',
                        'A palm inside the sea, known for its luxury hotels and residences.'),
                  ],
                ),
          Text('Abu Dhabi'),
          Text('Sharjah'),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/Home.png'),
              Image.asset('assets/Grid.png'),
              Image.asset('assets/avatar.png'),
              Image.asset('assets/Heart.png'),
            ],
          ),
        ),
      ),
    );
  }
}

Widget directoryCard(
    BuildContext context, String imageUrl, String title, String description) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(imageUrl, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 5,
            children: [
              Icon(Icons.favorite_border_outlined),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/singlePage', arguments: {'title': title, 'imageUrl': imageUrl, 'description': description},);
                },
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.left,
          ),
        ]),
  );
}
