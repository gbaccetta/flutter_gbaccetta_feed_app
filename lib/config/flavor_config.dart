import 'package:flutter_gbaccetta_feed_app/domain/models/app_color.dart';

enum Flavor { prod, dev }

class FlavorConfig {
  static FlavorConfig? _;
  static FlavorConfig get instance =>
      _ ?? (_ = FlavorConfig.initDevEnvironment());

  final Flavor _flavor;
  final String _appName;
  final AppColor _initialColor;
  final String _baseUrl;
  late final String _apiKey1;
  late final String _apiKey2;

  /// These are the public getters to use in our app
  static bool get isDev => instance._flavor == Flavor.dev;
  static Flavor get flavor => instance._flavor;
  static String get appName => instance._appName;
  static AppColor get initialColor => instance._initialColor;
  static String get baseUrl => instance._baseUrl;
  static String get apiKey1 => instance._apiKey1;
  static String get apiKey2 => instance._apiKey2;

  factory FlavorConfig.initDevEnvironment() {
    return _ = FlavorConfig._flavorConfig(
      flavor: Flavor.dev,
      appName: '[DEV] GBAccetta Feed',
      initialColor: AppColor.deepPurple,
      baseUrl: 'https://devbaseurl.com',
    );
  }

  factory FlavorConfig.initProdEnvironment() {
    return _ = FlavorConfig._flavorConfig(
      flavor: Flavor.prod,
      appName: 'GBAccetta Feed',
      initialColor: AppColor.green,
      baseUrl: 'https://prodbaseurl.com',
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
        _flavor = flavor {
    /// These are our app secrets from [flavor_secrets.json] file
    _apiKey1 = const String.fromEnvironment('SECRET_API_KEY_1');
    _apiKey2 = const String.fromEnvironment('SECRET_API_KEY_2');
  }
}
