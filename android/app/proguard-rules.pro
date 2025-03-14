# Keep all Stripe classes
-keep class com.stripe.android.** { *; }

# Specifically keep the missing classes mentioned in the error
-keep class com.stripe.android.pushProvisioning.PushProvisioningActivity$g { *; }
-keep class com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args { *; }
-keep class com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error { *; }
-keep class com.stripe.android.pushProvisioning.PushProvisioningActivityStarter { *; }
-keep class com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider { *; }
-keep class com.stripe.android.view.AddPaymentMethodActivityStarter$Args$Builder { *; }
-keep class com.stripe.android.view.AddPaymentMethodActivityStarter$Args { *; }
-keep class com.stripe.android.view.AddPaymentMethodActivityStarter$Result$Canceled { *; }
-keep class com.stripe.android.view.AddPaymentMethodActivityStarter$Result$Companion { *; }
-keep class com.stripe.android.view.AddPaymentMethodActivityStarter$Result$Failure { *; }
-keep class com.stripe.android.view.AddPaymentMethodActivityStarter$Result$Success { *; }
-keep class com.stripe.android.view.AddPaymentMethodActivityStarter$Result { *; }
-keep class com.stripe.android.view.AddPaymentMethodActivityStarter { *; }

# Additional rules that might be needed for Stripe SDK
-keep class com.stripe.android.model.** { *; }
-keep class com.stripe.android.core.** { *; }