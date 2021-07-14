import './libraries.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              bodyText2: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 17,
              ),
              headline1: TextStyle(
                fontSize: 16,
                color: Colors.black.withOpacity(0.8),
              ),
              headline2: TextStyle(
                fontSize: 12,
                color: Colors.black.withOpacity(0.8),
              ),
              headline3: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 15,
              ),
              headline4: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.9)),
            ),
      ),
      title: 'Web_ecommerce',
      home: Home(),
    );
  }
}
