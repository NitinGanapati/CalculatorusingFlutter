import 'dart:ffi';
import 'dart:math';

String Calculation(String expression) {

  List<String> stack = [];
  String digits = "";

  List<String> splitted = splitter(expression);
  List<String> postFix = [];
  int precedence(String op){
    if(op == "*" || op == "/") return 1;
    if(op == "+" || op == "-") return 2;
    return 0;
  }
  // print(postFix);
  for(int i=0;i<splitted.length;i++){
    if(splitted[i]!='+' && splitted[i]!='-' && splitted[i]!='*' && splitted[i]!='/' && splitted[i]!='(' && splitted[i]!=')'){
      postFix.add(splitted[i]);
    }
    else if(splitted[i]=='('){
      stack.add(splitted[i]);
    }
    // else if(splitted[i]=="*" || splitted[i]=="/" || splitted[i]=="+" || splitted[i]=="-"){
    //   if (stack.isEmpty) {
    //     stack.add(splitted[i]);
    //     continue;
    //   }
    //
    //   if (stack.last == "(") {
    //     stack.add(splitted[i]);
    //     continue;
    //   }
    //   if(splitted[i]=="*" || splitted[i]=="/"){
    //     if(stack.isNotEmpty && (stack.last=="*" || stack.last=="/")) {
    //       postFix.add(stack.last);
    //       stack.removeLast();
    //       stack.add(splitted[i]);
    //     }
    //     else if(stack.last=="+" || stack.last=="-"){
    //       stack.add(splitted[i]);
    //     }
    //   }
    //   else if(splitted[i]=="+" || splitted[i]=="-"){
    //     if(stack.last=="*" || stack.last=="/"){
    //       postFix.add(stack.last);
    //       stack.removeLast();
    //       stack.add(splitted[i]);
    //     }
    //     else{
    //       postFix.add(stack.last);
    //       stack.removeLast();
    //       // print(splitted[i]);
    //       stack.add(splitted[i]);
    //     }
    //   }
    //   // else if(stack.last=="("){
    //   //     stack.add(splitted[i]);
    //   // }
    // }

    else if(splitted[i]=="*" || splitted[i]=="/" || splitted[i]=="+" || splitted[i]=="-"){
      while(stack.isNotEmpty && stack.last!="(" && precedence(stack.last)>= precedence(splitted[i])){
        postFix.add(stack.last);
        stack.removeLast();

      }
      stack.add(splitted[i]);

    }

    else if(splitted[i]==')'){
      print(splitted[i]);
      while(stack.isNotEmpty && stack.last!='('){
        postFix.add(stack.removeLast());

      }
      if (stack.isNotEmpty && stack.last == '(') {
        stack.removeLast();
      }
      // if(stack.isEmpty) {
      //   // print("error");
      //   continue
      // }
      // stack.removeLast();

    }

  }
  bool m = stack.isNotEmpty;
  while (stack.isNotEmpty) {
    postFix.add(stack.removeLast());
  }

  print(postFix);

  for(int i=0;i<postFix.length;i++){
    if(postFix[i]=="+" || postFix[i]=="-" || postFix[i]=="*" || postFix[i]=="/") {
      // if(i>=2){
      //   double? a = calculation(postFix[i-2], postFix[i-1], postFix[i]);
      //   postFix.removeAt(i);
      //   postFix.removeAt(i-1);
      //   postFix.removeAt(i-2);
      //   postFix.insert(i-2, a.toString());
      //   i=0;
      // }
      if (i >= 2) {
        double? a = calculation(postFix[i - 2], postFix[i - 1], postFix[i]);
        postFix.removeAt(i);
        postFix.removeAt(i - 1);
        postFix.removeAt(i - 2);
        postFix.insert(i - 2, a.toString());
        i = -1;
      }
    }
  }
  print(postFix);
  print(double.parse(postFix[0]).toStringAsFixed(2));

  if(double.tryParse(postFix[0])==null){
    print("Cleared");
    return "Error";
  }
  return (double.parse(postFix[0]).toStringAsFixed(1));
}

List<String> splitter(String expression){
List<String> splitted = [];
String digits = "";
for(int i=0;i<expression.length;i++){
if(expression[i]!='+' && expression[i]!='-' && expression[i]!='*' && expression[i]!='/' && expression[i]!='=' && expression[i]!='(' && expression[i]!=')'){
digits += expression[i];
}
else{
  if((expression[i]=="+" || expression[i]=="-") && (i==0 ||
  expression[i-1]=="("|| expression[i-1] == '+' || expression[i-1] == '-' || expression[i-1] == '*' || expression[i-1] == '/' || expression[i-1]=="=")){
    if(i+1 < expression.length && expression[i+1]=='('){
      splitted.add("0");
      splitted.add(expression[i]);
      continue;

    }
    digits+=expression[i];
    continue;
  }


// if(digits.isNotEmpty){
// splitted.add(digits);
// }
if (digits.trim().isNotEmpty) {
    splitted.add(digits);
  }
digits = '';
digits += expression[i];
splitted.add(expression[i]);
digits ='';
}
}
if(digits.isNotEmpty){
splitted.add(digits);
}

return splitted;
}

double? calculation(String a,String b,String c) {
    if (c == "+") {
      return double.parse(a) + double.parse(b);
    }
    else if (c == "-") {
      return double.parse(a) - double.parse(b);
    }
    else if (c == "*") {
      return double.parse(a) * double.parse(b);
    }
    else if (c == "/") {
      return double.parse(a) / double.parse(b);
    }
    return null;
  }


void main(){
Calculation("3+4*2-1+5*6-2/1+7");
// Calculation("4+39-2");
}