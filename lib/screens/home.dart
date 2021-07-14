import '../libraries.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isBigScreen = false;
  bool fieldChange = false;
  Size screenSize;
  final db = FirebaseFirestore.instance;
  Stream<QuerySnapshot> home;
  String searchTxt = '';
  int itemCount;

  void getCount(int count) {
    setState(() {
      itemCount = count;
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
    db.collection('cart').get().then((value) => getCount(value.docs.length));

    var appBar = Appbar(itemCount, search);

    var head = Head();
    var drawer = Drawerr();

    var gridView = StreamBuilder(
        stream: (searchTxt.isNotEmpty)
            ? db
                .collection('Home')
                .where('indexing', arrayContains: searchTxt)
                .snapshots()
            : db.collection('Home').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: Text(
              'Loading...',
              style: TextStyle(fontSize: 30, color: Colors.teal),
            ));
          return SingleChildScrollView(
            child: Wrap(
              spacing: 30,
              runSpacing: 20,
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return ContainerGrid(
                  document.data()['title'],
                  document.data()['price'],
                  document.data()['index'],
                  document.data()['image'],
                  itemCount,
                );
              }).toList(),
            ),
          );
        });

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
                          child: Material(
                            clipBehavior: Clip.antiAlias,
                            child: gridView,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : Material(clipBehavior: Clip.antiAlias, child: gridView),
            ),
          ],
        ),
      ),
    );
  }
}
