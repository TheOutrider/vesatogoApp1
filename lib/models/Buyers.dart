class Buyers{

  String id;
  String buyerName;
  String photo;
  CropInfo cropInfo;
  Loc loc;
  List<Price> price;

  Buyers({this.id, this.buyerName, this.photo, this.cropInfo, this.loc, this.price});

  factory Buyers.fromJson(Map<dynamic, dynamic> parsedJson){

    var pList = parsedJson['price'] as List;
    print(pList.runtimeType);
    List<Price> priceList = pList.map((i) => Price.fromJson(i)).toList();

    return new Buyers(
      id: parsedJson['id'] == null ? null : parsedJson['id'],
      buyerName: parsedJson['buyerName'] == null ? null : parsedJson['buyerName'],
      photo: parsedJson['photo'] == null ? null : parsedJson['photo'],
      loc: Loc.fromJson(parsedJson['location']),
      cropInfo: CropInfo.fromJson(parsedJson['cropInfo']),
      price: priceList,
    );
  }
}

class CropInfo{

  String  crop, photo;

  CropInfo({this.crop, this.photo});

  factory CropInfo.fromJson(Map<String, dynamic> parsedJson) {
      return new CropInfo(
        crop: parsedJson['crop'] == null ? null : parsedJson['crop'],
        photo: parsedJson['photo'] == null ? null : parsedJson['photo'],
      );
  }
}

class Loc{

  String lat, lng;

  Loc({this.lat, this.lng});

  factory Loc.fromJson(Map<String, dynamic> parsedJson){
    return new Loc(
      lat: parsedJson['lat'].toString() == null ? null : parsedJson['lat'].toString(),
      lng: parsedJson['lng'].toString() == null ? null : parsedJson['lng'].toString(),
    );
  }

}

class Price{

  String date, price, sku;
  Price({this.date, this.price, this.sku});

  factory Price.fromJson(Map<String, dynamic> parsedJson){
    return new Price(
      date: parsedJson['date'] == null ? null : parsedJson['date'],
      price: parsedJson['price'].toString() == null ? null : parsedJson['price'].toString(),
      sku: parsedJson['sku'] == null ? null : parsedJson['sku'],
    );
  }
}