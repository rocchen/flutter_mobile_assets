import Flutter
import UIKit

public class FlutterMobileAssetsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_mobile_assets", binaryMessenger: registrar.messenger())
    let instance = FlutterMobileAssetsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS222" + UIDevice.current.systemVersion)
    case "getIosResourcePath":
        let arguments = call.arguments as! Dictionary<String, Any?>
        let bundleName = arguments["resourceName"] as! String
        let bundleType = arguments["resourceType"] as! String
        let bundlePath = Bundle.main.path(forResource: bundleName, ofType: bundleType)
        result(bundlePath)

    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
}
