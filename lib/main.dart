import 'package:app_weather/bloc/weather_bloc.dart';
import 'package:app_weather/bloc/weather_repository.dart';
import 'package:app_weather/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = WeatherBloc(WeatherRepository());
  TextEditingController _controller = TextEditingController();
  String city = "Бишкек";
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.lime),
        child: Column(
          children: [
            SizedBox(height: 30),
            Center(
              child: BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is WeatherInitial) {
                    return Loading();
                  } else if (state is WeatherLoaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 30),
                        Text(
                          "${DateFormat('MMMEd').format(now)}",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "${DateFormat('hh:mm a').format(now)}",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          state.model.name.toString(),
                          style: TextStyle(fontSize: 50, color: Colors.white),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Icon(
                          Icons.wb_sunny_sharp,
                          size: 200,
                          color: Colors.amberAccent,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          state.model.main!.temp.toString() + " °",
                          style: TextStyle(fontSize: 50, color: Colors.white),
                        ),
                      ],
                    );
                  } else if (state is WeatherError) {
                    return Text("Oops connect failed");
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: 30),
                    ],
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    hintText: "Введите город",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          city = _controller.text;
          bloc.add(GetWeatherEvent(city));
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}
