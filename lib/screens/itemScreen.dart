import '../libraries.dart';

class ItemScreen extends StatefulWidget {
  final String text;
  final double price;
  final int index;
  final String image;
  int itemCount;
  ItemScreen(this.text, this.price, this.index, this.image, this.itemCount);
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  bool isBigScreen = false;
  bool addedToCart = false;
  Size screenSize;
  String value1Choose = "Navy";
  String value2Choose = "Small";
  String searchTxt = '';

  void buyItNow() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Sorry!!"),
              content: new Text("Not Implemented yet!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  void addToCart() {
    if (addedToCart) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Cart(widget.itemCount)));
    } else {
      addToCart2(
          widget.text, widget.price, value1Choose, value2Choose, widget.image);
    }
  }

  Future<void> addToCart2(String title, double price, String value1Choose,
      String value2Choose, String image) async {
    await cart
        .add({
          'title': title,
          'size': value2Choose,
          'price': price,
          'color': value1Choose,
          'image': image
        })
        .then((value) => print("Item Added"))
        .catchError((error) => print("Failed to add item: $error"));
    ;
    setState(() {
      addedToCart = true;
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
    });
    var head = Head();

    var drawer = Drawerr();

    var image = Container(
      margin: EdgeInsets.only(top: 20),
      color: Colors.white,
      width: (isBigScreen)
          ? ((screenSize.width - 250) / 2) - 50
          : ((screenSize.width)) - 50,
      child: Image.network(
        widget.image,
        width: double.infinity,
        fit: BoxFit.fitHeight,
      ),
    );

    var dropDown1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Colour"),
        SizedBox(height: 7),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            color: Colors.grey[200],
            child: DropdownButton(
              underline: SizedBox(),
              value: value1Choose,
              onChanged: (String val) {
                setState(() {
                  value1Choose = val;
                });
              },
              items: [
                DropdownMenuItem(
                    child: Text("Navy", style: TextStyle(color: Colors.black)),
                    value: "Navy"),
                DropdownMenuItem(
                    child: Text("Red", style: TextStyle(color: Colors.black)),
                    value: "Red"),
                DropdownMenuItem(
                    child: Text("Blue", style: TextStyle(color: Colors.black)),
                    value: "Blue"),
              ],
            ),
          ),
        ),
      ],
    );

    var dropDown2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Size"),
        SizedBox(height: 7),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            color: Colors.grey[200],
            child: DropdownButton(
              underline: SizedBox(),
              value: value2Choose,
              onChanged: (String val) {
                setState(() {
                  value2Choose = val;
                });
              },
              items: [
                DropdownMenuItem(
                    child: Text("Small", style: TextStyle(color: Colors.black)),
                    value: "Small"),
                DropdownMenuItem(
                    child:
                        Text("Medium", style: TextStyle(color: Colors.black)),
                    value: "Medium"),
                DropdownMenuItem(
                    child: Text("Large", style: TextStyle(color: Colors.black)),
                    value: "Large"),
              ],
            ),
          ),
        ),
      ],
    );

    var information = Container(
      margin: isBigScreen ? EdgeInsets.only(top: 40) : EdgeInsets.only(top: 20),
      width: (isBigScreen)
          ? ((screenSize.width - 250) / 2) - 52
          : ((screenSize.width)) - 50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: TextStyle(
                fontSize: isBigScreen ? 25 : 20, fontWeight: FontWeight.bold),
          ),
          isBigScreen ? SizedBox(height: 15) : SizedBox(height: 5),
          Text(
            "\$${widget.price.toString()}",
            style: TextStyle(
                fontSize: isBigScreen ? 20 : 15, fontWeight: FontWeight.bold),
          ),
          isBigScreen ? SizedBox(height: 35) : SizedBox(height: 10),
          Row(
            children: [
              dropDown1,
              dropDown2,
            ],
          ),
          isBigScreen ? SizedBox(height: 40) : SizedBox(height: 7),
          InkWell(
            hoverColor: Colors.white,
            onTap: addToCart,
            child: Container(
              height: 40,
              width: isBigScreen
                  ? (((screenSize.width - 250) / 2) - 52) / 1.7
                  : double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.black.withOpacity(0.8),
                      style: BorderStyle.solid,
                      width: 2)),
              child: Text(
                addedToCart ? "VIEW CART" : "ADD TO CART",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          addedToCart
              ? Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      width: isBigScreen
                          ? (((screenSize.width - 250) / 2) - 52) / 1.7
                          : double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text("Item added to cart!"),
                    ),
                  ],
                )
              : SizedBox(height: 15),
          InkWell(
            hoverColor: Colors.black.withOpacity(0.4),
            onTap: buyItNow,
            child: Container(
              height: 40,
              width: isBigScreen
                  ? (((screenSize.width - 250) / 2) - 52) / 1.7
                  : double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
              ),
              child: Text(
                "BUY IT NOW",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );

    var appBar = Appbar(widget.itemCount, search);

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
              child: (isBigScreen)
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        drawer,
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              image,
                              information,
                            ],
                          ),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          image,
                          information,
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
