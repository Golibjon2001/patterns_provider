
import 'package:flutter/material.dart';
import 'package:patterns_provider/viewmodel/updata_view_model.dart';
import 'package:provider/provider.dart';


class UpdatePage extends StatefulWidget {
  static final String id = 'update_page';

  String? title, body;
  UpdatePage({this.title, this.body, Key? key}) : super(key: key);
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  UpdataViewModel updataViewModel=UpdataViewModel();

  @override
  void initState() {
    super.initState();
    updataViewModel.titleTextEditingController.text = widget.title!;
    updataViewModel.bodyTextEditingController.text = widget.body!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
      ),
      body:ChangeNotifierProvider(
        create:(context)=>updataViewModel,
        child:Consumer<UpdataViewModel>(
          builder: (ctx,model,index)=>
        SingleChildScrollView(
          child:Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // Title
                    Container(
                      height: 100,
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: TextField(maxLines: 2,
                          controller: updataViewModel.titleTextEditingController,
                          style: const TextStyle(fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                    // Body
                    Container(
                      height: 500,
                      padding: const EdgeInsets.all(5),
                      child: TextField(
                        controller: updataViewModel.bodyTextEditingController,
                        style: const TextStyle(fontSize: 20),
                        maxLines: 10,
                        decoration: const InputDecoration(
                          labelText: 'Body',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              updataViewModel.isLoading
                  ? const Center(
                   child: CircularProgressIndicator(),
              ) : const SizedBox.shrink(),
            ],
          ),
        ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          updataViewModel.apiPostUpdate(context);
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}