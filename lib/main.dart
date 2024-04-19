import 'package:flutter/material.dart';
import 'package:whitelabel/details.dart';
import 'settings.dart';
// import 'details.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppSettings theme = await AppSettings.fromJson({});

  runApp(Home(theme: theme));
}

class Home extends StatelessWidget {
  final AppSettings theme;

  const Home({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: theme.primaryColor,
        scaffoldBackgroundColor: theme.scaffoldBackgroundColor,
        fontFamily: theme.fontFamily,
        brightness: Brightness.dark,
      ),
      title: 'White Label App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(theme: theme),
        '/second': (context) => const DetailsPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final AppSettings theme;

  const HomePage({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: theme.kShowAppBar
          ? AppBar(title: Text(theme.kStatusBarHeader))
          : null,
      body: Container(
        decoration: BoxDecoration(
          gradient: theme.kGradientStyle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/header.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    theme.kMainHeader,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        theme.hotelAddress,
                        style: const TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/second');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.deepPurple,
                            title: const Text('Breakfast Info',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(color: Colors.white),
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: 'Mon to Fri',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text: ': ${theme.breakfastWeekdays}'),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(color: Colors.white),
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: 'Sat & Sun',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text: ': ${theme.breakfastWeekends}'),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(color: Colors.white),
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: 'Location',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text: ': ${theme.breakfastLocation}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            theme.buttonBackgroundColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    child: const Text('More Info'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
