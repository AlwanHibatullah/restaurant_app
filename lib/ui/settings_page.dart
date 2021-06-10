import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/styles/styles.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings_page';

  Widget _buildList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      children: [
        SafeArea(
            child: Align(
          alignment: Alignment.topLeft,
          child: InkWell(
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 18),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: secondaryColor,
                ),
                child: Icon(Icons.arrow_back, color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        )),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 18, 18, 10),
          child: Text(
            "Settings",
            style: GoogleFonts.playfairDisplay(
                fontSize: 36, fontWeight: FontWeight.w700, height: 1.25),
          ),
        ),
        Consumer<SettingsProvider>(
          builder: (context, provider, _) {
            return Material(
              child: ListTile(
                title: Text(
                  'Enable Daily Notifications',
                  style: GoogleFonts.raleway(fontWeight: FontWeight.w600),
                ),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                        value: provider.isDailyNotificationActive,
                        onChanged: (value) async {
                          if (Platform.isAndroid) {
                            scheduled.scheduledNotification(value);
                            provider.enableDailyNotification(value);
                          } else {
                            showCupertinoDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text('Coming Soon'),
                                    content: Text(
                                        'This feature will be coming soon!'),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                        });
                  },
                ),
              ),
              color: supportColor3,
            );
          },
        ),
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            return ListTile(
              title: Text(
                'App Version',
                style: GoogleFonts.raleway(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(snapshot.hasData ? snapshot.data!.version : '',
                  style: GoogleFonts.raleway()),
            );
          },
        )
      ],
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildList(context),
    );
  }

  Widget _buildIOS(BuildContext context) {
    return CupertinoPageScaffold(child: _buildAndroid(context));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIOS);
  }
}
