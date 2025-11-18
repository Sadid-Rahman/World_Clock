import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location = "";
  String time = "";
  String flag = "";
  String url = "";
  late bool isDayTime;

  WorldTime({required this.location,required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response = await get(
        Uri.parse('http://worldtimeapi.org/api/timezone/$url'),
        headers: {
          'User-agent': 'Chrome',
          'accept': 'application/json'
        },
      );

      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      DateTime now = DateTime.parse(datetime);

      // handle offset
      String offsetHours = offset.substring(1,3);
      String offsetMinutes = offset.substring(4,6);

      int offsetHrs = int.parse(offsetHours);
      int offsetMins = int.parse(offsetMinutes);

      if (offset[0] == '-') {
        offsetHrs = -offsetHrs;
        offsetMins = -offsetMins;
      }

      now = now.add(Duration(hours: offsetHrs, minutes: offsetMins));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat('jm').format(now);
      print(time);

    } 
    catch (err) 
    {
      print('caught error $err');
      time = 'could not get time data';
    }
  }
}


