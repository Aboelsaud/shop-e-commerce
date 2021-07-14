import 'package:web_commerce/services/shoppingCartColumn.dart';

import '../libraries.dart';

class Cart extends StatefulWidget {
  int itemCount;
  Cart(this.itemCount);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool isBigScreen = false;
  bool isBigScreenMid = false;
  Size screenSize;
  String searchTxt = '';
  double totalPrice = 0.0;
  final db = FirebaseFirestore.instance;

  void calTotal(Stream<QuerySnapshot> item) async {
    double sum = 0.0;
    await db.collection('cart').get().then(
        (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
              sum += doc['price'];
            }));
    setState(() {
      totalPrice = sum;
    });
  }

  void search(String text) {
    setState(() {
      searchTxt = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      screenSize = MediaQuery.of(context).size;
      isBigScreen = (screenSize.width >= 750);
      isBigScreenMid = (screenSize.width >= 1100);
    });
    // firebase >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Stream<QuerySnapshot> item = db.collection('cart').snapshots();
    calTotal(item);

    // end firebase >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    var appBar = Appbar(widget.itemCount, search);
    var head = Head();

    var subHead = Row(
      children: [
        Text("Product", style: Theme.of(context).textTheme.headline4),
        Expanded(child: SizedBox()),
        Text("Price", style: Theme.of(context).textTheme.headline4),
        SizedBox(width: 100),
        Text("Quantity", style: Theme.of(context).textTheme.headline4),
        SizedBox(width: 100),
        Text("Total", style: Theme.of(context).textTheme.headline4),
        SizedBox(width: 20),
      ],
    );
    var drawer = Drawerr();

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: (isBigScreen) ? null : Drawer(child: drawer),
      body: Padding(
        padding: isBigScreen
            ? EdgeInsets.only(top: 40, left: 40, right: 40)
            : EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            appBar,
            Divider(thickness: 0.1),
            (isBigScreen) ? SizedBox(height: 30) : SizedBox(height: 15),
            head,
            Expanded(
              child: (isBigScreenMid)
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        drawer,
                        Expanded(
                          child: Material(
                            clipBehavior: Clip.antiAlias,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  subHead,
                                  SizedBox(height: 30),
                                  StreamBuilder(
                                      stream: item,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (!snapshot.hasData)
                                          return const Text('Loading...');
                                        return Column(
                                          children: snapshot.data.docs
                                              .map((DocumentSnapshot document) {
                                            return ShoppingCart(
                                              document.data()['title'],
                                              document.data()['price'],
                                              document.id,
                                              document.data()['color'],
                                              document.data()['size'],
                                              document.data()['image'],
                                            );
                                          }).toList(),
                                        );
                                      }),
                                  Total(totalPrice),
                                ],
                              ),
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : (isBigScreen)
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            drawer,
                            Expanded(
                              child: Material(
                                clipBehavior: Clip.antiAlias,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      StreamBuilder(
                                          stream: item,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (!snapshot.hasData)
                                              return const Text('Loading...');
                                            return Column(
                                              children: snapshot.data.docs.map(
                                                  (DocumentSnapshot document) {
                                                return ShoppingCartColumn(
                                                  document.data()['title'],
                                                  document.data()['price'],
                                                  document.id,
                                                  document.data()['color'],
                                                  document.data()['size'],
                                                  document.data()['image'],
                                                );
                                              }).toList(),
                                            );
                                          }),
                                      TotalColumn(totalPrice),
                                    ],
                                  ),
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : Material(
                          clipBehavior: Clip.antiAlias,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                StreamBuilder(
                                    stream: item,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData)
                                        return const Text('Loading...');
                                      return Column(
                                        children: snapshot.data.docs
                                            .map((DocumentSnapshot document) {
                                          return ShoppingCartColumn(
                                            document.data()['title'],
                                            document.data()['price'],
                                            document.id,
                                            document.data()['color'],
                                            document.data()['size'],
                                            document.data()['image'],
                                          );
                                        }).toList(),
                                      );
                                    }),
                                TotalColumn(totalPrice),
                              ],
                            ),
                          ),
                          color: Colors.white,
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
