// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:personal_expenses_app/home/pages/home_page.dart';
import 'package:personal_expenses_app/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        errorColor: const Color.fromARGB(255, 255, 128, 96),
        primaryColor: const Color.fromARGB(255, 46, 233, 133),
        appBarTheme:
            const AppBarTheme(color: Color.fromARGB(255, 46, 233, 133)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color.fromARGB(255, 46, 233, 133),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
