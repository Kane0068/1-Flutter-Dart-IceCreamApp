import 'package:flutter/material.dart';
import 'package:flutter_icecream/home_page.dart';
import 'package:flutter_icecream/models/db.dart';
import 'package:flutter_icecream/models/ice_cream.dart';

class IceCreamCard extends StatefulWidget {
  const IceCreamCard({Key? key}) : super(key: key);

  @override
  State<IceCreamCard> createState() => _IceCreamCardState();
}

class _IceCreamCardState extends State<IceCreamCard> {
  Db database = Db();
  List<Map> iceCreamList = [];
  @override
  void initState() {
    database.open();
    getIceCreamData();
    super.initState();
  }

  void getIceCreamData() {
    Future.delayed(const Duration(seconds: 1), () async {
      iceCreamList = await database.db!.rawQuery("SELECT * FROM İCEcREAMS");
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                cardAppBar(),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 440,
                  //color: Colors.amber,
                  child: ListView(
                    children: iceCreamList.map((iceCream) {
                      return iceCreamCartDetails(iceCream);
                    }).toList(),
                  ),
                )
              ]),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total :",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "\$170",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {},
                        child: Text(
                          "Checkout",
                          style: TextStyle(
                            color: Colors.black12,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget iceCreamCartDetails(Map<dynamic, dynamic> iceCream) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
        ),
      ),
    );
  }

  Widget cardAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
              ),
            ),
          ),
          Text(
            "Your Card",
            style: TextStyle(
              color: Colors.amber,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 40,
          )
        ],
      );
}



// DATABASE KISIMLARINI DETAYLICA İNCELE!!!
// VİDEO 28.40 'DA