import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  //TODO: Move to .env file (KEY)
  Map<String, String> requestHeaders = {
    'X-CoinAPI-Key': dotenv.env['X-CoinAPI-Key'].toString(),
  };

  late String BTC_Price;

  Future<String> getCoinData(String currencyCode, String cryptoCode) async {
    var urlBTCGetPrice = Uri.parse('https://rest.coinapi.io/v1/exchangerate/' +
        cryptoCode +
        '/' +
        currencyCode);

    final response = await http.get(urlBTCGetPrice, headers: requestHeaders);
    if (response.statusCode == 200) {
      //Server response valid
      //TODO: parse the JSON and only return price of BTC in USD
      return response.body;
    } else {
      // Server response error
      throw Exception('Failed!');
    }
  }
}
