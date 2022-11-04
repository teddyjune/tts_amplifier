import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:text_to_speech/text_to_speech.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: '문자 확성기'),
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
  final inputTextController = TextEditingController();
  double currentSliderValue = 20;
  double volume = 1;
  final TextToSpeech tts = TextToSpeech();

  @override
  void dispose() {
    inputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Center(
                child: Lottie.network(
                  'https://assets5.lottiefiles.com/packages/lf20_ARsTjl5MXG.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                )),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: inputTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      tts.speak(inputTextController.text)
                    },
                    icon: const Icon(Icons.mic),
                  ),
                  hintText: '글을 쓰세요',
                ),
              ),
            ),
            Slider(
              value: currentSliderValue,
              max: 100,
              divisions: 5,
              label: currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  currentSliderValue = value;
                  tts.setVolume(value);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
