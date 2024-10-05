import 'package:flutter/material.dart';
import 'package:for_fun/water_consume.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassCountTEController =
      TextEditingController(text: '1');
  int count = 0;
  List<WaterConsume> waterConsumeList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Tooltip(
              message: 'Refresh',
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _glassCountTEController.clear();
                    _getTotalWaterConsumeCount();
                    waterConsumeList.clear();
                  });
                },
                icon: const Icon(
                  Icons.refresh,
                ),
                hoverColor: Colors.green,
              ))
        ],
        title: const Text('Water Tracker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment(50, 0),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 135,
              child: TextField(
                controller: _glassCountTEController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'No of Glass',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              splashColor: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(80),
              onTap: _addWaterConsume,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 5),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(28),
                  child: Column(
                    children: [
                      Icon(
                        Icons.water_drop_outlined,
                        size: 32,
                        color: Colors.blue,
                      ),
                      Text('Tap Here'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.history),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'History',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Total: ${_getTotalWaterConsumeCount()}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  reverse: true,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: waterConsumeList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(
                        DateFormat.yMEd()
                            .add_jms()
                            .format(waterConsumeList[index].time),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      trailing: Text(
                        waterConsumeList[index].glassCount.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _addWaterConsume() {
    int glassCount = int.tryParse(_glassCountTEController.text) ?? 1;
    WaterConsume waterConsume =
        WaterConsume(time: DateTime.now(), glassCount: glassCount);
    waterConsumeList.add(waterConsume);
    setState(() {});
  }

  int _getTotalWaterConsumeCount() {
    int totalCount = 0;
    for (WaterConsume waterConsume in waterConsumeList) {
      totalCount += waterConsume.glassCount;
    }
    return totalCount;
  }
}
