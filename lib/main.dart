import 'package:athma_kalari_app/features/assessment/provider/assessment_provider.dart';
import 'package:athma_kalari_app/features/authentication/providers/auth_provider.dart';
import 'package:athma_kalari_app/features/category/provider/category_provider.dart';
import 'package:athma_kalari_app/features/courses/provider/course_provider.dart';
import 'package:athma_kalari_app/features/home/providers/banner_provider.dart';
import 'package:athma_kalari_app/features/home/providers/search_provider.dart';
import 'package:athma_kalari_app/features/home/widgets/bottom_bar.dart';
import 'package:athma_kalari_app/features/my_courses/providers/my_courses_provider.dart';
import 'package:athma_kalari_app/features/splash/screen/splash_screen.dart';
import 'package:athma_kalari_app/features/sub_category/provider/sub_category_provider.dart';
import 'package:athma_kalari_app/general/services/dynamic_link_services.dart';
import 'package:athma_kalari_app/general/utils/app_colors.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/notification/provider/notification_provider.dart';
import 'features/user/provider/user_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BannerProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => SubCategoryProvider()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => MyCourseProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => AssessmentProvider()),
      ],
      child: MaterialApp(
        title: 'Athma Kalari',
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(
          fontFamily: 'urbanist',
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}





//START DATE : 2023-09-29