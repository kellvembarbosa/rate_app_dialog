package pt.kellvem.rate_app_dialog.rate_app_dialog

import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.sql.DriverManager.println
import java.util.*


/** RateAppDialogPlugin */
public class RateAppDialogPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  private lateinit var activity: Activity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, "rate_app_dialog")
    channel.setMethodCallHandler(this);
  }

  override fun onDetachedFromActivity() {

  }

  override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    this.activity = binding.activity;
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "rate_app_dialog")
      channel.setMethodCallHandler(RateAppDialogPlugin())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method){
    "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
    "getDeviceLang" -> {
      val currentLanguage = Locale.getDefault().language
      result.success(currentLanguage)
    }
    "sendEmail" -> {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.DONUT) {
        val email : String? = call.argument<String>("email")
        val bodyEmail : String? = call.argument<String>("bodyEmail")

        val emailArrray:Array<String> = arrayOf("$email")
        val intent = Intent(Intent.ACTION_SENDTO)

        intent.data = Uri.parse("mailto:")
        intent.putExtra(Intent.EXTRA_EMAIL, emailArrray)
        intent.putExtra(Intent.EXTRA_SUBJECT, "Feedback app name: ${this.activity.applicationInfo.loadLabel(this.activity.packageManager)} | package: ${this.activity.packageName} ")
        intent.putExtra(Intent.EXTRA_TEXT, bodyEmail)
        
        if (intent.resolveActivity(this.activity.packageManager) != null) {
          this.activity.startActivity(intent)
        }

        return result.success("sendEmail Feedback app name: ${this.activity.applicationInfo.loadLabel(this.activity.packageManager)} | package: ${this.activity.packageName} ")
      }
      return result.success("version android sdk not supported")
    }

    "openPlayStore" -> {
      var pacote:String = this.activity.packageName;
      try {
        activity.startActivity(
            Intent(
                Intent.ACTION_VIEW,
                Uri.parse("market://details?id=$pacote")
            )
        )
      } catch (exception: ActivityNotFoundException) {
        activity.startActivity(
            Intent(
                Intent.ACTION_VIEW,
                Uri.parse("https://play.google.com/store/apps/details?id=$pacote")
            )
        )
      }
      result.success(pacote)
    } else -> result.notImplemented()

    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}