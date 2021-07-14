import '../libraries.dart';

class Head extends StatefulWidget {
  @override
  _HeadState createState() => _HeadState();
}

class _HeadState extends State<Head> {
  bool isBigScreen = false;
  Size screenSize;
  @override
  Widget build(BuildContext context) {
    setState(() {
      screenSize = MediaQuery.of(context).size;
      isBigScreen = (screenSize.width >= 750);
    });
    return Padding(
      padding: isBigScreen
          ? EdgeInsets.only(bottom: 30)
          : EdgeInsets.only(bottom: 20),
      child: Text(
        "Simple.",
        style: TextStyle(
          fontSize: isBigScreen ? 37 : 30,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }
}
