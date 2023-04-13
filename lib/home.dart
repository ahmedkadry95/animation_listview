import 'dart:developer';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedList();
  }
}

class CustomAnimatedList extends StatelessWidget {
  final GlobalKey<AnimatedListState> animatedListKey = GlobalKey();
  final list = [];

  CustomAnimatedList({super.key});
  void insertItem() {
    var index = list.length;
    list.add('item ${index + 1}');
    animatedListKey.currentState!.insertItem(index);
  }

  void removeItem(int index) {
    // list.removeAt(index);

    animatedListKey.currentState!.removeItem(
      index,
      (context, animation) {
        return SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(0, 1),
              end: const Offset(0, 0),
            ),
          ),
          child: animatedListItem(index),
        );
        // return SizeTransition(
        //   sizeFactor: animation,
        //   child: animatedListItem(index),
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: animatedListKey,
              initialItemCount: list.length,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                return SlideTransition(
                  position: animation.drive(
                    Tween<Offset>(
                      begin: const Offset(-1, 1),
                      end: const Offset(0, 0),
                    ),
                  ),
                  child: animatedListItem(index),
                );
                ///////// SizeTransition
                // return SizeTransition(
                //   sizeFactor: animation,
                //   child: animatedListItem(index),
                // );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: insertItem,
              child: const Text('add item'),
            ),
          )
        ],
      ),
    );
  }

  Card animatedListItem(int index) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.person_remove),
        title: Text(list[index]),
        subtitle: const Text('subtitle'),
        trailing: IconButton(
          onPressed: () {
            removeItem(index);
          },
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
