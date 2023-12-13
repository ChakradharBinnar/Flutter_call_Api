import 'dart:convert';

import 'package:apicall3/cons1.dart';
import 'package:apicall3/model.dart';
import 'package:apicall3/scrollable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
      home: LastExampleScreen(), scrollBehavior: MyCustomScrollBehavior()));
}

class LastExampleScreen extends StatefulWidget {
  const LastExampleScreen({Key? key}) : super(key: key);

  @override
  _LastExampleScreenState createState() => _LastExampleScreenState();
}



class _LastExampleScreenState extends State<LastExampleScreen> {
  Future<ProductsModel> getProductsApi() async {
    //create your own api
    final response = await http.get(Uri.parse(
        'https://localshouts.com/api/catProduct?category=dry-fruits'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Api Course'),
        ),
        body: Container(
          width: double.infinity,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<ProductsModel>(
              future: getProductsApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 400,
                            height: 100,
                            color: Colors.amber,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(snapshot.data!.data![index].productName
                                        .toString()),
                                   Image(image: NetworkImage("$imgBaseUrl${snapshot.data!.data![index].id.toString()}/${snapshot.data!.data![index].mainImage.toString()}"))
                                        
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return Text('Loading');
                }
              },
            ),
          ),
        ));
  }
}
