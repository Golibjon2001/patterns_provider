

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:patterns_provider/model/post_model.dart';
import 'package:patterns_provider/pages/hom_page.dart';
import 'package:patterns_provider/serves/http_serves.dart';

class AddViewModel extends ChangeNotifier{
  bool isLoading = false;
  final TextEditingController titleTextEditingController = TextEditingController();
  final TextEditingController bodyTextEditingController = TextEditingController();


  apiPostCreate(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    Post post = Post(
      title: titleTextEditingController.text,
      body: bodyTextEditingController.text,
      userId: Random().nextInt(99999), id: Random().nextInt(999),);

    var response =
    await Network.POST(Network.API_CREATE, Network.paramsCreate(post));

    if (response != null) {
      Navigator.pushNamedAndRemoveUntil(context,HomePage.id, (route) => false);
    }
    isLoading = false;
    notifyListeners();
  }
}