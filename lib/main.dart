
import 'package:flutter/material.dart';

import 'Calculator.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Nitin'),
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
    var numArray = ["C","(",")","CLR",7,8,9,"/",4,5,6,"x",1,2,3,"-",0,".","=","+"];


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: no1Controller,
                        readOnly: true,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        ),
                      )
                      ,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: TextField(
                        controller: no2Controller,
                        readOnly: true,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        ),
                      )
                      ,
                    ),
                  ],
                ),
              ),

              Expanded(
                child: GridView.builder(itemCount: numArray.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio: 1,crossAxisSpacing: 12,mainAxisSpacing: 12), itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:ClipOval(
                        child: Material(
                          color: Colors.blue,
                          shape: const CircleBorder(),
                          child: InkWell(
                            splashColor: Colors.green,
                            customBorder: CircleBorder(),
                            onTap: (){
                              no2Controller.text = expression;
                              setState(() {
                                if(numArray[index]=='C'){
                                  expression = '';
                                  no1Controller.clear();
                                  no2Controller.clear();
                                } else if(numArray[index]=='='){
                                  // String m = Calculator.Calculation(expression);
                                  Calculator ca = Calculator();
                                  String a = ca.Calculation(expression);
                                  print(a.toString());
                                  no1Controller.text = a.toString();
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
                            },
                            child: Center(
                              child: Text(
                                numArray[index].toString(),
                                style: const TextStyle(
                                  color: Colors.white,   // IMPORTANT
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),)
                    )
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
