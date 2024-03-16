import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Списочки',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  List<String> _content1 = ['Первый', 'Второй', 'Третий'];
  List<String> _content2 = ['Первый', 'Второй', 'Третий'];
  List<String> _content3 = ['Первый', 'Второй', 'Третий'];
  TextEditingController textController = TextEditingController();

  void _addItem() {
    setState(() {
      if (_currentIndex == 0) {
        _content1.add(textController.text);
        textController.clear();
      } else if (_currentIndex == 1) {
        _content2.add(textController.text);
        textController.clear();
      } else {
        _content3.add(textController.text);
        textController.clear();
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      if (_currentIndex == 0) {
        _content1.removeAt(index);
      } else if (_currentIndex == 1) {
        _content2.removeAt(index);
      } else {
        _content3.removeAt(index);
      }
    });
  }

  Widget _buildContentWidget() {
    if (_currentIndex == 0) {
      return _buildColumnWidget();
    } else if (_currentIndex == 1) {
      return _buildListViewWidget();
    } else {
      return _buildSeparatedListViewWidget();
    }
  }

  Widget _buildColumnWidget() {
    return Column(
      children: _content1
          .map((item) => ListTile(
        title: TextField(
          controller: TextEditingController(text: (item)),
          onChanged: (value) {
            item = value;
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _removeItem(_content1.indexOf(item)),
        ),
      ))
          .toList(),
    );
  }

  Widget _buildListViewWidget() {
    return ListView.builder(
      itemCount: _content2.length,
      itemBuilder: (context, index) => ListTile(
        title: TextField(
          controller: TextEditingController(text: (_content2[index])),
          onChanged: (value) {
            _content2[index] = value;
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _removeItem(index),
        ),
      ),
    );
  }

  Widget _buildSeparatedListViewWidget() {
    return ListView.separated(
      itemCount: _content3.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => ListTile(
        title: TextField(
          controller: TextEditingController(text: (_content3[index])),
          onChanged: (value) {
            _content3[index] = value;
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _removeItem(index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Списочки', style: TextStyle( color: Colors.white)),
        backgroundColor: Colors.pink[300],
      ),
      body: _buildContentWidget(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Тип-Column',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Тип-ListView',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Тип-ListView.separated',
          ),
        ],
        selectedItemColor: Colors.pink,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: (){
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.pink[100],
                title: Text('Добавить строку'),
                content: TextField(controller: textController),
                actions: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.pink),
                    ),
                    onPressed: () {
                      _addItem();
                      Navigator.pop(context);
                    },
                    child: Text('Добавить', style: TextStyle( color: Colors.black)),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Добавить строку',

        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}