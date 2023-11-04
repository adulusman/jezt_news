import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:jezt_news/constants/constats.dart';
import 'package:jezt_news/models/news_article.dart';
import 'package:jezt_news/widgets/custom_snackbar.dart';
import 'package:lottie/lottie.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _HomePageState();
}

class _HomePageState extends State<NewsPage> {
  Future<List<NewsArticle>> fetchNewsArticles() async {
    try {
      final response = await http.get(Uri.parse(Api.baseurl));

      if (response.statusCode == 200) {
        // showAdlSnackbar(context, 'News Fetched Successfully');
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final articles = json['articles'] as List<dynamic>;
        return articles
            .map((article) =>
                NewsArticle.fromJson(article as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to fetch news articles');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showAdlSnackbar(context, e.toString());

      throw Exception('Failed to fetch news articles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Top Headlines')),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              FutureBuilder(
                future: fetchNewsArticles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height / 1.3,
                            child: Center(
                              child: SizedBox(
                                  width: scrWidth * 0.6,
                                  child: Lottie.asset(Constants.loading)),
                            )));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: scrWidth * 0.3,
                              child: Image.asset(Constants.warning)),
                          SizedBox(
                            height: scrHeight * 0.02,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Retry the request when the button is pressed
                              setState(() {
                                snapshot = fetchNewsArticles()
                                    as AsyncSnapshot<List<NewsArticle>>;
                              });
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      var data = snapshot.data![index];
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: scrWidth * 0.88,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Colors.blue.shade100,
                                  Colors.teal.shade100
                                ])),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                data.title,
                                style: GoogleFonts.ubuntu(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
