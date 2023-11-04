import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jezt_news/constants/constats.dart';
import 'package:jezt_news/screens/article_details_screen.dart';

newsTile(context, String title, String description, String publishAt,
    String img, Map newsData) {
  size = MediaQuery.of(context).size;
  scrHeight = size.height;
  scrWidth = size.width;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ArticleDetailsScreen(newsData: newsData),
              ));
        },
        child: SingleChildScrollView(
          child: Container(
            height: scrHeight * 0.2,
            width: scrWidth * 0.88,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: const [
                BoxShadow(spreadRadius: 2, color: Colors.white)
              ],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: scrWidth * 0.02,
                    ),
                    Expanded(
                        child: SizedBox(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: scrWidth * 0.46,
                                child: Text(title,
                                    overflow: TextOverflow.clip,
                                    maxLines: 4,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                publishAt,
                                style: TextStyle(color: Colors.red[800]),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                    Container(
                        height: scrHeight * 0.12,
                        width: scrWidth * 0.33,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: NetworkImage(img), fit: BoxFit.fill))),
                    SizedBox(
                      width: scrWidth * 0.02,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
