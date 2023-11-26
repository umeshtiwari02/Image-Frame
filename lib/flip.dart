import 'package:flutter/material.dart';

class Flip extends StatelessWidget {
  const Flip({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("AppMaking.com"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.rotate_right,
                size: 28,
                semanticLabel: 'Rotate',
              )),
          PopupMenuButton(
              onSelected: (value) {},
              icon: const Icon(
                Icons.flip,
                size: 28,
                semanticLabel: 'Flip',
              ),
              itemBuilder: (BuildContext bc) {
                return [
                  PopupMenuItem(
                    value: '/hello',
                    child: Container(
                      width: 140,
                      child: Text("Flip horizontally"),
                    ),
                  ),
                  PopupMenuItem(
                    value: '/about',
                    child: Container(
                      width: 140,
                      child: Text("Flip horizontally"),
                    ),
                  ),
                ];
              }),
          Container(
            height: 190,
            width: 200,
            color: Colors.white60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text('Flip horizontally'), Text('Flip vertically')],
            ),
          ),
          TextButton(
              onPressed: () {},
              child: const Text(
                'CROP',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: const Center(
        child: Text(''),
      ),
    );
  }
}
