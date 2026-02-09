import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
final box = Hive.box('Nitin');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body:Column(
        children:[
          Center(
            child: ElevatedButton(
              onPressed: () async{
                var box = Hive.box("Nitin");
                await box.clear();
                setState(() {

                });

              },
              child: const Text("Clear All"),
            ),
          ),
          Expanded(child: FutureBuilder(future: Hive.openBox('Nitin'), builder: (context,snapshot){
            return Column(
                children: [
                  Expanded(
                    child: ListView.builder(itemCount: box.length, itemBuilder: (context,index){
                      var reservedIndex = box.length-1-index;
                      var data = box.getAt(reservedIndex);
                      return ListTile(
                        title: Text(data['value'],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),),
                        trailing: IconButton(onPressed: (){
                          box.deleteAt(index);
                          setState(() {
                          });
                        }, icon: Icon(Icons.delete)),
                      );
                    }),
                  )]


            );

          }) )
        ]
      ),

    );
  }
}
