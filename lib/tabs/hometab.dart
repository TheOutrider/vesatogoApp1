import 'package:flutter/material.dart';
import 'package:flutter_vesatogo_assignment/models/Buyers.dart';
import 'package:flutter_vesatogo_assignment/models/Veges.dart';
import 'package:flutter_vesatogo_assignment/utils/api.dart';
import 'package:flutter_vesatogo_assignment/utils/widgets.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  ApiClass apiClass = new ApiClass();
  AppWidgets appWidgets = new AppWidgets();
  bool loadingVeges = true;
  bool loadingBuyers = true;

  List<Veges> vegeList = new List<Veges>();
  List<Veges> filteredList = new List<Veges>();
  List<Buyers> buyersList = new List<Buyers>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVegs();
    getBuys();
  }

  getVegs() async{
    await apiClass.getVegetablesData();
    vegeList = apiClass.vegeList;
    setState(() {
      filteredList = vegeList;
      loadingVeges = false;
    });
  }

  getBuys() async{
    await apiClass.getBuyersData();
    buyersList = apiClass.buyersList;
    setState(() {
      loadingBuyers = false;
      print(buyersList[0].price);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      Text("What is your Crop?" ,style: appWidgets.titleText(20),),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Color(0xFFF0F0F6),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              onChanged: (string){
                setState(() {
                  filteredList = vegeList.where((u) => (
                      u.commodity_name.toLowerCase().contains(string.toLowerCase())
                  )
                  ).toList();
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(18),
                hintText: 'Search Specified Crop',
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search, color: Color(0xFF333333),),
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(alignment: Alignment.centerLeft ,child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("Stock", style: appWidgets.boldText(20)),
              )),

              loadingVeges ? appWidgets.centerLoading() :
              Container(
                child: GridView.count(
                  childAspectRatio: 7/4,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  scrollDirection: Axis.vertical,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  children: List.generate(filteredList.length, (index){
                    final item = filteredList[index];
                    return VegeTile(
                      photo: item.photo,
                      name: item.commodity_name,
                    );
                  }
                  ),
                ),
              ),

              SizedBox(height: 16),
              Align(alignment: Alignment.centerLeft ,child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text("Buyers", style: appWidgets.boldText(20)),
              )),


              loadingBuyers ? appWidgets.centerLoading() :
              Container(
                height: 150,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: buyersList.length,
                    itemBuilder: (context, index){
                      final item = buyersList[index];
                      return BuyerTile(
                        photo: item.photo,
                        buyerName: item.buyerName,
                        crop: item.cropInfo.crop,
                        cropphoto: item.cropInfo.photo,
                        priceList: item.price,
                      );
                    }),
              ),

              SizedBox(height: 400,),
            ],
          ),
        ),
      ),

    );
  }
}

class VegeTile extends StatelessWidget {

  String name, photo;
  VegeTile({this.name, this.photo});
  AppWidgets appWidgets = new AppWidgets();

  @override
  Widget build(BuildContext context) {
    return  Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 5), child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          appWidgets.imageContainer(photo, 30),
          SizedBox(width: 5,),

          Expanded(child: Text(name.toString(),)),
        ],
      ),
      ),
    );
  }
}

class BuyerTile extends StatelessWidget {

  String photo, buyerName, crop, cropphoto;
  List<Price> priceList;
  BuyerTile({this.photo, this.buyerName, this.crop, this.cropphoto, this.priceList});

  AppWidgets appWidgets = new AppWidgets();

  @override
  Widget build(BuildContext context) {
    return Container( width: 300,
      child: Card(child: Padding( padding: EdgeInsets.all(8), child:
      Row(
        crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 65, width: 65,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(photo), fit: BoxFit.fill)
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  height: 15, width: 15,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(cropphoto), fit: BoxFit.fill)
                  ),
                ),
                SizedBox(width: 5,),
                Text(crop, style: appWidgets.titleText(15),)
              ],),
              SizedBox(height: 5),
              Text(buyerName, style: appWidgets.boldText(21),),
              SizedBox(height: 5),
              Container(
                height: 55,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: priceList.length,
                    itemBuilder: (context, index){
                      return Container(
                        margin: EdgeInsets.only(top: 5, right: 5), height: 50, width: 60,
                        padding: EdgeInsets.symmetric(horizontal: 3,vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4), color: Colors.grey[300],
                        ),
                        child: Column(
                          children: [
                            Text(priceList[index].date, style: TextStyle(fontSize: 9),),
                            SizedBox(height: 3,),
                            Expanded(child: Text("${priceList[index].price} / ${priceList[index].sku}", style: TextStyle(fontSize: 12),)),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          )
        ],),
      )
      ),
    );

  }
}
