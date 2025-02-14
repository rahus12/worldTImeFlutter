import 'package:flutter/material.dart';
import 'package:worldtime/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'united-kingdom.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Berlin', flag: 'germany.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'united-states.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south-korea.png'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];

    await instance.getTime();
    // we dont want to push named now again like in Choose location page, this time we want to pop
    // cuz the page is already below sitting

    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // need cuz it automatically adds a back arrow button to pop the screens
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        title: Text('choose a location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              onTap: () {
                updateTime(index);
              },
              title: Text(locations[index].location),
              leading: CircleAvatar(backgroundImage: AssetImage('assets/${locations[index].flag}'),),
            ),
          );
        },
        itemCount: locations.length,
      )
    );
  }
}
