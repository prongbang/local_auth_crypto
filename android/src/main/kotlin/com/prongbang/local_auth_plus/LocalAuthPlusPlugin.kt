package com.prongbang.local_auth_plus

import android.util.Log
import androidx.annotation.NonNull
import androidx.fragment.app.FragmentActivity
import com.prongbang.securebiometric.*
import com.prongbang.securebiometric.cipher.BiometricCryptography
import com.prongbang.securebiometric.cipher.Cryptography
import com.prongbang.securebiometric.token.BiometricToken

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class LocalAuthPlusPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private val cryptography: Cryptography = BiometricCryptography.newInstance()
    private var activity: FragmentActivity? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "local_auth_plus")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            LocalAuthMethod.ENCRYPT -> {
                val bioPayload = call.argument<String?>(LocalAuthArgs.BIO_PAYLOAD)
                if (bioPayload != null) {
                    val cipherText = cryptography.encrypt(bioPayload)
                    result.success(cipherText)
                } else {
                    result.error("E01", "Biometric token is null", null)
                }
            }
            LocalAuthMethod.AUTHENTICATE -> {
                val cipher = call.argument<String?>(LocalAuthArgs.BIO_CIPHER_TEXT)
                if (cipher == null) {
                    result.error("E03", "Cipher is null", null)
                    return
                }
                val title = call.argument<String?>(LocalAuthArgs.BIO_TITLE)
                val subtitle = call.argument<String?>(LocalAuthArgs.BIO_SUBTITLE)
                val description = call.argument<String?>(LocalAuthArgs.BIO_DESCRIPTION)
                val negativeButton = call.argument<String?>(LocalAuthArgs.BIO_NEGATIVE_BUTTON)
                val promptInfo = Biometric.PromptInfo(
                    title = title ?: "",
                    subtitle = subtitle ?: "",
                    description = description ?: "",
                    negativeButton = negativeButton ?: ""
                )

                val biometricPromptManagerResult = object : SecureBiometricPromptManager.Result {
                    override fun callback(biometric: Biometric) {
                        when (biometric.status) {
                            Biometric.Status.SUCCEEDED -> {
                                result.success(biometric.decrypted)
                            }
                            Biometric.Status.ERROR -> {
                                result.error("E04", "Authenticate is error", null)
                            }
                            Biometric.Status.CANCEL -> {
                                result.error("E05", "Authenticate is cancel", null)
                            }
                        }
                    }
                }

                activity?.let {
                    val biometricToken = object : BiometricToken {
                        override fun cipherText(): String = cipher
                    }

                    val biometricManager = SecureBiometricPromptManager.newInstance(
                        it,
                        biometricToken
                    )
                    biometricManager.authenticate(promptInfo, biometricPromptManagerResult)
                } ?: run {
                    result.error("E02", "Activity is null", null)
                }
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        activity = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity as? FragmentActivity
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity as? FragmentActivity
    }

    override fun onDetachedFromActivity() {}
}
