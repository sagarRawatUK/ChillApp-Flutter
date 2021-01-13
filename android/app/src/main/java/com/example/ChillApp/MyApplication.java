package com.example.ChillApp;
import io.flutter.app.FlutterApplication;
import io.flutter.plugins.androidalarmmanager.AlarmService;
import io.flutter.plugins.androidalarmmanager.AndroidAlarmManagerPlugin;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.plugins.GeneratedPluginRegistrant;

@SuppressWarnings("deprecation")
public class MyApplication extends FlutterApplication
    implements io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback {
  @Override
  public void onCreate() {
    super.onCreate();
    AlarmService.setPluginRegistrant(this);
  }

  @Override
  @SuppressWarnings("deprecation")
  public void registerWith(io.flutter.plugin.common.PluginRegistry registry) {
    AndroidAlarmManagerPlugin.registerWith(
        registry.registrarFor("io.flutter.plugins.androidalarmmanager.AndroidAlarmManagerPlugin"));
  }
}