// package com.example.credit_card_scanner

// import androidx.annotation.NonNull

// import io.flutter.embedding.engine.plugins.FlutterPlugin
// import io.flutter.plugin.common.MethodCall
// import io.flutter.plugin.common.MethodChannel
// import io.flutter.plugin.common.MethodChannel.MethodCallHandler
// import io.flutter.plugin.common.MethodChannel.Result

// /** credit_card_scannerPlugin */
// class credit_card_scannerPlugin: FlutterPlugin, MethodCallHandler {
//   /// The MethodChannel that will the communication between Flutter and native Android
//   ///
//   /// This local reference serves to register the plugin with the Flutter Engine and unregister it
//   /// when the Flutter Engine is detached from the Activity
//   private lateinit var channel : MethodChannel

//   override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
//     channel = MethodChannel(flutterPluginBinding.binaryMessenger, "card_scanner_channel")
//     channel.setMethodCallHandler(this)
//   }

//   override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
//     if (call.method == "start_card_scanner_method") {
//       result.success("Android ${android.os.Build.VERSION.RELEASE}")
//     } else {
//       result.notImplemented()
//     }
//   }

//   override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
//     channel.setMethodCallHandler(null)
//   }
// }
