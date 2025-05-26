import 'package:flutter/material.dart';
import 'package:flutterapp/Common/constants.dart';

class ElevButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;
  final Color? color;
  final Color? textColor;

  const ElevButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.icon,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? APP_COLOR,
        foregroundColor: textColor ?? Colors.white, // ← основной цвет текста и иконки
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () => onPressed(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 10.0),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.white, // ← явно цвет текста
            ),
          ),
        ],
      ),
    );
  }
}
