import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project/class/item_class.dart';
import 'package:project/pages/profile_page.dart';
import 'package:project/widget/card_widget.dart';
import 'package:project/core/notifiers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDark, child) {
        return MaterialApp(
          locale: _locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('pl', ''),
          ],
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Colors.blue,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: isDark ? Brightness.dark : Brightness.light,
            ),
            useMaterial3: true,
          ),
          home: HomePages(setLocale: setLocale),
        );
      },
    );
  }
}

class HomePages extends StatelessWidget {
  final Function(Locale) setLocale;
  const HomePages({Key? key, required this.setLocale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
        actions: <Widget>[
          ValueListenableBuilder<bool>(
            valueListenable: isDarkModeNotifier,
            builder: (_, isDark, __) => IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => isDarkModeNotifier.value = !isDark,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {

              Locale newLocale = Localizations.localeOf(context).languageCode == 'en'
                  ? const Locale('pl')
                  : const Locale('en');
              setLocale(newLocale);
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Nawigacja do ProfilePage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardWidget(
                box: ItemClass(
                    description: localizations.firstDescriptionArticle ,
                    title: localizations.firstTitleArticle,
                    imagePath: 'images/poprawione.jpg')),
            Row(
              children: [
                Expanded(
                  child: CardWidget(
                      box: ItemClass(
                          description: localizations.secondDescriptionArticle,
                          title: localizations.secondTitleArticle,
                          imagePath: 'images/Rekord.webp')),
                ),
                Expanded(
                  child: CardWidget(
                      box: ItemClass(
                          description: localizations.thirdTitleArticle,
                          title: localizations.thirdTitleArticle,
                          imagePath: 'images/rekordWSwieta.webp')),
                )
              ],
            ),
            CardWidget(
                box: ItemClass(
                    description: localizations.fourthDescriptionArticle,
                    title: localizations.fourthTitleArticle,
                    imagePath: 'images/WindAndPV.jpg')),
          ],
        ),
      ),
    );
  }
}
