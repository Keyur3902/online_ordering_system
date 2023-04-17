import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                          filled: true,
                          fillColor: Color(0xffF0F0F1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search Products',
                          hintStyle: TextStyle(
                            fontFamily: 'NotoSans',
                          ),
                          prefixIcon: Icon(Icons.search_rounded),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(
                        Icons.circle_notifications_rounded,
                        size: 40,
                        color: Color(0xff14245B),
                      ),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        ),
    );
  }
}