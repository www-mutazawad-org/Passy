import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passy/common/assets.dart';
import 'package:passy/common/common.dart';
import 'package:passy/common/theme.dart';
import 'package:passy/passy_data/common.dart';
import 'package:passy/screens/backup_and_restore_screen.dart';
import 'package:passy/screens/biometric_auth_screen.dart';
import 'package:passy/screens/main_screen.dart';
import 'package:passy/screens/splash_screen.dart';
import 'package:passy/widgets/three_widget_button.dart';
import 'package:passy/widgets/passy_back_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const routeName = '${MainScreen.routeName}/settings';

  @override
  State<StatefulWidget> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PassyBackButton(onPressed: () => Navigator.pop(context)),
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(children: [
        ThreeWidgetButton(
          center: const Text('Backup & Restore'),
          left: const Icon(Icons.save_rounded),
          right: const Icon(Icons.arrow_forward_ios_rounded),
          onPressed: () => Navigator.pushNamed(
              context, BackupAndRestoreScreen.routeName,
              arguments: data.loadedAccount!.username),
        ),
        if (biometricStorageSupported)
          ThreeWidgetButton(
            center: const Text('Biometric authentication'),
            left: const Icon(Icons.fingerprint_rounded),
            right: const Icon(Icons.arrow_forward_ios_rounded),
            onPressed: () {
              Navigator.pushNamed(context, SplashScreen.routeName);
              Navigator.pushReplacementNamed(
                  context, BiometricAuthScreen.routeName);
            },
          ),
        ThreeWidgetButton(
          center: const Text('About'),
          left: const Icon(Icons.info_outline_rounded),
          right: const Icon(Icons.arrow_forward_ios_rounded),
          onPressed: () {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 24),
                          Center(
                              child: SvgPicture.asset(
                            logoSvg,
                            color: Colors.purple,
                            width: 128,
                          )),
                          const SizedBox(height: 32),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Passy ',
                              style: const TextStyle(fontFamily: 'FiraCode'),
                              children: [
                                TextSpan(
                                  text: 'v$passyVersion',
                                  style: TextStyle(
                                    color: lightContentSecondaryColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Account version: $accountVersion\nSync version: $syncVersion',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'FiraCode',
                              color: lightContentSecondaryColor,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Made with 💜 by Gleammer',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'FiraCode',
                            ),
                          ),
                          const SizedBox(height: 24),
                          ThreeWidgetButton(
                            left: SvgPicture.asset(
                              'assets/images/github_icon.svg',
                              width: 26,
                              color: lightContentColor,
                            ),
                            center: const Text('GitHub'),
                            right: const Icon(Icons.arrow_forward_ios_rounded),
                            onPressed: () =>
                                launch('https://github.com/GleammerRay/Passy'),
                          ),
                        ],
                      ),
                    ));
          },
        )
      ]),
    );
  }
}
