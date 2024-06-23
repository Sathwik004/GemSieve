import 'package:flutter/material.dart';
import 'package:milkydiary/core/Utils/weekutil.dart';
import 'package:milkydiary/core/themes/apppallete.dart';

class MonthCards extends StatelessWidget {
  const MonthCards({Key? key, required this.num}) : super(key: key);

  final int num;



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: pagecolor,
            ),
      height: 98,
      width: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(Strings.weekname(num).substring(0,1)),
           const SizedBox(height: 2,),
           Text(num.toString())
        ],
      ),
    );
  }
}
