import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "app.jernash.kglam"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    signingConfigs {
       create("release") {
        keyAlias = keystoreProperties.getProperty("keyAlias")?.trim()
        keyPassword = keystoreProperties.getProperty("keyPassword")?.trim()
        storeFile = keystoreProperties.getProperty("storeFile")?.trim()?.let { file(it) }
        storePassword = keystoreProperties.getProperty("storePassword")?.trim()
    }
    }

    defaultConfig {
        applicationId = "app.jernash.kglam"
        minSdk = 25
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

  buildTypes {
    getByName("release") {
        signingConfig = signingConfigs.getByName("release")
        isMinifyEnabled = true       // Enable code shrinking
        isShrinkResources = true     // Enable resource shrinking
        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
    }
}
}

flutter {
    source = "../.."
}
