import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = '84BC439D-C10B-4F77-8C43-CFDF46439EA2';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

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
  Map<String,String> cryptoPrices ={};
  Future getBitcoinData(String selectedCurrency) async {
    for (String crypto in cryptoList) {
      http.Response response = await http
          .get('$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey');
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
