# Payments
Payments is a **FLUTTER** developed app to organize all your suscriptions!

## Functionality
All your Music, Video, Storage and other services can be stored in Payments. 

**You will be able to store**
- Name of the suscription
- Price
- Date of payment

**Classification**
- Classification by Icons
- Classifications by Colours

## Future implementarions
- Store all your daily payments
- Cloud backup
- Alerts before the payment date
- Tags

## Run

Remember to generate the code for your platform at the beggining with:

```shell
flutter create .
```

To generate the icons, they should be in assets folder and in `pubspec.yaml` after thar run:

```shell
dart run get
dart run flutter_launcher_icons:main
```
It is possible that gradle version is not compatible with the project, to fix it run:
```shell
cd android
./gradlew wrapper --gradle-version=7.6.1
```