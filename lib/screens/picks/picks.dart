import 'package:flutter/material.dart';
import 'package:Zenst/Models/product.dart';

class PicksPage extends StatefulWidget {
  const PicksPage({super.key});

  @override
  State<PicksPage> createState() => _PicksPageState();
}

class _PicksPageState extends State<PicksPage> {
  final List<Product> picksList = getProducts();
  List<int> likedPicks = [];

  void picksIt(int index) {
    setState(() {
      (likedPicks.contains((picksList[index].id)))
          ? likedPicks.remove(picksList[index].id)
          : likedPicks.add(picksList[index].id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          mainAxisExtent: 320,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: picksList.length,
        itemBuilder: (context, index) {
          final String imagePath = picksList[index].imagePath;
          return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              image: DecorationImage(
                                  image: NetworkImage(imagePath),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${picksList[index].totalSold} Sold',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Text(picksList[index].name,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                    Text(
                      picksList[index].description,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'IDR ${picksList[index].price}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          IconButton(
                            onPressed: () {
                              picksIt(index);
                            },
                            icon: Icon(
                                (likedPicks.contains(picksList[index].id))
                                    ? Icons.favorite
                                    : Icons.favorite_outline),
                            color: likedPicks.contains(picksList[index].id)
                                ? Colors.red[300]
                                : Colors.black,
                            style: const ButtonStyle(
                              visualDensity: VisualDensity.standard,
                            ),
                          )
                        ])
                  ]));
        },
      ),
    );
  }
}
