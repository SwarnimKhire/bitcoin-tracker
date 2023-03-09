import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

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
//https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=BD8C72C7-7AE3-484C-89B8-8E6E98ABEA93
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String apiurl =
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$selectedCurrency?apikey=BD8C72C7-7AE3-484C-89B8-8E6E98ABEA93';

      Response response = await http.get(Uri.parse(apiurl));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
        // ignore: avoid_print
        print(price);
      } else {
        // ignore: avoid_print
        print(response.statusCode);
        throw 'Problem with the request';
      }
    }
    return cryptoPrices;
  }
}
