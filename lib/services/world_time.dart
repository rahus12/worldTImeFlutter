import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String? location;
  String time = '';
  String? flag;
  String? url;
  bool isDayTime = false;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async{
    // Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    // print(response.body);
    try {
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'))
          .timeout(Duration(seconds: 10)); // Set timeout to 10 seconds

      // print(response.body);
      // ✅ Check if response is empty
      if (response.body.isEmpty) {
        throw FormatException("Received empty response from server");
      }

      Map data = jsonDecode(response.body);

      // get property from data
      String datetime = data['datetime'];
      String sign = data['utc_offset'].substring(0,1);
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);

      DateTime now = DateTime.parse(datetime);
      if (sign == '+'){
        now = now.add(Duration(hours: int.parse(offset)));
      }
      else{
        now = now.add(Duration(hours: -int.parse(offset)));
      }
      // now.add(Duration(hours: ))
      // print(now);

      //set the time property
      // time = now.toString();
      time = DateFormat.jm().format(now);
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

    } catch (e) {
        print("Request failed: $e"); // Handle timeout or other errors
        time = 'Error: Could not get';
      }


  }

}
