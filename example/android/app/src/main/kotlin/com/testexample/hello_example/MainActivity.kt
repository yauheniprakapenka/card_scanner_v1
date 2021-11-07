package com.testexample.credit_card_scanner

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.view.FlutterMain
import android.os.Bundle
import android.content.Intent
import android.graphics.Color
import android.util.Log
import com.google.gson.Gson
import io.card.payment.CreditCard
import io.card.payment.CardIOActivity

private object ChannelStrings {
  const val CHANNEL_NAME = "card_scanner_channel"
  const val START_CARD_SCANNER_METHOD = "start_card_scanner_method"
  const val RETRIEVE_CARD_METHOD = "retrieve_card_method"
}

class MainActivity: FlutterActivity() {
  private val scanCardRequestCode = 1

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)

    MethodChannel(flutterEngine!!.getDartExecutor(), ChannelStrings.CHANNEL_NAME).setMethodCallHandler { call, result -> 
      if (call.method == ChannelStrings.START_CARD_SCANNER_METHOD) {
            val intent = Intent(this@MainActivity, CardIOActivity::class.java)
                .putExtra(CardIOActivity.EXTRA_HIDE_CARDIO_LOGO, true)
                .putExtra(CardIOActivity.EXTRA_KEEP_APPLICATION_THEME, true)
                .putExtra(CardIOActivity.EXTRA_SUPPRESS_MANUAL_ENTRY, true)
                .putExtra(CardIOActivity.EXTRA_SUPPRESS_CONFIRMATION, true)
                .putExtra(CardIOActivity.EXTRA_REQUIRE_EXPIRY, true)
                .putExtra(CardIOActivity.EXTRA_SCAN_EXPIRY, true)
                .putExtra(CardIOActivity.EXTRA_REQUIRE_CARDHOLDER_NAME, true)
                .putExtra(CardIOActivity.EXTRA_LANGUAGE_OR_LOCALE, "ru")
                .putExtra(CardIOActivity.EXTRA_GUIDE_COLOR, Color.GREEN)
                .putExtra(CardIOActivity.EXTRA_RETURN_CARD_IMAGE, false)
                .putExtra(CardIOActivity.EXTRA_USE_PAYPAL_ACTIONBAR_ICON, false)
            startActivityForResult(intent, scanCardRequestCode)
      } 
    }
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == scanCardRequestCode && data != null && data.hasExtra(CardIOActivity.EXTRA_SCAN_RESULT)) {
            data.getParcelableExtra<CreditCard>(CardIOActivity.EXTRA_SCAN_RESULT).let { card ->
                val gson = Gson()
                val jsonString = gson.toJson(card)
                // Log.d("TAG", "card: ${jsonString}") // Example: {"cardNumber":"5435537029240612","expiryMonth":2,"expiryYear":2023,"flipped":false,"scanId":"3925c777-a146-4b01-8188-11ae27260ee3","xoff":[42,60,78,95,131,149,167,184,220,238,256,273,309,327,345,362],"yoff":145}
                MethodChannel(flutterEngine!!.getDartExecutor(), ChannelStrings.CHANNEL_NAME).invokeMethod(
                  ChannelStrings.RETRIEVE_CARD_METHOD, jsonString.toString()
                )
            }
        } else {
            super.onActivityResult(requestCode, resultCode, data)
        }
    }
}
