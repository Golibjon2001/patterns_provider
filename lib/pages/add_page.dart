
import 'package:flutter/material.dart';
import 'package:patterns_provider/viewmodel/add_view_model.dart';
import 'package:provider/provider.dart';
class AddPage extends StatefulWidget {
  static final String id = 'create_page';
  const AddPage({Key? key}) : super(key: key);
  @override
  AddPageState createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  AddViewModel addViewModel=AddViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body:ChangeNotifierProvider(
        create:(context)=>addViewModel,
        child:Consumer<AddViewModel>(
          builder:(ctx,model,index)=> Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Title
                    Container(
                      height: 50,

                      child: Center(
                        child: TextField(
                          controller: addViewModel.titleTextEditingController,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // Body
                    Container(
                      height: 200,
                      padding: const EdgeInsets.all(5),
                      child: TextField(
                        controller: addViewModel.bodyTextEditingController,
                        style: const TextStyle(fontSize: 18),
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
              addViewModel.isLoading
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
          addViewModel.apiPostCreate(context);
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}