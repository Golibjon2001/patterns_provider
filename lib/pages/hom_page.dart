import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:patterns_provider/model/post_model.dart';
import 'package:patterns_provider/pages/updata_page.dart';
import 'package:patterns_provider/viewmodel/home_view_model.dart';
import 'package:provider/provider.dart';

import 'add_page.dart';

class HomePage extends StatefulWidget {
  static final String id="hompage";
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel homeViewModel=HomeViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewModel.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle:true,
          title: const Text("Provider"),
        ),
        body:ChangeNotifierProvider(
          create:(context)=>homeViewModel,
          child:Consumer<HomeViewModel>(
            builder:(ctx,model,index)=> Stack(
              children: [
                ListView.builder(
                  itemCount:homeViewModel.items.length,
                  itemBuilder: (ctx, index) {
                    return itemOfPost(homeViewModel.items[index]);
                  },
                ),
                homeViewModel.isLoading
                    ? const Center(
                     child: CircularProgressIndicator(),
                )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context,AddPage.id);
          },
          child: const Icon(Icons.add),
        ));
  }

  Widget itemOfPost(Post post) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title.toUpperCase(),
              style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(post.body),
          ],
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Update',
          color: Colors.indigo,
          icon: Icons.edit,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage(title: post.title, body: post.body)));
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            homeViewModel.apiPostDelete(post).then((value) => {
              if(value) homeViewModel.apiPostList(),
            });
          },
        ),
      ],
    );
  }
}