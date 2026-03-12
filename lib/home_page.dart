import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:compassretro/parse_locale_tag.dart';
import 'package:compassretro/theme_color.dart';
import 'package:compassretro/theme_mode_number.dart';
import 'package:compassretro/setting_page.dart';
import 'package:compassretro/ad_banner_widget.dart';
import 'package:compassretro/ad_manager.dart';
import 'package:compassretro/model.dart';
import 'package:compassretro/compass.dart';
import 'package:compassretro/loading_screen.dart';
import 'package:compassretro/main.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});
  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> with SingleTickerProviderStateMixin {
  final AdManager _adManager = AdManager();
  late ThemeColor _themeColor;
  bool _isReady = false;
  bool _isFirst = true;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() async {
    if (mounted) {
      setState(() {
        _isReady = true;
      });
    }
  }

  @override
  void dispose() {
    _adManager.dispose();
    super.dispose();
  }

  Future<void> _onOpenSetting() async {
    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const SettingPage()),
    );
    if (!mounted) {
      return;
    }
    if (updated == true) {
      final mainState = context.findAncestorStateOfType<MainAppState>();
      if (mainState != null) {
        mainState
          ..themeMode = ThemeModeNumber.numberToThemeMode(Model.themeNumber)
          ..locale = parseLocaleTag(Model.languageCode)
          ..setState(() {});
      }
      _isFirst = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return Scaffold(
        body: LoadingScreen(),
      );
    }
    if (_isFirst) {
      _isFirst = false;
      _themeColor = ThemeColor(themeNumber: Model.themeNumber, context: context);
    }
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double bgSize = max(screenWidth, screenHeight);
    return ChangeNotifierProvider<Compass>(
      create: (_) => Compass(),
      child: Consumer<Compass>(
        builder: (context, compass, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(_themeColor.compassBody,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Transform.rotate(
                    angle: compass.angle,
                    child: SizedBox(
                      width: bgSize,
                      height: bgSize,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.asset(_themeColor.compassNeedle),
                      ),
                    ),
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: _themeColor.mainForeColor,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: _onOpenSetting,
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                body: Container(),
                bottomNavigationBar: AdBannerWidget(adManager: _adManager),
              ),
            ],
          );
        },
      ),
    );
  }

}
