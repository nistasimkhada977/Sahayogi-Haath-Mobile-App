// import 'package:flutter/material.dart';
// import '../../constants.dart';

// class SearchBar extends StatefulWidget {
//   @override
//   _SearchBarState createState() => _SearchBarState();
// }

// class _SearchBarState extends State<SearchBar> {
//     String donor = "";
//   @override
//   Widget build(BuildContext context) {
//      MediaQueryData queryData;
//     queryData = MediaQuery.of(context);
//     double width = queryData.size.width*0.02;
//     double height =  queryData.size.height*0.007;
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: height, horizontal: width),
//       height: MediaQuery.of(context).size.height*0.09,
//       width:MediaQuery.of(context).size.width*0.95,
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             flex:4,
//             child: SearchTextField(
//               onchange: (value){
//                 donor = value;
//               },
//             ),
//           ),
//           SearchButton(
//             onPress: (value){
//               setState(() {
//                 Text(value);
//               });
//               print(value);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SearchTextField extends StatelessWidget {
//   final Function onchange;
//   SearchTextField({this.onchange});

//   var queryResultSet = [];

//   var tempSearchStore = [];

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//         textAlign: TextAlign.start,
//         style: TextStyle(
//       fontSize: 20,
//         ),
//         decoration:  InputDecoration(
//     hintText:'Search transaction',
//     hintStyle: TextStyle(
//       fontSize: 20.0,
//       color: Colors.grey,
//     ),
//     fillColor: Color(0x22A6AAB4),
//     filled: true,
//     border: OutlineInputBorder(
//       borderRadius: kLeftBorderRadius,
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: kLeftBorderRadius,
//       borderSide: BorderSide(
//         color: Color(0x00A6AAB4),
//       )
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: kLeftBorderRadius,
//       borderSide: BorderSide(
//         color: Color(0x00A6AAB4),
//       )
//     )
//         ),
//         onChanged: onchange,
//       );
//   }
// }
// //searchButton
// class SearchButton extends StatelessWidget {
//   final Function onPress;
//   SearchButton({this.onPress});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       height: MediaQuery.of(context).size.height*0.09,
//       shape: RoundedRectangleBorder(
//         borderRadius: kRightBorderRadius,
//       ),
//       disabledColor: Color(0x22A6AAB4),
//       onPressed: null,
//       child: Icon(
//         Icons.search,
//       ),
//     );
//   }
// }
