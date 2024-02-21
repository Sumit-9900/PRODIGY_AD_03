import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String digitmilli = "000", digitsec = "00", digitmin = "00";
  int milli = 0;
  int sec = 0;
  int min = 0;
  Timer? _timer;
  List laps = [];
  bool started = false;
  bool resets = false;
  @override
  Widget build(BuildContext context) {
    void start() {
      started = true;
      _timer = Timer.periodic(
        const Duration(milliseconds: 1),
        (timer) {
          int localmilli = milli;
          int localsec = sec;
          int localmin = min;
          localmilli++;
          if (localmilli > 999) {
            localmilli = 0;
            localsec++;
            if (localsec > 59) {
              localsec = 0;
              localmin++;
            }
          }
          setState(() {
            milli = localmilli;
            sec = localsec;
            min = localmin;

            digitmilli = milli >= 10 ? '$milli' : '0$milli';
            digitsec = sec >= 10 ? '$sec' : '0$sec';
            digitmin = min >= 10 ? '$min' : '0$min';
          });
        },
      );
    }

    void reset() {
      _timer!.cancel();
      setState(() {
        milli = 0;
        sec = 0;
        min = 0;
        digitmilli = "000";
        digitsec = "00";
        digitmin = "00";
        laps.clear();
        resets = true;
        started = false;
      });
    }

    void stop() {
      _timer!.cancel();
      setState(() {
        started = false;
      });
    }

    void addlaps() {
      String lap = '$digitmin:$digitsec:$digitmilli';
      setState(() {
        laps.add(lap);
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'StopWatch',
            style: TextStyle(
              color: Color.fromARGB(171, 255, 255, 255),
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 43, 19, 109),
                Color.fromARGB(255, 26, 5, 63),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$digitmin:$digitsec',
                      style: const TextStyle(
                        fontSize: 60,
                        color: Color.fromARGB(171, 255, 255, 255),
                        fontWeight: FontWeight.w300,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                    Text(
                      '.$digitmilli',
                      style: const TextStyle(
                        fontSize: 40,
                        color: Color.fromARGB(171, 255, 255, 255),
                        fontWeight: FontWeight.w300,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color.fromARGB(109, 53, 72, 177),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'LAPS :-',
                            style: TextStyle(
                              color: Color.fromARGB(171, 255, 255, 255),
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: (!started && resets) ? 0 : laps.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      laps[index],
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: (started) ? stop : start,
                      child:
                          (started) ? const Text('Pause') : const Text('Start'),
                    ),
                    GestureDetector(
                      onTap: addlaps,
                      child: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 120, 74, 201),
                        foregroundColor: Colors.grey,
                        radius: 25,
                        child: Icon(
                          Icons.flag,
                          size: 28,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: reset,
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
