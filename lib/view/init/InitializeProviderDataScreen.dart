import 'package:apicallslegend/models/chuck_categories.dart';
import 'package:apicallslegend/providers/ChuckyProvider.dart';
import 'package:apicallslegend/utils/commons.dart';
import 'package:apicallslegend/utils/error.dart';
import 'package:apicallslegend/view/chucky/chuck_categories_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitializeProviderDataScreen extends StatefulWidget {
  InitializeProvidersState createState() => InitializeProvidersState();
}

class InitializeProvidersState extends State<InitializeProviderDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ChuckCategories>(
        future: Provider.of<ChuckyProvider>(context, listen: false)
            .fetchChuckyCategories(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text(
                'Fetch opportunity data',
                textAlign: TextAlign.center,
              );
            case ConnectionState.active:
              return Text('');
            case ConnectionState.waiting:
              return Commons.chuckyLoading("Fetching Chucky Categories...");
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Error(
                  errorMessage: "Error retrieving chucky categories.",
                );
              } else {
                return GetChuckCategories();
              }
          }
          return Commons.chuckyLoading("Fetching Chucky Categories...");
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
