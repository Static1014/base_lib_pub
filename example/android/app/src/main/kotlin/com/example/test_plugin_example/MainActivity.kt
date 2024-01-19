package com.example.base_lib_pub_example

import android.app.ActivityManager
import android.graphics.BitmapFactory
import android.os.Build
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    Log.i("MainActivity", "configureFlutterEngine")
  }

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)

    Log.i("MainActivity", "onCreate")
  }

  /**
   * 修复华为提版：您的应用存在隐藏最近任务列表名称的行为，不符合华为应用市场审核标准。
   * 解决Flutter重置setTaskDescription导致最近任务列表不显示应用名称的问题
   */
  override fun setTaskDescription(taskDescription: ActivityManager.TaskDescription?) {

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
      val builder = ActivityManager.TaskDescription.Builder()
      builder.setIcon(R.mipmap.ic_launcher)
      builder.setLabel(getString(R.string.app_name))
      super.setTaskDescription(builder.build())
    } else {
      val description: ActivityManager.TaskDescription
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
        description =
          ActivityManager.TaskDescription(getString(R.string.app_name), R.mipmap.ic_launcher)
      } else {
        description = ActivityManager.TaskDescription(
          getString(R.string.app_name),
          BitmapFactory.decodeResource(resources, R.mipmap.ic_launcher)
        )
      }
      super.setTaskDescription(description)
    }
  }
}
