import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'network.dart';

enum myCurrencyList { USD, GBP, TZS }

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'BTC';

  DropdownButton AndroidPicker() {
    List<DropdownMenuItem<String>> myDrop = [];
    for (String currency in CryptoList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
        onTap: () {
          setState(() {
            updateUSD();
            updateTZS();
            updateGBP();
          });
        },
      );
      myDrop.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: myDrop,
      onChanged: (var value) {
        setState(() {
          selectedCurrency = value!;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> myList = [];

    for (String currency in CryptoList) {
      var newText = Text(currency);

      myList.add(newText);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (int value) {
        print(CryptoList[value]);
        updateTZS();
        updateGBP();
        updateUSD();
      },
      children: myList,
    );
  }

  var usdprice = '?';
  var tzsprice = '?';
  var gbpprice = '?';
  void updateUSD() async {
    var currencyData = await Currencies().getPrice('USD');
    dynamic myCurrency = currencyData;
    setState(() {
      // double prices = myCurrency['averages']['day'];
      // price = prices.toStringAsFixed(1);
      double usdrates = myCurrency['rates'][selectedCurrency];
      usdprice = usdrates.toString();
    });
  }

  void updateTZS() async {
    var currencyData = await Currencies().getPrice('TZS');
    dynamic myCurrency = currencyData;
    setState(() {
      // double prices = myCurrency['averages']['day'];
      // price = prices.toStringAsFixed(1);
      double tzsrates = myCurrency['rates'][selectedCurrency];
      tzsprice = tzsrates.toString();
    });
  }

  void updateGBP() async {
    var currencyData = await Currencies().getPrice('GBP');
    dynamic myCurrency = currencyData;
    setState(() {
      // double prices = myCurrency['averages']['day'];
      // price = prices.toStringAsFixed(1);
      double gbprates = myCurrency['rates'][selectedCurrency];
      gbpprice = gbprates.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    updateUSD();
    updateTZS();
    updateTZS();
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '$usdprice USD = 1 $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '$gbpprice GBP = 1 $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '$tzsprice TZS = 1 $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOSPicker() : AndroidPicker()),
        ],
      ),
    );
  }
}
