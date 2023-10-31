var scrHeight;
var scrWidth;
var size;

class Constants {
  static const homeIcon = 'assets/home.png';
  static const peopleIcon = 'assets/people.png';
  static const cahtIcon = 'assets/chat.png';
  static const warning = 'assets/warning-sign.png';
  static const loading = 'assets/loading.json';
  static const news = 'assets/news.png';
  static const worldNews = 'assets/world-news.png';
  static const newspaper = 'assets/newspaper.png';
  static const searchNotFound = 'assets/searchNotFound.json';
}

class Api {
  static String baseurl =
      'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=bbc7f958d6c8405ca0ef80d677727dd9';
}
