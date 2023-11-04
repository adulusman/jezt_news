import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jezt_news/constants/constats.dart';
import 'package:jezt_news/widgets/custom_button.dart';
import 'package:jezt_news/widgets/custom_snackbar.dart';
import 'package:jezt_news/widgets/custom_textfield.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final Map newsData;
  const ArticleDetailsScreen({super.key, required this.newsData});

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  TextEditingController abcd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ThemeSwitchingArea(
        child: Scaffold(
          appBar: AppBar(automaticallyImplyLeading: true),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: scrHeight * 0.02,
                ),
                Center(
                  child: Container(
                    height: scrHeight * 0.25,
                    width: scrWidth * 0.9,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.newsData['urlToImage']),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2, color: Colors.grey.shade200)
                        ],
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: scrHeight * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: scrWidth * 0.05,
                    ),
                    Text('Source: ${widget.newsData['source']['id']}'),
                    const Expanded(child: SizedBox()),
                    Text(
                      DateFormat('dd-MM-yyy').format(
                          DateTime.parse(widget.newsData['publishedAt'])),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red[800]),
                    ),
                    SizedBox(
                      width: scrWidth * 0.05,
                    )
                  ],
                ),
                SizedBox(
                  height: scrHeight * 0.02,
                ),
                SizedBox(
                  width: scrWidth * 0.9,
                  child: Text(
                    widget.newsData['title'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: scrWidth * 0.9,
                  child: Text(
                    widget.newsData['description'],
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final Uri url = Uri.parse(widget.newsData['url']);
                    _launchInWebView(url);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Read More...',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                      SizedBox(
                        width: scrWidth * 0.05,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: scrHeight * 0.02,
                ),
                CustomButton(
                  label: 'Submit',
                  onPressed: () {
                    showAdlSnackbar(isWarning: true, context, 'something');
                  },
                ),
                SizedBox(
                  height: scrHeight * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AdlTextField(controller: abcd, label: 'label'),
                ),
                SizedBox(
                  height: scrHeight * 0.02,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
