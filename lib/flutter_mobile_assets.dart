import 'flutter_mobile_assets_platform_interface.dart';

class FlutterMobileAssets {
  Future<String?> getPlatformVersion() {
    return FlutterMobileAssetsPlatform.instance.getPlatformVersion();
  }

  Future<String?> getIosResourcePath(String resourceName, String resourceType) async {
    return FlutterMobileAssetsPlatform.instance.getIosResourcePath(resourceName, resourceType);
  }

  Future<String?> getExternalResourcePath() {
    return FlutterMobileAssetsPlatform.instance.getExternalResourcePath();
  }

  Future<bool?> copyAssetFolder(String srcName, {bool isDeleteOnExit = false}) async {
    return FlutterMobileAssetsPlatform.instance.copyAssetFolder(srcName, isDeleteOnExit: isDeleteOnExit);
  }

  Future<bool?> copyAssetFile(String srcName, {bool isDeleteOnExit = false}) async {
    return FlutterMobileAssetsPlatform.instance.copyAssetFile(srcName, isDeleteOnExit: isDeleteOnExit);
  }

  Future<bool?> deleteAsset(String srcName) async {
    return FlutterMobileAssetsPlatform.instance.deleteAsset(srcName);
  }
}
