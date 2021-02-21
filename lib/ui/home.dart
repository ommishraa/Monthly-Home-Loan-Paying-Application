import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MonthPayment extends StatefulWidget {
  @override
  _MortgageAppState createState() => _MortgageAppState();
}

class _MortgageAppState extends State<MonthPayment> {
  double _interest = 0.0;
  int _lengthOfLoan = 0;
  double _homePrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        title: Text(
          "M-O-N-C-A-L",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                height: 150,
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Monthly Payment",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      " ${(_homePrice > 0 && _interest > 0.0) ? "\$${calculateMonthlyPayment(_homePrice, _interest, _lengthOfLoan)}" : ""}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.blueGrey,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.home),
                        prefixText: "Home Price : ",
                        prefixStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      onChanged: (String value) {
                        try {
                          _homePrice = double.parse(value);
                        } catch (exception) {
                          _homePrice = 0.0;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Length of Loan (years)",
                          style: TextStyle(
//                                fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (_lengthOfLoan > 5) {
                                    _lengthOfLoan -= 5;
                                  } else {
                                    // do nothing
                                  }
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.blueGrey,
                                    )),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "$_lengthOfLoan",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _lengthOfLoan += 5;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Interest",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "${_interest.toStringAsFixed(2)} %",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: <Widget>[
                        Slider(
                            min: 0.0,
                            max: 10.0,
                            activeColor: Colors.black,
                            inactiveColor: Colors.blueGrey,
                            // divisions: 10,
                            value: _interest,
                            onChanged: (double newValue) {
                              setState(() {
                                _interest = newValue;
                              });
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Monthly Payment Formula
/*
   n = number of payments
   c = monthly interest rate

   int n = 12 * years;
   double c = rate / 12.0 / 100.0;
   double payment = loan * c * Math.pow(1 + c, n) /
                    (Math.pow(1 + c, n) - 1);
   */
  calculateMonthlyPayment(double homePrice, double interest, int loanLength) {
    int n = 12 * loanLength;
    double c = interest / 12.0 / 100.0;
    double monthlyPayment = 0.0;

    if (homePrice < 0 || homePrice.toString().isEmpty || homePrice == null) {
      //no go!
      // _homePrice = 0.0;
    } else {
      monthlyPayment = homePrice * c * pow(1 + c, n) / (pow(1 + c, n) - 1);
    }

    return monthlyPayment.toStringAsFixed(2);
  }
}
