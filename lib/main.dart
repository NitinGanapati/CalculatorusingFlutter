import 'package:calci/Calculator.dart';
import 'package:flutter/material.dart';

import 'Calculator.dart' as Calculator;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String expression = '';
  var no1Controller = TextEditingController();
  var no2Controller = TextEditingController();
  var resultController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    var numArray = ["C","(",")","Cl",7,8,9,"/",4,5,6,"x",1,2,3,"-",0,".","=","+"];


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black45,
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(controller: no1Controller,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: TextField(controller: no2Controller,),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: GridView.builder(itemCount: numArray.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: SizedBox(child: ElevatedButton(onPressed: (){
                      no2Controller.text = expression;
                      setState(() {
                        if(numArray[index]=='C'){
                          expression = '';
                          no1Controller.clear();
                          no2Controller.clear();
                        } else if(numArray[index]=='='){
                          String m = Calculator.Calculation(expression);
                          // print("Result is $m");
                        }
                        else if(numArray[index]=='+'){
                          expression += '+';
                        }
                        else if(numArray[index]=='-'){
                          expression += "-";
                        }
                        else if(numArray[index]=='x'){
                          expression += "*";
                        }
                        else {
                          expression += numArray[index].toString();
                        }
                      });

                    }, child: Text(numArray[index].toString()))),
                  );
                }),
              )

            ],

          ),
        )
    );
  }

  //
  // void Calculation(String expression) {
  //   var pattern = RegExp(r'([+\-*/])');
  //   var split = expression.split(pattern);
  //   print(split);
  //   print(expression);
  //
  // }
}
