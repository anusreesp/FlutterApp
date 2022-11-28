import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  final List _suggestions = ["bird", "mountain", "food"];

  final TextEditingController _searchQuery = TextEditingController();

  //------------------------------   ----------------------------------
  _buildAppBar() {
    return AppBar(
      title: SearchField(
        maxSuggestionsInViewPort: 5,
        suggestions: _suggestions
            .map((e) => SearchFieldListItem(
                  e,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      e,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ))
            .toList(),
        suggestionState: Suggestion.expand,
        textInputAction: TextInputAction.next,
        hint: 'Search Keywords.....',
        hasOverlay: false,
        searchStyle: TextStyle(
          fontSize: 18,
          color: Colors.black.withOpacity(0.8),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

//------------------------------   ----------------------------------
  Widget _buildBody() {
    return Container();
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
}
