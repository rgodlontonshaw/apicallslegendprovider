import 'package:apicallslegend/models/chuck_categories.dart';
import 'package:apicallslegend/utils/commons.dart';
import 'package:apicallslegend/view/chucky/chuck_joke_view.dart';
import 'package:apicallslegend/providers/ChuckyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetChuckCategories extends StatefulWidget {
  @override
  _GetChuckyState createState() => _GetChuckyState();
}

class _GetChuckyState extends State<GetChuckCategories> {
  ChuckCategories chuckCategories;

  @override
  void initState() {
    chuckCategories =
        Provider.of<ChuckyProvider>(context, listen: false).chuckCategories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: Text('Chucky Categories',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            backgroundColor: Commons.appBarBackGroundColor,
            actions: <Widget>[
              FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  Commons.logout(context);
                },
                child: Text("Logout"),
                shape:
                    CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
            ]),
        backgroundColor: Color(0xFF333333),
        body: CategoryList(categoryList: chuckCategories));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class CategoryList extends StatelessWidget {
  final ChuckCategories categoryList;
  const CategoryList({Key key, this.categoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Commons.categoriesBackGroundColor,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 0.5,
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ShowChuckyJoke(categoryList.categories[index])));
                  },
                  child: SizedBox(
                    height: 65,
                    child: Container(
                      color: Commons.tileBackgroundColor,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                        child: Text(
                          categoryList.categories[index],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Roboto'),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  )));
        },
        itemCount: categoryList.categories.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}
