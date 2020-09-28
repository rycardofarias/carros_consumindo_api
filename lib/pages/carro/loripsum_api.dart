import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:http/http.dart' as http;
class LoripsomBloc{

  static String lorim;

  final _streamController = StreamController<String>();
  Stream<String> get stream => _streamController.stream;

  loadCarros() async {
    String s = lorim ?? await LoripsomApi.getLoripsum();
    lorim = s;
    _streamController.add(s);
  }
  void dispose() {
    _streamController.close();
  }
}

class LoripsomApi{
  static Future<String> getLoripsum() async{
    var url = 'https://loripsum.net/api';

    print("GET > $url");
    var response = await http.get(url);
    String text = response.body;

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("<p>", "");

    return text;
  }
}