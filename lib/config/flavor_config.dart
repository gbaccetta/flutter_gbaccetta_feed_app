import 'package:flutter_gbaccetta_feed_app/domain/models/app_color.dart';

enum Flavor { prod, dev }

class FlavorConfig {
  final Flavor _flavor;
  final String _appName;
  final AppColor _initialColor;
  final String _baseUrl;

  static late final FlavorConfig _instance;

  /// These are the public getters to use in our app
  static bool get isDev => _instance._flavor == Flavor.dev;
  static Flavor get flavor => _instance._flavor;
  static String get appName => _instance._appName;
  static AppColor get initialColor => _instance._initialColor;
  static String get baseUrl => _instance._baseUrl;

  /// These are our app secrets from [flavor_secrets.json] file
  static String get apiKey1 => const String.fromEnvironment('SECRET_API_KEY_1');
  static String get apiKey2 => const String.fromEnvironment('SECRET_API_KEY_2');

  factory FlavorConfig.create({
    required String appName,
    required AppColor initialColor,
    required Flavor flavor,
    required String baseUrl,
  }) {
    return _instance = FlavorConfig._flavorConfig(
      flavor: flavor,
      appName: appName,
      initialColor: initialColor,
      baseUrl: baseUrl,
    );
  }

  FlavorConfig._flavorConfig({
    required String appName,
    required AppColor initialColor,
    required Flavor flavor,
    required String baseUrl,
  })  : _baseUrl = baseUrl,
        _initialColor = initialColor,
        _appName = appName,
        _flavor = flavor;
}
