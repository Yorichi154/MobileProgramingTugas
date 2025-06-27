import 'package:flutter/material.dart';
import '../pages/activity_intent_page.dart';
import '../pages/camera_page.dart';
import '../pages/google_maps_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/main_page.dart';
import '../pages/otp_page.dart';
import '../pages/profil.page.dart'; // New profile page
import '../pages/register_page.dart';
import '../pages/settings_page.dart';
import '../pages/stats_page.dart';

class AppRoutes {
  // Authentication routes
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';

  // Main app routes
  static const String home = '/home';
  static const String main = '/main';
  static const String profile = '/profile'; // New profile route

  // Feature routes
  static const String activityIntent = '/activity-intent';
  static const String camera = '/camera';
  static const String googleMaps = '/google-maps';
  static const String maps = '/maps';
  static const String settings = '/settings';
  static const String stats = '/stats';
  static const String webcam = '/webcam';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Authentication routes
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case AppRoutes.otp:
        return MaterialPageRoute(builder: (_) => const OtpPage());

      // Main app routes
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.main:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilPage());

      // Feature routes
      case AppRoutes.activityIntent:
        return MaterialPageRoute(builder: (_) => const ActivityIntentPage());
      case AppRoutes.camera:
        return MaterialPageRoute(builder: (_) => const CameraPage());
      case AppRoutes.googleMaps:
        return MaterialPageRoute(builder: (_) => const GoogleMapsPage());
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case AppRoutes.stats:
        return MaterialPageRoute(builder: (_) => const StatsPage());

      // Unknown route
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  // Helper method for pushing named routes with arguments
  static Future<T?> pushNamed<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  // Helper method for replacing the current route
  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    BuildContext context,
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return Navigator.of(context).pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  // Helper method for pushing named route and removing all others
  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    BuildContext context,
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamedAndRemoveUntil<T>(
      routeName,
      predicate,
      arguments: arguments,
    );
  }
}
