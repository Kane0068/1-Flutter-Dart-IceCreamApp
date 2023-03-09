import 'package:flutter/material.dart';
import 'package:flutter_icecream/models/db.dart';
import 'package:flutter_icecream/models/ice_cream.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class IceCreamDetails extends StatefulWidget {
  final IceCream iceCream;
  const IceCreamDetails({Key? key, required this.iceCream}) : super(key: key);

  @override
  State<IceCreamDetails> createState() => _IceCreamDetailsState();
}

class _IceCreamDetailsState extends State<IceCreamDetails> {
  Db database = Db();//+1
  @override
  void initState() {
    database.open();//+2
    super.initState();
  }

  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            Container(
              height: height / 2 + 50,
              color: widget.iceCream.lightColor,
              child: Image.asset(
                "assets/${widget.iceCream.image}",
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 45,
                  width: 45,
                  padding: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 177, 110, 10),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(20),
                height: height / 2 - 30,
                width: width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: iceCreamDetails(),
              ),
            ),
            Positioned(
                top: height / 2 - 20,
                right: 20,
                child: Container(
                  height: 108,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.iceCream.count++;
                          });
                        },
                        child: Container(
                          height: 38,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        "${widget.iceCream.count}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (widget.iceCream.count < 1) {
                              widget.iceCream.count = 1;
                            }
                            widget.iceCream.count--;
                          });
                        },
                        child: Container(
                          height: 38,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    ));
  }

  Widget iceCreamDetails() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.iceCream.flavor,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Ice Cream",
                style: TextStyle(
                  color: Color.fromARGB(255, 250, 188, 4),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RatingBar.builder(
                    itemSize: 18,
                    allowHalfRating: true,
                    unratedColor: Colors.purple,
                    initialRating: widget.iceCream.rating,
                    itemCount: 5,
                    itemBuilder: (context, _) {
                      return const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      );
                    },
                    onRatingUpdate: (rating) {
                      setState(() {
                        widget.iceCream.rating = rating;
                      });
                    },
                  ),
                  Text(
                    "\$${widget.iceCream.price}",
                    style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  )
                ],
              )
            ],
          ),
          Text(
            "orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchang",
            style:
                TextStyle(color: Colors.amber.withOpacity(0.5), fontSize: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  isFavorite = !isFavorite;
                },
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: isFavorite ? Colors.amber : Colors.white,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 240,
                child: ElevatedButton(
                  onPressed: () async {
                    //bilgilerin database girildiği kısım +3
                    await database.db!.rawInsert(
                        "INSERT INTO iceCreams(flavour,image,price,count,lightColor,darkColor) VALUES (?,?,?,?,?,?);",
                        [
                          widget.iceCream.flavor,
                          widget.iceCream.image,
                          widget.iceCream.price,
                          widget.iceCream.count,
                          widget.iceCream.lightColor.value,
                          widget.iceCream.darkColor.value,
                        ]);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.white,
                        content: Text("Ice Cream Added to the Cart",
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                        ),),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Text(
                    "Add To Card",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          )
        ],
      );
}
