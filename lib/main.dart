
import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'History.dart';

import 'Calculator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('nitin');
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
      home: const MyHomePage(title:'Nitin'),
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
  var openB=0;
  bool showCursor = true;
  final ScrollController _scrollController = ScrollController();

  late Timer _timer;
  var closeB=0;
  int points =0;
  String expression = '';
  var no1Controller = TextEditingController();
  var no2Controller = TextEditingController();
  var resultController = TextEditingController();


  int precedence(String op) {
    if (op == "*" || op == "/") return 2;
    if (op == "+" || op == "-") return 1;
    return 0;
  }

bool isOperators(String ch){
  return ch=="+" || ch=="-" || ch=="*" || ch=="/";
}

String isOperatorsstr(String ch){
    String a = "";
    if(ch=="*" || ch=="/"){
      a=ch;
    }
    return a;
}
  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        showCursor = !showCursor;
      });
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    var numArray = ["C","(",")","CLR",7,8,9,"/",4,5,6,"*",1,2,3,"-",0,".","=","+",];




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
                height: 260,
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
                      // child: TextField(
                      //   controller: no2Controller,
                      //   readOnly: true,
                      //   maxLines: 1,
                      //   enableInteractiveSelection: true,
                      //   scrollPhysics: const BouncingScrollPhysics(),
                      //   scrollController: ScrollController(),
                      //   textAlign: TextAlign.right,
                      //   style: const TextStyle(
                      //     fontSize: 32,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.white,
                      //   ),
                      //   decoration: const InputDecoration(
                      //     border: InputBorder.none,
                      //     contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      //   ),
                      // )
                        child: TextField(
                          controller: no2Controller,
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
                        ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(22.0),
                    //   child: SingleChildScrollView(
                    //     controller: _scrollController,
                    //     scrollDirection: Axis.horizontal,
                    //     reverse: true,   // IMPORTANT
                    //     child: Text(
                    //       expression,
                    //       textAlign: TextAlign.right,
                    //       style: const TextStyle(
                    //         fontSize: 42,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              ElevatedButton(onPressed: ()  async{
                Navigator.push(context,MaterialPageRoute(builder: (context)=>History()));

              }, child: Icon(Icons.add)),
              Expanded(
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: numArray.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio: 1,crossAxisSpacing: 12,mainAxisSpacing: 12), itemBuilder: (context,index){
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
                              // no2Controller.text = expression;
                              // print(no2Controller.text);
                              setState(() {
                                // print(no2Controller.text);
                                if (numArray[index] == 'C') {
                                  expression = '';
                                  no1Controller.clear();
                                  no2Controller.clear();
                                }
                                else if(numArray[index] == "CLR"){
                                  String currentText = no2Controller.text;
                                  // print(currentText);
                                  if(currentText.isNotEmpty){
                                    currentText=currentText.substring(0,currentText.length-1);
                                  }

                                  expression=currentText.toString();
                                  no2Controller.text = expression;

                                }
                                else if (numArray[index] == '=') {
                                  // String m = Calculator.Calculation(expression);
                                  Calculator ca = Calculator();

                                  // if(closeB>openB){
                                  //   while(closeB>openB && expression.endsWith(")")){
                                  //     expression = expression.substring(0,expression.length-1);
                                  //     closeB--;
                                  //   }
                                  // }
                                  // print(openB);
                                  // print(closeB);

                                    while(openB>closeB){
                                      expression+=")";
                                      closeB++;
                                    }

                                  holderClass hm = holderClass();
                                  List<String> ak = hm.splitter(expression);
                                  var objak = ak.join(" ");
                                  print(objak);
                                  var box = Hive.box('Nitin');
                                  // box.add({
                                  //   'value' : objak
                                  // });
                                  bool isDuplicate = true;
                                  for (int i = 0; i < box.length; i++) {
                                    isDuplicate = true;
                                    var data = box.getAt(i);
                                    if(data['value']==objak){
                                      isDuplicate=false;
                                    }


                                  }
                                  if(isDuplicate){
                                    box.add({
                                      'value' : objak
                                    });
                                  }

                                  String a = ca.Calculation(expression);
                                  // print(a.toString());




                                  no1Controller.text = a.toString();
                                  // box.put({
                                  //
                                  // })

                                  points=0;
                                  openB=0;
                                  closeB=0;
                                }
                                // else if (numArray[index] == '+') {
                                //   expression += '+';
                                // }
                                // else if (numArray[index] == '-') {
                                //   expression += '-';
                                // }
                                // else if (numArray[index] == 'x') {
                                //   expression += '*';
                                // }
                                // else if (numArray[index] == "/") {
                                //   expression += '/';
                                //   print(numArray[index].toString());
                                // }
                                else if(isOperators(numArray[index].toString())){
                                  if(numArray[index]=='-' && expression.isEmpty){
                                      expression+=numArray[index].toString();
                                      no2Controller.text = expression;
                                      return;
                                  }
                                  if(expression.isEmpty){
                                    return;
                                  }
                                  String prevChar = expression[expression.length-1];
                                  String currentChar = numArray[index].toString();

                                  if(isOperators(currentChar) && prevChar=="("){
                                    return;
                                  }


                                  // print(prevChar);
                                  if(isOperators(prevChar) && isOperators(currentChar) && currentChar!='-'){
                                    return;
                                  }
                                  // if(isOperators(prevChar) && (prevChar!="*" && prevChar=="-" && prevChar=="+")){
                                  //   return;
                                  // }
                                  // if(isOperators(prevChar) && (prevChar!="*" && prevChar=="/" && currentChar=="/")){
                                  //   return;
                                  // }
                                  //
                                  // if(isOperators(prevChar) && (prevChar!="/" && prevChar=="*" && currentChar=="/")){
                                  //   return;
                                  // }
                                  // if(isOperators(prevChar) && (prevChar!="*" && prevChar=="/" && currentChar=="*")){
                                  //   return;
                                  // }
                                  expression+=numArray[index].toString();
                                  points=0;
                                }
                                else if(numArray[index] =="(") {
                                    setState(() {
                                      openB++;
                                      expression += numArray[index].toString();
                                      // print(openB);
                                    });
                                    points=0;

                                  // if(closeB>openB){
                                  //   return;
                                  // }
                                  //
                                  // // print(openB);
                                  // setState(() {
                                  //   openB++;
                                  //   closeB++;
                                  // });
                                  // print(openB);

                                }
                                else if(numArray[index]==")"){
                                  if(closeB<openB){
                                    setState(() {
                                      closeB++;
                                      expression += numArray[index].toString();
                                      // print(closeB);
                                    });
                                  }
                                  else{
                                    return;
                                  }
                                }
                                else if(numArray[index]=="."){
                                  setState(() {

                                    if(expression.isEmpty){
                                      expression+="0.";
                                      points=1;
                                    }
                                    if(points==0) {
                                      expression += ".";
                                      points++;
                                    }
                                    // }
                                    // else{
                                    //   return;
                                    // }


                                  });

                                }

                                else{
                                  expression+=numArray[index].toString();
                                }
                                // IndianDigit a = IndianDigit();
                                // no2Controller.text = a.indianVal(expression);
                                no2Controller.text = expression;
                                // setState(() {
                                //
                                // });
                              }
                              );}


                                // else if(isOperators(numArray[index].toString())){
                                //     String op = numArray[index].toString();
                                //
                                //     if(expression.isEmpty){
                                //       return;
                                //     }
                                //
                                //     String lastChar = expression[expression.length-1];
                                //
                                //     if(isOperators(lastChar)){
                                //       return;
                                //     }
                                //
                                // }
                            ,
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
