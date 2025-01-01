import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AShimmerEffect extends StatelessWidget {

const AShimmerEffect({

Key? key,

required this.width, required this.height, this, radius = 15, this.color,

): super(key: key);

final double width, height, radius;


final Color? color;

@override

Widget build (BuildContext context) {

final darkMode = AHelperFunctions.isDarkMode(context);

return Shimmer.fromColors(

baseColor: darkMode? Colors.grey[850]!: Colors.grey[300]!,

highlightColor: darkMode? Colors.grey[700]!: Colors.grey[100]!,

child: Container(

width: width,

height: height,

decoration: Boxdecoration(

color: color?? (darkMode AColors.darkerGrey: AColors.white),

borderRadius: BorderRodius.circuler(radius),

),
),
);
}
}
