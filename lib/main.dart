import 'package:flutter/material.dart';
import 'package:flutter_stream_exam/bloc.dart';
import 'package:flutter_stream_exam/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider(
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}

class MyHomePage extends StatelessWidget {
//  int _counter = 0;

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    Bloc bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: _buildFuture(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    return Text(snapshot.data);
                }
              },
            ),
            _buildTextWidget(bloc),
            StreamBuilder(
              stream: bloc.event2,
              builder: (context, AsyncSnapshot<int> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    return Text('3번째 위젯 ${snapshot.data}');
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: bloc.click,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _buildTextWidget(bloc) {
    return StreamBuilder(
      stream: bloc.event,
      builder: (context, AsyncSnapshot<int> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            return Text('3번째 위젯 ${snapshot.data}');
        }
      },
    );
  }

  Future<String> _buildFuture() async {
    await Future.delayed(Duration(seconds: 3));
    return Future.value("Ok");
  }
}
