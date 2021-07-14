import '../libraries.dart';

class Total extends StatefulWidget {
  double totalPrice;
  Total(this.totalPrice);

  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<Total> {
  bool isBigScreen = false;
  bool isBigScreenMid = false;
  Size screenSize;
  @override
  Widget build(BuildContext context) {
    setState(() {
      screenSize = MediaQuery.of(context).size;
      isBigScreen = (screenSize.width >= 750);
      isBigScreenMid = (screenSize.width >= 1100);
    });
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 30, right: 20),
      width: (isBigScreen) ? ((screenSize.width - 250)) - 40 : null,
      child: Row(
        children: [
          Text(""),
          Expanded(child: SizedBox()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Subtotal \$${widget.totalPrice.toString()}",
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 17),
              Text("Taxes and shipping calculated at checkout",
                  style: TextStyle(fontSize: 15)),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    hoverColor: Colors.grey.withOpacity(0.11),
                    child: Container(
                      width: 55,
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              width: 2,
                              style: BorderStyle.solid)),
                      alignment: Alignment.center,
                      child: Icon(Icons.refresh, size: 26),
                    ),
                  ),
                  SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    hoverColor: Colors.grey.withOpacity(0.11),
                    child: Container(
                      width: 200,
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              width: 2,
                              style: BorderStyle.solid)),
                      alignment: Alignment.center,
                      child: Text("CONTINUE SHOPPING",
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () {},
                hoverColor: Colors.white.withOpacity(0.8),
                child: Container(
                  color: Colors.black.withOpacity(0.8),
                  width: 130,
                  height: 43,
                  alignment: Alignment.center,
                  child: Text("CHECK OUT",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ],
      ),
    );
  }
}
