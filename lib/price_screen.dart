import 'package:bitcointracker/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  PriceScreenState createState() => PriceScreenState();
}

class PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  List<DropdownMenuItem<String>>? getDropDownitem() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;

    // return DropdownButton<String>(
    //   value: selectedCurrency,
    //   items: dropdownItems,
    //   onChanged: (value) {
    //     setState(() {
    //       selectedCurrency = value!;

    //     });
    //   },
    // );
  }

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      CoinData coinData = CoinData();
      var data = await coinData.getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Column makeCards() {
    List<CryptoCards> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(CryptoCards(
        cryptoCurrency: crypto,
        selectedCurrency: selectedCurrency,
        value: isWaiting ? '?' : coinValues[crypto],
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
                value: selectedCurrency,
                // ignore: prefer_const_literals_to_create_immutables
                items: getDropDownitem(),
                onChanged: ((value) {
                  setState(() {
                    selectedCurrency = value!;
                  });
                })),
          ),
        ],
      ),
    );
  }
}

class CryptoCards extends StatelessWidget {
  const CryptoCards({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency,
  });

  final String? value;
  final String? selectedCurrency;
  final String? cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        
        child: Text('1 $cryptoCurrency = $value $selectedCurrency',
        
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20.0, 
        color: Colors.white),),),
      ),
      
    );
  }
}
 