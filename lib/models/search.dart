import 'package:flutter/material.dart';
import 'package:wavsound/classes/colors.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List searchItems;
  CustomSearchDelegate({required this.searchItems});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var sound in searchItems) {
      if (sound.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(sound);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          textColor: AppColors.primaryTextColor,
          title: Text(result),
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.iconColor),
      ),
      highlightColor: Colors.transparent,
      hintColor: AppColors.dimTextColor,
      splashColor: Colors.transparent,
      primaryColor: AppColors.primaryColor,
      textTheme: const TextTheme(
        headline6: TextStyle(color: AppColors.dimTextColor),
      ),
      scaffoldBackgroundColor: AppColors.primaryColor,
      useMaterial3: true,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var sound in searchItems) {
      if (sound.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(sound);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          textColor: AppColors.primaryTextColor,
          title: Text(result),
        );
      },
    );
  }
}
