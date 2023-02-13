import 'dart:convert';
import 'coin_data.dart';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final Uri url;
  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else {
      print('Response status code is ${response.statusCode}');
    }
  }
}

class Currencies {
  Future<dynamic> getPrice(String currency) async {
    var url = Uri(
        scheme: 'https',
        host: 'apiv2.bitcoinaverage.com',
        path: '/indices/global/ticker/BTCUSD');

    var key = '8588f9c8ef1ff28117f80576045e5999';
    var currencyUrl = Uri(
        scheme: 'http',
        host: 'api.coinlayer.com',
        path: '/live',
        queryParameters: {'access_key': key, 'target': currency});
    var gbpUrl = Uri(
        scheme: 'http',
        host: 'api.coinlayer.com',
        path: '/live',
        queryParameters: {'access_key': key, 'target': 'gbp'});
    var tszUrl = Uri(
        scheme: 'http',
        host: 'api.coinlayer.com',
        path: '/live',
        queryParameters: {'access_key': key, 'target': 'TZS'});

    var currentOne = await NetworkHelper(currencyUrl).getData();
    return currentOne;
  }
}
