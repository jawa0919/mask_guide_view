import 'package:flutter/material.dart';
import 'package:mask_guide_view/mask_guide_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final _ct = MaskGuideController();
  MaskGuideAlignment alignment = MaskGuideAlignment.top;

  double dx = 40.0;
  double dy = 0.0;
  double borderRadius = 10.0;
  double triangleSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have pushed the button this many times:'),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                MaskGuideView(
                  controller: _ct,
                  alignment: alignment,
                  offset: Offset(dx, dy),
                  borderRadius: borderRadius,
                  triangleSize: triangleSize,
                  maskGuideBuilder: (context, c) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 38, 16, 38),
                          child: Text("Please click here add counter"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              c.show = false;
                            },
                            child: Icon(Icons.close_outlined),
                          ),
                        )
                      ],
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.blue,
                    ),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: _incrementCounter,
                      icon: const Icon(Icons.add),
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 248),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    alignment = MaskGuideAlignment.top;
                  });
                },
                child: Text("Top"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 248),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    alignment = MaskGuideAlignment.left;
                  });
                },
                child: Text("Left"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 248),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    alignment = MaskGuideAlignment.bottom;
                  });
                },
                child: Text("Bottom"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 248),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    alignment = MaskGuideAlignment.right;
                  });
                },
                child: Text("Right"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 388),
              child: SizedBox(
                width: 400,
                height: 10,
                child: SliderTheme(
                  data: SliderThemeData(
                    showValueIndicator: ShowValueIndicator.always,
                  ),
                  child: Slider(
                    value: dx,
                    min: -50,
                    max: 50,
                    divisions: 10,
                    label: "dx $dx",
                    onChanged: (value) {
                      setState(() {
                        dx = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 388),
              child: SizedBox(
                height: 400,
                width: 10,
                child: RotatedBox(
                  quarterTurns: -3,
                  child: SliderTheme(
                    data: SliderThemeData(
                      showValueIndicator: ShowValueIndicator.always,
                    ),
                    child: Slider(
                      value: dy,
                      min: -50,
                      max: 50,
                      divisions: 10,
                      label: "dy $dy",
                      onChanged: (value) {
                        setState(() {
                          dy = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: SizedBox(
                width: 600,
                height: 10,
                child: SliderTheme(
                  data: SliderThemeData(
                    showValueIndicator: ShowValueIndicator.always,
                  ),
                  child: Slider(
                    value: borderRadius,
                    min: 5,
                    max: 50,
                    divisions: 45,
                    label: "borderRadius $borderRadius",
                    onChanged: (value) {
                      setState(() {
                        borderRadius = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: SizedBox(
                width: 600,
                height: 10,
                child: SliderTheme(
                  data: SliderThemeData(
                    showValueIndicator: ShowValueIndicator.always,
                  ),
                  child: Slider(
                    value: triangleSize,
                    min: 5,
                    max: 50,
                    divisions: 45,
                    label: "triangleSize $triangleSize",
                    onChanged: (value) {
                      setState(() {
                        triangleSize = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _ct.show = true;
        },
        tooltip: 'Show',
        child: Text("Show"),
      ),
    );
  }
}
