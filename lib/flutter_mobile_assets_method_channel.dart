import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_mobile_assets_platform_interface.dart';

/// An implementation of [FlutterMobileAssetsPlatform] that uses method channels.
class MethodChannelFlutterMobileAssets extends FlutterMobileAssetsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_mobile_assets');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getIosResourcePath(String resourceName, String resourceType) async {
    String? version = await methodChannel.invokeMethod<String>(
      'getIosResourcePath',
      {
        'resourceName': resourceName,
        'resourceType': resourceType,
      },
    );
    return version;
  }

  @override
  Future<String?> getExternalResourcePath() async {
    final version = await methodChannel.invokeMethod<String>('getExternalResourcePath');
    return version;
  }

  @override
  Future<bool?> copyAssetFolder(String srcName, {bool isDeleteOnExit = false}) async {
    final version = await methodChannel.invokeMethod<bool>(
      'copyAssetFolder',
      {
        'srcName': srcName,
        'isDeleteOnExit': isDeleteOnExit,
      },
    );
    return version;
  }

  @override
  Future<bool?> copyAssetFile(String srcName, {bool isDeleteOnExit = false}) async {
    final version = await methodChannel.invokeMethod<bool>(
      'copyAssetFile',
      {
        'srcName': srcName,
        'isDeleteOnExit': isDeleteOnExit,
      },
    );
    return version;
  }

  @override
  Future<bool?> deleteAsset(String srcName) async {
    final version = await methodChannel.invokeMethod<bool>(
      'deleteAsset',
      {
        'srcName': srcName,
      },
    );
    return version;
  }
}
