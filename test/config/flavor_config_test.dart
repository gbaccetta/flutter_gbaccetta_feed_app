import 'package:flutter_gbaccetta_feed_app/config/flavor_config.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/app_color.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    test('DEV environment', () {
      FlavorConfig.initDevEnvironment();

      expect(FlavorConfig.flavor, Flavor.dev);
      expect(FlavorConfig.isDev, true);
      expect(FlavorConfig.appName, '[DEV] GBAccetta Feed');
      expect(FlavorConfig.initialColor, AppColor.deepPurple);
      expect(FlavorConfig.baseUrl, 'https://devbaseurl.com');
      expect(FlavorConfig.apiKey1, isA<String>());
      expect(FlavorConfig.apiKey2, isA<String>());
    });

    test('PROD environment', () {
      FlavorConfig.initProdEnvironment();

      expect(FlavorConfig.flavor, Flavor.prod);
      expect(FlavorConfig.isDev, false);
      expect(FlavorConfig.appName, 'GBAccetta Feed');
      expect(FlavorConfig.initialColor, AppColor.green);
      expect(FlavorConfig.baseUrl, 'https://prodbaseurl.com');
      expect(FlavorConfig.apiKey1, isA<String>());
      expect(FlavorConfig.apiKey2, isA<String>());
    });

}
