import java.util.Properties

val keyProperties = Properties()
val keyPropertiesFile = rootProject.file("key.properties")
if (keyPropertiesFile.exists()) {
    keyPropertiesFile.inputStream().use { keyProperties.load(it) }
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.brhantech.memhrey"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        // Required by flutter_local_notifications (come-back reminders)
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.brhantech.memhrey"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = 8
        versionName = "1.0.4"
    }

    signingConfigs {
        create("release") {
            storeFile = file(keyProperties["MEMHREY_STORE_FILE"].toString())
            storePassword = keyProperties["MEMHREY_STORE_PASSWORD"].toString()
            keyAlias = keyProperties["MEMHREY_KEY_ALIAS"].toString()
            keyPassword = keyProperties["MEMHREY_KEY_PASSWORD"].toString()
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Required by flutter_local_notifications (come-back reminders)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}