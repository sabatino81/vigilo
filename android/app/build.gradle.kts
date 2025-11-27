plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "{{PACKAGE_NAME_ANDROID}}"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "{{PACKAGE_NAME_ANDROID}}"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
    release {
        signingConfig = signingConfigs.getByName("debug")
        isMinifyEnabled = false
        isShrinkResources = false // ✅ forma corretta in Kotlin DSL

        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
    }

    // Product flavors for environment-specific builds
    flavorDimensions += "env"
    productFlavors {
        create("dev") {
            dimension = "env"
            // Flutter flavor for local development (fast iteration)
        }
        create("preview") {
            dimension = "env"
            // Flavor used for PR preview builds; keep applicationIdSuffix to allow side-by-side installs
            applicationIdSuffix = ".preview"
        }
        create("staging") {
            dimension = "env"
            // Staging pre-prod; use suffix to separate if desired
            applicationIdSuffix = ".staging"
        }
        create("prod") {
            dimension = "env"
            // Production flavor uses base applicationId
        }
    }

    debug {
        isMinifyEnabled = false
        isShrinkResources = false // ✅ anche qui se vuoi disattivarlo
    }
}

    compileOptions {
        // 🔸 Aggiornato a Java 17 per compatibilità con AGP 8.x
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true // 👈 Abilita il desugaring
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.android.material:material:1.12.0")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
