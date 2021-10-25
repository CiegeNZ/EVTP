import 'package:evtp/UI/Components/Route/autoCompleteLocation.dart';
import 'package:evtp/appState.dart';
import 'package:flutter/material.dart';

final TextEditingController _startController = new TextEditingController();
final TextEditingController _endController = new TextEditingController();

class RouteSearch extends StatefulWidget {
  final routeCallback;
  RouteSearch({this.routeCallback});

  @override
  _RouteSearchState createState() => _RouteSearchState(this.routeCallback);
}

class _RouteSearchState extends State<RouteSearch> {
  final routeCallback;

  _RouteSearchState(this.routeCallback);

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white30.withAlpha(150),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoCompleteLocation(
                    title: "Start",
                    callbackController: _startController,
                    myLocation: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoCompleteLocation(
                    title: "End",
                    callbackController: _endController,
                    myLocation: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      routeCallback(_startController.text, _endController.text);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Search",
                          style: TextStyle(fontSize: 26),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.search),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
