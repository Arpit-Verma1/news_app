import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../models/news_article_model.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle article;
  final int index;

  const NewsDetailScreen({Key? key, required this.article, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Detail"),
        actions: [
          Consumer<HomeProvider>(
            builder: (context, homePrv, child) => IconButton(
              icon: Icon(homePrv.articles[index].isLiked
                  ? Icons.favorite
                  : Icons.favorite_border),
              onPressed: () {
                // Handle favorite action
                homePrv.updateLikeStatus(index);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Handle share action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Animation for Image
            Hero(
              tag: article.urlToImage,
              child: CachedNetworkImage(
                imageUrl: article.urlToImage,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Icon(Icons.image_not_supported, size: 50),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "${article.author ?? 'Unknown'}  |  ${article.publishedAt}",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    article.description ?? "No description available",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
