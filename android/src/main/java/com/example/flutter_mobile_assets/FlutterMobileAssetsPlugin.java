package com.example.flutter_mobile_assets;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import android.util.Log;
import android.content.Context;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
/** FlutterMobileAssetsPlugin */
public class FlutterMobileAssetsPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context applicationContext;
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_mobile_assets");
    channel.setMethodCallHandler(this);
    applicationContext = flutterPluginBinding.getApplicationContext();
    Log.d("FlutterAndroidAssetsPlugin", "插件初始化完成: ");
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("copyAssetFolder")) {
      String srcName = call.argument("srcName");
      boolean isDeleteOnExit = call.argument("isDeleteOnExit");
      boolean success = copyAssetPathFolder(srcName, isDeleteOnExit);
      result.success(success);
    } else if (call.method.equals("copyAssetFile")) {
      String srcName = call.argument("srcName");
      boolean isDeleteOnExit = call.argument("isDeleteOnExit");
      boolean success = copyFilePath(srcName, isDeleteOnExit);
      result.success(success);
    } else if (call.method.equals("deleteAsset")) {
      String srcName = call.argument("srcName");
      boolean success = deleteAsset(srcName);
      result.success(success);
    } else if (call.method.equals("getExternalResourcePath")) {
      String success = getExternalResourcePath();
      result.success(success);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  public String getExternalResourcePath() {
    if (applicationContext == null) {
      Log.e("TAG", "getExternalResourcePath: applicationContext为null");
      return null;
    }
    File externalDir = applicationContext.getExternalFilesDir("assets");
    if (externalDir == null) {

      return null;
    }
    String path = externalDir.getAbsolutePath() + "/resource/";
    return path;
  }

  public boolean deleteAsset(String srcName) {
    // 每次重新拷贝证书文件
    File path = new File(getExternalResourcePath(), srcName);
    path.deleteOnExit();
    return true;
  }

  public boolean copyAssetPathFolder(String srcName, boolean isDeleteOnExit) {
    File path = new File(getExternalResourcePath(), srcName);

    String dstName = path.getAbsolutePath();
    if (isDeleteOnExit) {
      path.deleteOnExit();
      return copyAssetFolder(srcName, dstName);
    }
    if (!path.exists()) {
      return copyAssetFolder(srcName, dstName);
    }

    return false;
  }

  public boolean copyFilePath(String srcName, boolean isDeleteOnExit) {
    File path = new File(getExternalResourcePath(), srcName);
    String dstName = path.getAbsolutePath();

    if (isDeleteOnExit) {
      path.deleteOnExit();
      return copyAssetFolder(srcName, dstName);
    }

    if (!path.exists()) {
      return copyAssetFile(srcName, dstName);
    }
    return false;
  }

  public boolean copyAssetFolder(String srcName, String dstName) {
    try {
      boolean result = true;
      String fileList[] = applicationContext.getAssets().list(srcName);
      if (fileList == null) return false;

      if (fileList.length == 0) {
        result = copyAssetFile(srcName, dstName);
      } else {
        File file = new File(dstName);
        result = file.mkdirs();
        for (String filename : fileList) {
          result &= copyAssetFolder(srcName + File.separator + filename, dstName + File.separator + filename);
        }
      }
      return result;
    } catch (IOException e) {
      e.printStackTrace();
      return false;
    }
  }


  public boolean copyAssetFile(String srcName, String dstName) {

    try {
      InputStream in = applicationContext.getAssets().open(srcName);
      File outFile = new File(dstName);
      OutputStream out = new FileOutputStream(outFile);
      byte[] buffer = new byte[1024];
      int read;
      long totalBytes = 0;
      while ((read = in.read(buffer)) != -1) {
        out.write(buffer, 0, read);
        totalBytes += read;
      }
      in.close();
      out.close();

      return true;
    } catch (IOException e) {
      e.printStackTrace();
      Log.e("TAG", "copyAssetFile: IO异常", e);
      return false;
    }
  }
}
