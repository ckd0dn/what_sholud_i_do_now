import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:what_sholud_i_do_now/data/repository/activity_repository_impl.dart';
import 'package:what_sholud_i_do_now/data/source/remote/bored_api.dart';
import 'package:what_sholud_i_do_now/data/source/remote/google_translation_api.dart';
import 'package:provider/provider.dart';
import 'package:what_sholud_i_do_now/presentation/activity/activity_view_model.dart';
import 'package:what_sholud_i_do_now/presentation/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //구글애드몹 SDK 초기화
  MobileAds.instance.initialize();

  //로컬 DB 초기화
  await Hive.initFlutter();

  await Hive.openBox('DB');

  //한글 로케일
  await initializeDateFormatting();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ActivityViewModel(
          ActivityRepositoryImpl(BoredApi(), GoogleTranslationApi()),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
          fontFamily: 'Jalnan',
          useMaterial3: true,
          primaryColor: Colors.deepPurple),
      themeMode: ThemeMode.system,
    );
  }
}
