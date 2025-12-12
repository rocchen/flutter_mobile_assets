import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_mobile_assets_method_channel.dart';

abstract class FlutterMobileAssetsPlatform extends PlatformInterface {
  /// Constructs a FlutterMobileAssetsPlatform.
  FlutterMobileAssetsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterMobileAssetsPlatform _instance = MethodChannelFlutterMobileAssets();

  /// The default instance of [FlutterMobileAssetsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterMobileAssets].
  static FlutterMobileAssetsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterMobileAssetsPlatform] when
  /// they register themselves.
  static set instance(FlutterMobileAssetsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getIosResourcePath(String resourceName, String resourceType) async {
    throw UnimplementedError('copyAssetFolder() has not been implemented.');
  }

  Future<String?> getExternalResourcePath() {
    throw UnimplementedError('getExternalResourcePath() has not been implemented.');
  }

  Future<bool?> copyAssetFolder(String srcName, {bool isDeleteOnExit = false}) async {
    throw UnimplementedError('copyAssetFolder() has not been implemented.');
  }

  Future<bool?> copyAssetFile(String srcName, {bool isDeleteOnExit = false}) async {
    throw UnimplementedError('copyAssetFile() has not been implemented.');
  }

  Future<bool?> deleteAsset(String srcName) async {
    throw UnimplementedError('deleteAsset() has not been implemented.');
  }
}
