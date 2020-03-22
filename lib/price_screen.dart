import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';

// Used to know which OS is being used
// I only want to use the Platform class, now the entire directory. (External Libraries -> Dart SDK -> io -> platform.dart
import 'dart:io' show Platform;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  // Creates the drop down button and fills it with items
  DropdownButton<String> androidDropDown() {
    // List of widgets to hold the dropDownMenuItems
    // <String> because that's the child type
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
//      print(currency);
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      // Add each newItem into the list of widgets
      dropDownItems.add(newItem);
    }

    return DropdownButton(
      // Value is the default text that's on the button
      value: selectedCurrency,
      items: dropDownItems,
      //                DropdownMenuItem(
      //                  child: Text('USD'),
      //                  value: 'USD',
      //                ),
      //                DropdownMenuItem(
      //                  child: Text('EUR'),
      //                  value: 'EUR',
      //                ),
      //                DropdownMenuItem(
      //                  child: Text('GBP'),
      //                  value: 'GBP',
      //                )
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        print(value);
      },
    );
  }

  // Creates the iOSPicker and the items.
  CupertinoPicker iOSPicker() {
    List<Text> currencies = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      currencies.add(newItem);
//      Or I can do currencies.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedCurrency) {
        print(selectedCurrency);
      },
      children: currencies,
    );
  }

  // Function that determines which picker to display depending on what platform is being used.
  Widget getPicker() {
    if (Platform.isAndroid) {
      return androidDropDown();
    } else {
      return iOSPicker();
    }
  }

  @override
  Widget build(BuildContext context) {
//    getDropDownItems();

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
//            Drop down button with multiple selection for the user to pick.
//            child: getPicker(),
            // This is another way of determining which picker to display.
            child: Platform.isAndroid ? androidDropDown() : iOSPicker(),
          ),
        ],
      ),
    );
  }
}
