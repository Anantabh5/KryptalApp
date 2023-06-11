import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> currencies = [];

  final List<MaterialColor> colors = [
    Colors.blue,
    Colors.indigo,
    Colors.purple
  ];
  @override
  /*void initState() {
    super.initState();
    currencies = await getCurr();
  }
  Future<List> getCurr() async{
    String kUrl = "https://api.coinranking.com/v2";
    http.Response response = await http.get(kUrl);
    return json.decode(response.body);

  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kryptal"),
      ),
      body: kwidget(),
    );
  }

  Widget kwidget() {
    return Container(
      child: Flexible(
        child: ListView.builder(
          itemCount: currencies.length,
          itemBuilder: (BuildContext context, int index) {
            final Map currency = currencies[index];
            final MaterialColor color = colors[index % colors.length];

            return getItem(currency, color);
          },
        ),
      ),
    );
  }

  ListTile getItem(Map currency, MaterialColor color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(currency['name']),
      ),
      title:
          Text(currency['name'], style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: _getSubtitleText(currency['price'], currency['change']),
    );
  }

  Widget _getSubtitleText(String price, String change) {
    TextSpan priceWidget =
        new TextSpan(text: "\$$price\n", style: TextStyle(color: Colors.black));
    TextSpan change;

    if (double.parse(change) > 0) {
      changeWidget =
          TextSpan(text: change, style: new TextStyle(color: Colors.green));
    } else {
      changeWidget =
          TextSpan(text: change, style: new TextStyle(color: Colors.red));
    }
    return RichText(text: TextSpan(children: [priceWidget, changeWidget]));
  }
}
