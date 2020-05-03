import 'package:apicallslegend/models/chuck_response.dart';
import 'package:apicallslegend/utils/commons.dart';
import 'package:apicallslegend/providers/ChuckyJokeProvider.dart';
import 'package:apicallslegend/utils/error.dart';
import 'package:apicallslegend/utils/shape/BottomWave.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowChuckyJoke extends StatefulWidget {
  final String selectedCategory;

  const ShowChuckyJoke(this.selectedCategory);

  @override
  _ShowChuckyJokeState createState() => _ShowChuckyJokeState();
}

class _ShowChuckyJokeState extends State<ShowChuckyJoke> {
  ChuckResponse displayJoke;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Chucky Joke',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Commons.appBarBackGroundColor,
      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Commons.chuckyJokeWaveBackgroundColor,
      body: FutureBuilder<ChuckResponse>(
        future: Provider.of<ChuckyJokeProvider>(context, listen: false)
            .fetchChuckyJoke(widget.selectedCategory),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text(
                'Fetch chuck joke.',
                textAlign: TextAlign.center,
              );
            case ConnectionState.active:
              return Text('');
            case ConnectionState.waiting:
              return Commons.chuckyLoading("Getting Chucky Joke...");
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Error(
                  errorMessage: "Error getting joke.",
                );
              } else {
                displayJoke = snapshot.data;
                return Column(
                  children: <Widget>[
                    chucky(),
                    Expanded(
                      child: Align(
                        child: ClipPath(
                          child: Container(
                            color: Colors.white,
                            height: 300,
                          ),
                          clipper: BottomWave(),
                        ),
                        alignment: Alignment.bottomCenter,
                      ),
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                );
              }
          }
          return Commons.chuckyLoading("Getting Chucky Joke...");
        },
      ),
    );
  }

  Widget chucky() {
    return Column(
      children: <Widget>[
        SizedBox(
          child: Container(
            color: Commons.tileBackgroundColor,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                displayJoke.value,
                style: TextStyle(
                    color: Colors.black, fontSize: 16, fontFamily: 'Roboto'),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 260,
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: Container(
                  child: Align(
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      width: 150,
                      height: 150,
                    ),
                  ),
                  height: 154,
                )),
                Positioned(
                  child: Container(
                      height: 124,
                      child: Align(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(5, 15, 0.0, 0.0),
                          child: Image.network(
                            displayJoke.iconUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                  bottom: MediaQuery.of(context).size.height * 0.046,
                  right: MediaQuery.of(context).size.width * 0.22,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width * 0.08,
                  height: MediaQuery.of(context).size.width * 0.08,
                  bottom: 0,
                  right: MediaQuery.of(context).size.width * 0.32,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
