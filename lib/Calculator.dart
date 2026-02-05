
import 'dart:math';
class Calculator {
  String Calculation(String expression) {
    String prefinal = "";

    List<String> stack = [];
    String digits = "";

    List<String> splitted = splitter(expression);
    print(splitted);
    List<String> postFix = [];
    int precedence(String op){
      if(op == "*" || op == "/") return 2;
      if(op == "+" || op == "-") return 1;
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
        // print(splitted[i]);
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
    bool isOperator(String s){
      return s=="+" || s=="-" || s=="*" || s=="/";
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

        if (i >= 2 && !(isOperator(postFix[i-1]) && !(isOperator(postFix[i-2]))) ) {
          // print(postFix[i-1]);
          double? a = calculation(postFix[i - 2], postFix[i - 1], postFix[i]);
          postFix.removeAt(i);
          postFix.removeAt(i - 1);
          postFix.removeAt(i - 2);
          postFix.insert(i - 2, a.toString());
          i = -1;
        }
      }
    }
    // print(postFix);
    // print(postFix.length);
    String last = double.parse(postFix[0]).toStringAsFixed(2);
    prefinal = last;
    // print(double.parse(postFix[0]).toStringAsFixed(2));
    // print(last);
    int count = 0;
    for(int i=0;i<last.length;i++){
      if(last[i]=="."){
        break;
      }
      count++;

    }
// print(count);

    if(count>3){
      String number = "";
      String decimals = "";
      for(int i=0;i<last.length;i++){
        if(last[i]=="."){
          number = last.substring(0,i);
          decimals=last.substring(i);
          break;
        }
      }
      // print(number);
      // print(decimals);

      // print(number.length);

      if(number.length>3){
        String formatted = "";
        String remaining = number.substring(0,number.length-3);
        formatted = number.substring(number.length-3);
        // print(remaining);
        // print(formatted);

        int k = number.length-4;
        int count = 0;
        List<String> emptyNumbers = <String>[];
        for(int i=remaining.length-1;i>=0;i--){
          count++;
          if(count==2){

            emptyNumbers.insert(0,remaining[i+1]);
            emptyNumbers.insert(0,remaining[i]);
            if(i>0){
              emptyNumbers.insert(0, ",");
            }

            count=0;
          }


        }
        if (count == 1) {
          emptyNumbers.insert(0, remaining[0]);
        }

        // print(emptyNumbers);

        String grouped  = emptyNumbers.join();
        // print(grouped);

        prefinal = grouped + "," + formatted;



        prefinal = prefinal + decimals;

        // print(prefinal);
        // while(k!=0){
        //   count++;
        //   if(count==2){
        //
        //   }
        // }
      }

    }


    // if(double.tryParse(postFix[0])==null){
    //   // print("Cleared");
    //   return "Error";
    // }

    // print(prefinal);
    return prefinal;
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
          // print(digits);
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
      int j = 0;
      if(digits.startsWith("+")|| digits.startsWith("-")){
        int minusCount = 0;

        while(j<digits.length && (digits[j]=="-")){
          minusCount++;
          j++;
        }
        // print(minusCount);


        String numberPart = digits.substring(j);
        if(minusCount%2!=0){
          splitted.add("-"+numberPart);
        }
        else{
          splitted.add(numberPart);
        }
        // for(int i=0;i<expression.length;i++){
        //   if(expression[i]!="+" && expression[i]!="-" && expression[i] != "*" && expression[i] != "/"){
        //     splitted.add(expression[i]);
        //   }
        // }
      }

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
// Calculation("--+3");
    Calculation("(4+8724353-(2+1))");
  }


}

