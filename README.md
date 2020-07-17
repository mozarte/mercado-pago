# Flutter Projeto
# Mercado pago SDK 


alterar no arquivo : Android/app/build.gradle


   defaultConfig {
        ...
          minSdkVersion 19
       
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.debug
        }
    }
}

flutter {
    source '../..'
}

dependencies {
    ...
    implementation 'com.android.support:multidex:1.0.3'
    implementation 'androidx.multidex:multidex:2.0.1'
   

}
