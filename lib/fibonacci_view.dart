import 'package:flutter/material.dart';

class FibonacciView extends StatefulWidget {
  const FibonacciView({Key? key}) : super(key: key);

  @override
  State<FibonacciView> createState() => _FibonacciViewState();
}

class _FibonacciViewState extends State<FibonacciView> {
  late TextEditingController textEditingController;
  String fibonacciNo = '-';

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Please enter int value',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 10, 15),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                controller: textEditingController,
              ),

              const SizedBox(
                height: 20,
              ),

              GestureDetector(
                onTap: () {
                  setState(() {
                    fibonacciNo = getFabonacciValueAt(
                            int.parse(textEditingController.text.trim()))
                        .toString();
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      'Get Fibonacci Number',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Center(
                child: Text(
                  'Fibonacci Number is $fibonacciNo',
                  style: const TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static BigInt getFabonacciValueAt(int n) {
    BigInt a = BigInt.parse(0.toString());
    BigInt b = BigInt.parse(1.toString());
    BigInt c = BigInt.parse(1.toString());
    for (int j = 2; j <= n; j++) {
      c = a + b;
      a = b;
      b = c;
    }
    print(b.toString() + '===========================');
    return b;
  }
}
