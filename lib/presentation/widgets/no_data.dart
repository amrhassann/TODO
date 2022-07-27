import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoData extends StatelessWidget {
  const NoData({
    Key? key,
    required this.title
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Lottie.asset('assets/json/nodata.json',repeat: true),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[400],
            ),
          )
        ],
      ),
    );
  }
}
