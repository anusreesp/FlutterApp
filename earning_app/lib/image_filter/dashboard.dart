import 'package:earning_app/data/data_repo.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List _suggestions = ["bird", "mountain", "food"];

  dynamic initValue;
  List _listofValues = [];
  List _filterData = [];

  List typeList = [];
  List nameList = [];

  final TextEditingController _searchQuery = TextEditingController();

  Future listingFunc(String enterKey) async {
    final output = await DataRepository.getValues();
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

                } else {}
              });
            },
            icon: actionIcon)
      ],
      bottom: TabBar(
        labelColor: Colors.black,
        indicatorColor: Color.fromARGB(255, 75, 234, 245),
        tabs: <Widget>[
          Container(
            padding: const EdgeInsets.all(5.0),
            child: const Text('All'),
          ),
          Container(
            // padding: const EdgeInsets.all(4.0),
            child: const Text('Mountain'),
          ),
          Container(
            padding: const EdgeInsets.all(6.0),
            child: const Text('Birds'),
          ),
          Container(
            padding: const EdgeInsets.all(6.0),
            child: const Text('Food'),
          ),
        ],
      ),
    );
  }

  tabBody() {
    return TabBarView(
      children: <Widget>[
        _buildBody(0),
        _buildBody(1),
        _buildBody(2),
        _buildBody(3),
      ],
    );
  }

//------------------------------   ----------------------------------
  Widget _buildBody(int page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: FutureBuilder(
          future: initValue,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0),
                itemBuilder: (context, index) {
                  var event = snapshot.data[index] as EachResult;
                  var id = event.id;
                  var name = event.name;
                  var type = event.type;
                  var imgPath = event.imagepath;

                  typeList.add(type);
                  nameList.add(name);

                  switch (page) {
                    case 0:
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Image.asset(
                            imgPath,
                            fit: BoxFit.cover,
                            width: 20,
                            height: 20,
                          ));

                    case 1:
                      return Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: type == "Montain"
                                ? Image.asset(
                                    imgPath,
                                    fit: BoxFit.cover,
                                    width: 20,
                                    height: 20,
                                  )
                                : null),
                      );

                    case 2:
                      return Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: type == "birds"
                                ? Image.asset(
                                    imgPath,
                                    fit: BoxFit.cover,
                                    width: 20,
                                    height: 20,
                                  )
                                : null),
                      );
                    case 3:
                      return Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: type == "food"
                                ? Image.asset(
                                    imgPath,
                                    fit: BoxFit.cover,
                                    width: 20,
                                    height: 20,
                                  )
                                : null),
                      );

                    default:
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Image.asset(
                            imgPath,
                            fit: BoxFit.cover,
                            width: 20,
                            height: 20,
                          ));
                  }
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  @override
  void initState() {
    initValue = listingFunc("search");
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List result = [];
    if (enteredKeyword.isEmpty) {
      result = _listofValues;
    } else {
      for (var i = 0; i < _listofValues.length; i++) {
        String? name = _listofValues.elementAt(i);
        if (name!.toLowerCase().contains(enteredKeyword.toLowerCase())) {
          result.add(name);

          debugPrint("$result");
        }
        result = result.toList();
      }
    }

    setState(() {
      _filterData = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: _buildAppBar(),
          body: tabBody(),
        ));
  }
}
