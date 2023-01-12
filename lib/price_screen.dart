import 'dart:convert';

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'ZAR';
  String PanelBTCPrice = "loading...";
  String PanelETHPrice = "loading...";
  String PanelLTCPrice = "loading...";
  static const JsonDecoder decoder = JsonDecoder();
  CoinData coinData = new CoinData();

  CupertinoPicker getCupertinoPicker() {
    Widget item;
    List<Widget> allitems = [];
    for (var i = 0; i < currenciesList.length - 1; i++) {
      item = Text(currenciesList[i]);
      allitems.add(item);
    }

    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: 20),
      itemExtent: 32.0,
      onSelectedItemChanged: (int value) {
        setState(() {
          selectedCurrency = currenciesList[value];
          setPanelsData();
        });
      },
      children: allitems,
    );
  }

  DropdownButton<String> getDropDownButton() {
    DropdownMenuItem<String> item;
    List<DropdownMenuItem<String>> allitems = [];
    for (var i = 0; i < currenciesList.length; i++) {
      item = DropdownMenuItem<String>(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      );
      allitems.add(item);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: allitems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          setPanelsData();
        });
      },
    );
  }

  // Widget getPicker() {
  //   if (Platform.isIOS) {
  //     return getCupertinoPicker();
  //   } else if (Platform.isAndroid) {
  //     return getDropDownButton();
  //   } else {
  //     return getDropDownButton();
  //   }
  // }

  void setPanelsData() {
    //BTC
    coinData.getCoinData(selectedCurrency, 'BTC').then((value) => {
          setState(() {
            final Map object = decoder.convert(value);
            PanelBTCPrice = object['rate'].toStringAsFixed(2);
          })
        });

    coinData.getCoinData(selectedCurrency, 'ETH').then((value) => {
          setState(() {
            final Map object = decoder.convert(value);
            PanelETHPrice = object['rate'].toStringAsFixed(2);
          })
        });

    coinData.getCoinData(selectedCurrency, 'LTC').then((value) => {
          setState(() {
            final Map object = decoder.convert(value);
            PanelLTCPrice = object['rate'].toStringAsFixed(2);
          })
        });
  }

  @override
  void initState() {
    super.initState();

    //BTC
    coinData.getCoinData(selectedCurrency, 'BTC').then((value) => {
          setState(() {
            final Map object = decoder.convert(value);
            PanelBTCPrice = object['rate'].toStringAsFixed(2);
          })
        });

    coinData.getCoinData(selectedCurrency, 'ETH').then((value) => {
          setState(() {
            final Map object = decoder.convert(value);
            PanelETHPrice = object['rate'].toStringAsFixed(2);
          })
        });

    coinData.getCoinData(selectedCurrency, 'LTC').then((value) => {
          setState(() {
            final Map object = decoder.convert(value);
            PanelLTCPrice = object['rate'].toStringAsFixed(2);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
              Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
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
                    '1BTC = ' + PanelBTCPrice + ' ' + selectedCurrency,
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
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
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
                    '1ETH = ' + PanelETHPrice + ' ' + selectedCurrency,
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
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
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
                    '1LTC = ' + PanelLTCPrice + ' ' + selectedCurrency,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ]),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getCupertinoPicker() : getDropDownButton(),
          ),
        ],
      ),
    );
  }
}
