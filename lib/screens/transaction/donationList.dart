import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as dateRange;
import 'package:sahayogihaath/components/AppBars/appBar.dart';

import '../../screens/dashboard/header.dart';
import 'donationListmain.dart';
import '../../components/transaction_components/search_bar.dart';
import '../../theme/extention.dart';
import '../../provider/user_provider.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

DateTime current = DateTime.now();
DateTime selecteddate;
DateTime endDate;
String holder;

class _UserTransactionState extends State<UserTransaction> {
  DateTime getStartDate(DateTime date) {
    selecteddate = date;
    return selecteddate;
  }

  DateTime getEndDate(DateTime dateTime) {
    if (dateTime != null) {
      endDate =
          DateTime(dateTime.year, dateTime.month, dateTime.day, 24, 59, 59);
    }
    return endDate;
  }

  String getCurrentData(String orgId) {
    holder = orgId;
    return holder;
  }

  Future selectdateRange(BuildContext context) async {
    selecteddate = DateTime(current.year, current.month, current.day)
        .subtract(Duration(days: 7));
    endDate = DateTime(current.year, current.month, current.day);
    final List<DateTime> pickedDateRange = await dateRange.showDatePicker(
        context: context,
        initialFirstDate: selecteddate,
        initialLastDate: selecteddate != null ? endDate : DateTime.now(),
        firstDate: DateTime(2009),
        lastDate: DateTime.now());
    if (pickedDateRange != null && pickedDateRange.length == 2) {
      setState(() {
        selecteddate = pickedDateRange[0];
        endDate = pickedDateRange[1];
        getEndDate(endDate);
      });
    }
  }

  Future<dynamic> selectdate(BuildContext context) async {
    DateTime selectedDate = DateTime(
        current.year, current.month, current.day, current.hour, current.minute);
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2009),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        getStartDate(selectedDate);
        getEndDate(selecteddate);
      });
    }
  }

  getSorted(String selectedValue) {
    if (selectedValue == 'Date') {
      selectdate(context);
    } else if (selectedValue == 'Range') {
      selectdateRange(context);
    }
  }

  List<String> sortByData = ['Date', 'Range'];
  String selectedValue;
  String orgId;
  DropdownButton sortByDate() {
    List<DropdownMenuItem> sortList = [];
    for (var data in sortByData) {
      String by = data;
      var sort = DropdownMenuItem(
        child: Text(by),
        value: by,
      );
      sortList.add(sort);
    }
    return DropdownButton(
      hint: Text('Select'),
      value: selectedValue,
      isExpanded: false,
      underline: SizedBox(),
      items: sortList,
      style: TextStyle(fontSize: 18, color: Colors.black),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
          getSorted(selectedValue);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    MediaQueryData queryData = MediaQuery.of(context);
    double width = queryData.size.width * 0.02;
    return SafeArea(
      child: Scaffold(
        appBar: GlobalAppBar(),
        body: Padding(
          padding: EdgeInsets.all(width),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xffEFEFEF),
                      borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Search Transactions",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 19,
                        ),
                      )
                    ],
                  ),
                ).vP8,
                // SearchBar(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                if (user.isDonor) _user(),
                if (user.isAdmin) _admin(),
                if (user.isOrganization) _organization(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _user() {
    MediaQueryData queryData = MediaQuery.of(context);
    final user = Provider.of<UserProvider>(context);
    String userid = user.id;
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Sort by:'),
                  SizedBox(
                    width: queryData.size.width * 0.05,
                  ),
                  Container(
                    width: queryData.size.width * 0.35,
                    alignment: Alignment.center,
                    height: queryData.size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        width: 1,
                        color: Color(0xFFA6AAB4),
                      ),
                      color: Color(0x22A6AAB4),
                    ),
                    child: Center(
                      child: sortByDate(),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.clear,
              ),
              onPressed: () {
                setState(() {
                  selecteddate = null;
                  endDate = null;
                });
              },
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        UserTransactionMain(
          userid: userid,
          selectedDate: selecteddate,
          endDate: endDate,
        ),
      ],
    );
  }

  Widget _organization() {
    MediaQueryData queryData = MediaQuery.of(context);
    final user = Provider.of<UserProvider>(context);
    String org = user.id;
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Sort by:'),
                  SizedBox(
                    width: queryData.size.width * 0.05,
                  ),
                  Container(
                    width: queryData.size.width * 0.35,
                    alignment: Alignment.center,
                    height: queryData.size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        width: 1,
                        color: Color(0xFFA6AAB4),
                      ),
                      color: Color(0x22A6AAB4),
                    ),
                    child: Center(
                      child: sortByDate(),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.clear,
              ),
              onPressed: () {
                setState(() {
                  selecteddate = null;
                  endDate = null;
                });
              },
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        OrgTransaction(
          id: org,
          startDate: selecteddate,
          endDate: endDate,
        ),
      ],
    );
  }

  Widget _admin() {
    MediaQueryData queryData = MediaQuery.of(context);
    return Column(
      children: <Widget>[
        Row(
          children: [
            Flexible(
              child: Center(
                child: Container(
                  width: queryData.size.width * 0.5,
                  alignment: Alignment.center,
                  height: queryData.size.height * 0.07,
                  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      width: 1,
                      color: Color(0xFFA6AAB4),
                    ),
                    color: Color(0x22A6AAB4),
                  ),
                  child: Center(
                    child: _getOrgName(),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.clear,
              ),
              onPressed: () {
                setState(() {
                  holder = null;
                });
              },
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        Header(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        AdminTransactionMain(
          id: holder,
        )
      ],
    );
  }

  Widget _getOrgName() {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('users')
            .where('isOrganization', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return Text('Loading');
          }
          return DropdownButton(
            value: orgId,
            hint: Text('View Transaction'),
            isExpanded: false,
            underline: SizedBox(),
            items: snapshot.data.documents.map((DocumentSnapshot document) {
              return DropdownMenuItem(
                value: document.data['id'],
                child: FittedBox(
                  child: Container(
                    child: FittedBox(
                      child: Text(
                        document.data['name'],
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                orgId = value;
                getCurrentData(orgId);
              });
            },
            style: TextStyle(fontSize: 14, color: Colors.black),
          );
        });
  }
}
