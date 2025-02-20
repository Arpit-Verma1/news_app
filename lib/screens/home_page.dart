import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../widgets/homw_widgets/news_card.dart';
import '../widgets/homw_widgets/news_card_skeleton.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return ListView.builder(
              itemCount: 5, // Show 5 skeletons while loading
              itemBuilder: (context, index) => NewsCardSkeleton(),
            );
          } else if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          } else if (provider.articles.isEmpty) {
            return Center(child: Text('No articles found.'));
          }

          return ListView.builder(
            itemCount: provider.articles.length,
            itemBuilder: (context, index) {
              return NewsCard(article: provider.articles[index],index: index,);
            },
          );
        },
      ),
    );
  }
}
