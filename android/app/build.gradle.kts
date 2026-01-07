import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "app.jernash.kglam"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
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
        versionCode = 1
        versionName = "1"
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

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    // Firebase BoM (Bill of Materials)
    implementation(platform("com.google.firebase:firebase-bom:34.7.0"))

    // Firebase products
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-messaging")
}

flutter {
    source = "../.."
}
