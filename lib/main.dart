import 'dart:async';

import 'package:easystate/easystate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:puzzle/etc/appstate.dart';
import 'package:puzzle/screen/board.dart';
import 'package:puzzle/screen/menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [],
  );
  runApp(
    EasyState(
      state: Appstate(),
      child: const Main(),
    ),
  );
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final model = Appstate();
  Timer? timer;

  Appstate? get state => EasyState.maybeOf<Appstate>(context)?.state;

  final numbers = [
    'assets/images/image001.png',
    'assets/images/image002.png',
    'assets/images/image003.png',
    'assets/images/image004.png',
    'assets/images/image005.png',
    'assets/images/image006.png',
    'assets/images/image007.png',
    'assets/images/image008.png',
    'assets/images/image009.png',
    'assets/images/image010.png',
    'assets/images/image011.png',
    'assets/images/image012.png',
    'assets/images/image013.png',
    'assets/images/image014.png',
    'assets/images/image015.png',
    "0",
  ];

  @override
  Widget build(BuildContext context) {
    timer ??= Timer.periodic(const Duration(seconds: 1), (t) {
      startTime();
    });
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Puzzle'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Board(
                lists: numbers,
                onTap: clickGrid,
              ),
            ),
            Menu(onPressed: reset),
          ],
        ),
      ),
    );
  }

  void startTime() {
    if (state?.isActive == true) {
      setState(() {
        state?.setTime();
      });
    }
  }

  void reset() {
    setState(() {
      numbers.shuffle();
    });
    state?.setTime(0);
    state?.setMove(value: 0);
    state?.setIsActive(value: false);
  }

  void clickGrid(BuildContext context, int index) {
    if (model.time == 0) {
      state?.setIsActive(value: true);
    }
    if (index - 1 >= 0 && numbers[index - 1] == "0" && index % 4 != 0 ||
        index + 1 < 16 && numbers[index + 1] == "0" && (index + 1) % 4 != 0 ||
        (index - 4 >= 0 && numbers[index - 4] == "0" ||
            (index + 4 < 16 && numbers[index + 4] == "0"))) {
      setState(() {
        numbers[numbers.indexOf("0")] = numbers[index];
        numbers[index] = "0";
        state?.setMove();
      });
    }

    checkWin(context);
  }

  void checkWin(context) {
    if (isSorted(numbers)) {
      state?.setIsActive(value: false);
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                height: 200,
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Great You Win!!!',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 220,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Close',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }
  }

  bool isSorted(List list) {
    bool result = true;
    int index = 1;

    for (String s in list) {
      if (s.startsWith("0") && index == 16) {
      } else if (!s.startsWith("0") && index != 16) {
        if (index != int.parse(s.toString().split("/").last.substring(5, 8))) {
          result = false;
          setState(() {});
        }
      } else {
        result = false;
        setState(() {});
      }
      index++;
      setState(() {});
    }
    return result;
  }
}
