import 'package:earning_app/data/data_repo.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List _suggestions = ["bird", "mountain", "food"];

  var initValue;
  List _listofValues = [];
  List _filterData = [];

  final TextEditingController _searchQuery = TextEditingController();

  Future listingFunc(String enterKey) async {
    final output = await DataRepository.getValues();
    // final results = await ShoppingRepository.getShoppingResults(enterKey);
    return output;
  }

  Widget appBarTitle = const Text("Dashboard",
      style: TextStyle(color: Color.fromARGB(255, 42, 42, 42)));

  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.grey,
  );
//------------------------------   AppBar  ----------------------------------

  _buildAppBar() {
    return AppBar(
      title: appBarTitle,
      backgroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () async {
              // _locationFromDB();
              setState(() {
                if (actionIcon.icon == Icons.search) {
                  actionIcon = const Icon(
                    Icons.close,
                    color: Colors.grey,
                  );
                  appBarTitle = TextField(
                    onChanged: (value) => _runFilter(value),
                    controller: _searchQuery,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      // enabledBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(width: 2, color: Colors.grey)),
                      // prefixIcon: Icon(Icons.search),
                      hintText: "Search Keywords... ",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  );
                  // _handleSearchStart();
                  // debugPrint("******************");
                  // debugPrint(test);
                  // _locationFromDB();
                } else {}
              });
            },
            icon: actionIcon)
      ],
      bottom: TabBar(
        labelColor: Colors.black,
        indicatorColor: Colors.blue,
        tabs: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            child: const Text('All'),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: const Text('Mountain'),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: const Text('Birds'),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: const Text('Food'),
          ),
        ],
      ),
    );
  }

//------------------------------   ----------------------------------
  Widget _buildBody() {
    return FutureBuilder(
        future: initValue,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                var event = snapshot.data[index] as EachResult;
                var id = event.id;
                var name = event.name;
                var type = event.type;
                var imgPath = event.imagepath;

                return Image.asset(imgPath);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  void initState() {
    initValue = listingFunc("search");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
        ));
  }

  void _runFilter(String enteredKeyword) {
    // List<PagingProduct> results = [];
    List result = [];

    if (enteredKeyword.isEmpty) {
      result = _listofValues;
    } else {
      for (var i = 0; i < _listofValues.length; i++) {
        String? name = _listofValues.elementAt(i);
        if (name!.toLowerCase().contains(enteredKeyword.toLowerCase())) {
          result.add(name);
          debugPrint("else ================================== $result");
          debugPrint("$result");
        }
        result = result.toList();
      }
      // return result.toList();
    }

    setState(() {
      _filterData = result;
    });
  }
}
