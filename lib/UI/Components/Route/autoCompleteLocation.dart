import 'package:evtp/Tools/Location/location.dart';
import 'package:evtp/Tools/Maps/places_service.dart' as places;
import 'package:flutter/material.dart';

List<places.Suggestion> _places = [];
String _displayStringForOption(places.Suggestion suggestion) => suggestion.name;

class AutoCompleteLocation extends StatefulWidget {
  late final String title;
  late final TextEditingController callbackController;
  bool myLocation = false;

  AutoCompleteLocation(
      {required this.title,
      required this.callbackController,
      required this.myLocation});
  @override
  _AutoCompleteLocationState createState() => _AutoCompleteLocationState();
}

class _AutoCompleteLocationState extends State<AutoCompleteLocation> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      displayStringForOption: _displayStringForOption,
      fieldViewBuilder: (BuildContext context, _controller, FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: _controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: widget.title + " Navigation",
            contentPadding: const EdgeInsets.all(8.0),
            prefix: widget.callbackController.text == "" &&
                    widget.myLocation == true
                ? IconButton(
                    icon: Icon(Icons.location_searching_rounded),
                    iconSize: 16,
                    onPressed: () {
                      widget.callbackController.text = "Current Location";
                      _controller.text = "Current Location";
                      FocusScope.of(context).unfocus();
                    })
                : null,
            suffix: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  widget.callbackController.clear();
                  _controller.clear();
                  FocusScope.of(context).unfocus();
                }),
          ),
          onTap: () {
            _places.clear();
            FocusScope.of(context).unfocus();
          },
          style: TextStyle(color: Colors.black, fontSize: 20),
          onChanged: (String value) {
            _places.clear();
            handleAutocomplete(value);
          },
        );
      },
      onSelected: (places.Suggestion selection) {
        widget.callbackController.text = selection.getPlaceID();
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        return _places;
      },
      //options view builder to include sub heading?
    );
  }

  Future<void> handleAutocomplete(String value) async {
    _places = await places.getSuggestion(value);
    setState(() {});
  }
}
