import 'package:flutter/material.dart';
import 'package:lifecycle_app/saveState.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SaveState.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter App LifeCycle',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  late TextEditingController resumeController;
  late TextEditingController inactiveController;
  late TextEditingController pausedController;
  late TextEditingController detachedController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    resumeController = SaveState.getValue(key: "resume") != null
        ? TextEditingController(
            text: SaveState.getValue(key: 'resume').toString())
        : TextEditingController(text: 0.toString());

    inactiveController = SaveState.getValue(key: "inactive") != null
        ? TextEditingController(
            text: SaveState.getValue(key: 'inactive').toString())
        : TextEditingController(text: 0.toString());

    pausedController = SaveState.getValue(key: "paused") != null
        ? TextEditingController(
            text: SaveState.getValue(key: 'paused').toString())
        : TextEditingController(text: 0.toString());

    detachedController = SaveState.getValue(key: "detached") != null
        ? TextEditingController(
            text: SaveState.getValue(key: 'detached').toString())
        : TextEditingController(text: 0.toString());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        print("resumed");
        SaveState.save(key: "resume", value: 1);
        break;
      case AppLifecycleState.inactive:
        print("inactive");
        SaveState.save(key: "inactive", value: 1);
        break;
      case AppLifecycleState.paused:
        print("paused");
        SaveState.save(key: "paused", value: 1);
        break;
      case AppLifecycleState.detached:
        print("detached");
        SaveState.save(key: "detached", value: 1);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 23.0, right: 23),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text("App life Cycle state"),
              const SizedBox(
                height: 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "App in Foreground",
                    style: TextStyle(color: Color(0XFF101817)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 13),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: TextFormField(
                        readOnly: true,
                        controller: resumeController,
                        decoration: const InputDecoration(
                            hintText: "Resume here", border: InputBorder.none)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "App in inactive",
                    style: TextStyle(color: Color(0XFF101817)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 13),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: TextFormField(
                        readOnly: true,
                        controller: inactiveController,
                        decoration: const InputDecoration(
                            hintText: "Resume here", border: InputBorder.none)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "App in paused",
                    style: TextStyle(color: Color(0XFF101817)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 13),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: TextFormField(
                        readOnly: true,
                        controller: pausedController,
                        decoration: const InputDecoration(
                            hintText: "Resume here", border: InputBorder.none)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "App in Detached",
                    style: TextStyle(color: Color(0XFF101817)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 13),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: TextFormField(
                        readOnly: true,
                        controller: detachedController,
                        decoration: const InputDecoration(
                            hintText: "Resume here", border: InputBorder.none)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
