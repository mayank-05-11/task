import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/app_color.dart';

class CustomButton extends StatelessWidget {
  final MaterialStateProperty<Color?>? backgroundColor;
  final MaterialStateProperty<Color?>? foregroundColor;
  final MaterialStateProperty<BorderSide?>? side;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  final String buttonText;
  final Color? textColor;
  final bool isLoading;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double radius;
  final Color? loaderColor;
   const CustomButton(
      {Key? key,
        this.backgroundColor,
        this.onPressed,
        this.height = 44.65,
        this.isLoading = false,
        this.width,
        required this.buttonText,
        this.textColor = AppColor.darkGrey, this.foregroundColor,
        this.fontWeight = FontWeight.normal, this.fontSize = 16,
        this.radius = 15, this.side, this.loaderColor = AppColor.darkGrey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        side: side,
        elevation: MaterialStateProperty.all<double?>(0),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius),)),
      ),
      onPressed: !isLoading ? onPressed : null,
      child: Container(
        height: height,
        width: width,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: isLoading
              ? CupertinoActivityIndicator(radius: 15, color: loaderColor,
            // color: !bgReverse ? Colors.white : color
          )
              : Text(
            buttonText,
            style: TextStyle(
                fontWeight: fontWeight,
                color: textColor,
                fontSize: fontSize,),
          ),
        ),
      ),
    );
  }
}
