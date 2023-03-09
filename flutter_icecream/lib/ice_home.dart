import 'package:flutter/material.dart';
import 'package:flutter_icecream/ice_card.dart';
import 'package:flutter_icecream/ice_details.dart';
import 'package:flutter_icecream/models/ice_cream.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class IceCreamHomePage extends StatefulWidget {
  const IceCreamHomePage({Key? key}) : super(key: key);

  @override
  State<IceCreamHomePage> createState() => _IceCreamHomePageState();
}

class _IceCreamHomePageState extends State<IceCreamHomePage> {
  Color darkColor = Colors.pink;
  Color lightColor = Colors.orange;
  List<Map<String, dynamic>> types = [
    {"icon": Icons.icecream, "label": "Cones"},
    {"icon": Icons.cake, "label": "Cake"},
    {"icon": Icons.fastfood, "label": "FastFood"},
    {"icon": Icons.icecream, "label": "Cones"}
  ]; // iceListView da gösterilecek iconlar;

  List<IceCream> IceCreams = IceCreamList;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 2 - 70,
              //color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  iceCreamAppBar(),
                  searchContainer(),
                  iceListView(),
                  const Text(
                    "Popular",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 230, 154, 41),
                    ),
                  ),
                ],
              ),
            ),
          ),
          popularIceCreams(),
        ]),
      ),
    );
  }

  Widget popularIceCreams() => Container(
        height: 280,
        margin: const EdgeInsets.only(left: 20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: IceCreams.length,
          itemBuilder: (context, index) {
            final IceCream = IceCreams[index]; // İndexleri dahil ediyoruz
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => IceCreamDetails(
                            iceCream: IceCream,
                          )),
                );
              },
              child: Container(
                height: 280,
                width: 230,
                margin: const EdgeInsets.only(right: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          //color: Colors.orange,
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/${IceCream.image}"), // Listenin içindeki resimleri yazıyoruz
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        IceCream.flavor,
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // add rating bar
                          RatingBar.builder(
                            initialRating: IceCream.rating,
                            allowHalfRating: true,
                            itemSize: 18,
                            itemCount: 5,
                            itemBuilder: (context, _) {
                              return const Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            },
                            onRatingUpdate: (rating) {},
                          ),
                          Text(
                            "\$${IceCream.price}",
                            style: const TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          )
                        ],
                      )
                    ]),
              ),
            );
          },
        ),
      );

  Widget iceListView() => Container(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: types.length,
          itemBuilder: (context, index) {
            final type = types[index];
            return Container(
              height: 100,
              width: 70,
              margin: EdgeInsets.only(right: 28),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      type["icon"],
                      size: 28,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    type["label"],
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );

  Widget searchContainer() => Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.orange.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          cursorColor: Colors.black,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintText: "Search Your Ice Cream",
            hintStyle: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
            suffixIcon: Container(
              width: 20,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.icecream,
                color: Colors.black,
              ),
            ),
          ),
        ),
      );

  Widget iceCreamAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: lightColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.menu),
          ),
          const Text(
            "Explore Our \n Flavours",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => IceCreamCard())
                ),
              );
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      );
}
