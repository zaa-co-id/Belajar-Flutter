import 'package:flutter/material.dart';

class Alarm extends StatefulWidget {
  const Alarm({super.key});

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  bool _alarmOn = false;

  void _toggleAlarm(bool value) {
    setState(() {
      _alarmOn = value;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_alarmOn ? 'Alarm dihidupkan' : 'Alarm dimatikan'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Alarm"), centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Center(
            child: Text(
              'Pengaturan Alarm',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Aktifkan Alarm', style: TextStyle(fontSize: 18)),
                Switch(
                  value: _alarmOn,
                  onChanged: _toggleAlarm,
                  activeColor: Colors.green,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (_alarmOn)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.alarm_on, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Alarm sedang aktif'),
                ],
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.alarm_off, color: Colors.grey),
                  SizedBox(width: 8),
                  Text('Alarm tidak aktif'),
                ],
              ),
            ),

          const SizedBox(height: 30),

          // ElevatedButton yang baru ditambahkan
          ElevatedButton(
            onPressed: () {
              _toggleAlarm(!_alarmOn); // toggle alarm saat tombol ditekan
            },
            child: Text(_alarmOn ? 'Matikan Alarm' : 'Hidupkan Alarm'),
          ),
        ],
      ),
    );
  }
}
