import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jezt_news/constants/constats.dart';
import 'package:jezt_news/models/news_article.dart';
import 'package:jezt_news/utils/theme.dart';
import 'package:jezt_news/widgets/custom_snackbar.dart';
import 'package:jezt_news/widgets/custom_textfield.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  List articleSort = [];
  List articles = [];
  Future<List<NewsArticle>> fetchNewsArticles() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=01fb4d1b588743bfba5b0089bae107b2'));

      if (response.statusCode == 200) {
        // showAdlSnackbar(context, 'News Fetched Successfully');

        final json = jsonDecode(response.body) as Map<String, dynamic>;
        articles = json['articles'] as List<dynamic>;
        articleSort = articles;

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

  getSortedArticles(String txt) {
    articleSort = [];
    for (int i = 0; i < articles.length; i++) {
      if (articles[i]['title'].toString().toLowerCase().contains(txt)) {
        articleSort.add(articles[i]);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade200,
          centerTitle: true,
          title: Text(
            'JEZT News',
            style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.bold, color: Colors.red),
          ),
          actions: [
            ThemeSwitcher.withTheme(
              builder: (_, switcher, theme) {
                return IconButton(
                  onPressed: () => switcher.changeTheme(
                    theme: theme.brightness == Brightness.light
                        ? ThemeData.dark(useMaterial3: true)
                        : ThemeData.light(useMaterial3: true),
                  ),
                  icon: theme.brightness == Brightness.light
                      ? Icon(
                          Icons.brightness_3,
                          size: 25,
                          color: Colors.black,
                        )
                      : Icon(
                          Icons.brightness_7,
                          size: 25,
                          color: Colors.white,
                        ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder(
              future: searchController.text == ''
                  ? fetchNewsArticles()
                  : getSortedArticles(searchController.text),
              builder: (context, snapshot) {
                return Column(
                  children: [
                    SizedBox(
                      height: scrHeight * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: AdlTextField(
                          suffixIcon: Icon(Icons.search),
                          onChanged: (value) {
                            articleSort = [];
                            if (searchController.text.isEmpty) {
                              articleSort.addAll(articles);
                            } else {
                              getSortedArticles(value);
                            }
                          },
                          controller: searchController,
                          label: 'Search news'),
                    ),
                    if (snapshot.connectionState == ConnectionState.waiting)
                      Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height / 1.3,
                              child: Center(
                                child: SizedBox(
                                    width: scrWidth * 0.6,
                                    child: Lottie.asset(Constants.loading)),
                              ))),
                    if (snapshot.hasError)
                      Center(
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
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    articleSort.isEmpty && !snapshot.hasError
                        ? Center(
                            child: Column(
                            children: [
                              SizedBox(
                                  width: scrWidth * 0.3,
                                  child:
                                      Lottie.asset(Constants.searchNotFound)),
                              Text(
                                'News Not found',
                                style:
                                    GoogleFonts.ubuntu(color: Colors.blueGrey),
                              ),
                            ],
                          ))
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: articleSort.length,
                            itemBuilder: (context, index) {
                              var data = articleSort[index];
                              
                              return newsTile(
                                  context,
                                  data['title'] ?? '',
                                  data['description'] ?? '',
                                  DateFormat('dd-MM-yyy').format(
                                      DateTime.parse(data['publishedAt'])),
                                  data['urlToImage'] ?? '',
                                  data);
                            },
                          ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
