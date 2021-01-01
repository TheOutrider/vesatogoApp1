import 'package:flutter_vesatogo_assignment/models/Buyers.dart';
import 'package:flutter_vesatogo_assignment/models/Veges.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClass {

  List<Veges> vegeList = [];
  List<Buyers> buyersList = [];

  Future<void> getVegetablesData() async {

    try{

      String url = 'https://firebasestorage.googleapis.com/v0/b/vesatogofleet.appspot.com/o/androidTaskApp%2FcommodityList.json?alt=media&token=9b9e5427-8769-4dec-83c4-52afe727dbf9';
      var jsonData;

      http.Response response = await http.get(url);
      jsonData = jsonDecode(response.body);
      print(jsonData);

      for(var elements in jsonData) {
        Veges veges = Veges(
            id: elements['id'],
            commodity_name: elements['commodityName'],
            photo: elements['photo']
        );
        vegeList.add(veges);
      }



    } catch(e){
      print("caught the error" + e);
    }


  }

  Future<void> getBuyersData() async{

    String url = 'https://firebasestorage.googleapis.com/v0/b/vesatogofleet.appspot.com/o/androidTaskApp%2FbuyerList.json?alt=media&token=3dcc96c2-9309-4873-868d-bf0023f6266c';
    var jsonData;

    http.Response response = await http.get(url);
    jsonData = jsonDecode(response.body);
    print(jsonData.toString());

    for (var buyers in jsonData){
      buyersList.add(Buyers.fromJson(buyers));
    }


  }

}