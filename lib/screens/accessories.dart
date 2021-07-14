import '../libraries.dart';

class Accessories extends StatefulWidget {
  int itemCount;
  Accessories(this.itemCount);
  @override
  _AccessoriesState createState() => _AccessoriesState();
}

class _AccessoriesState extends State<Accessories> {
  bool isBigScreen = false;
  bool fieldChange = false;
  Size screenSize;
  String searchTxt = '';
  final db = FirebaseFirestore.instance;
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

    // firebase >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Stream<QuerySnapshot> home = db.collection('Accessories').snapshots();
    // end firebase >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    var appBar = Appbar(widget.itemCount, search);
    var head = Head();
    var drawer = Drawerr();

    var gridView = StreamBuilder(
        stream: home,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
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
                  widget.itemCount,
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
