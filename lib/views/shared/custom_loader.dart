import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final String? message;

  const CustomLoader({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          if (message != null) ...[
            SizedBox(height: 10),
            Text(message!, style: TextStyle(fontSize: 16)),
          ],
        ],
      ),
    );
  }
}
