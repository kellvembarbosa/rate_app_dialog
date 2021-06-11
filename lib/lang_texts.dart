import 'dart:io';

import 'package:flutter/material.dart';

class Translate {
  final Map<String, Map<String, String>>? newTranslations;

  Translate({this.newTranslations});

  Map<String, Map<String, String>> get defaultTranslations => {
        "en": {
          "title": "Rating this App",
          "description":
              "Are you enjoying the app? \n Can you rate our app now?",
          "btnLater": "Later",
          "badRateDescription": "Tell us why you don't like this app?",
          "badRateTextAreaHinit": "Leave feedback here.",
          "badValidation": "Required!",
          "badBtnSend": "Submit",
          "goodRateDescription": "Help us rate our app on the PlayStore.",
          "goodBtnRate": "Rate now!",
          "like": "Like",
          "no": "No",
        },
        "es": {
          "title": "Calificación de esta app",
          "description":
              "¿Estás disfrutando la aplicación? \n ¿Puedes calificar nuestra aplicación ahora?",
          "btnLater": "Later",
          "badRateDescription": "Dinos por qué no te gusta esta aplicación?",
          "badRateTextAreaHinit": "Deje comentarios aquí.",
          "badValidation": "Requerido!",
          "badBtnSend": "Enviar",
          "goodRateDescription":
              "¡Ayúdanos a calificar nuestra aplicación en PlayStore!",
          "goodBtnRate": "Evaluar ahora!",
          "like": "Like",
          "no": "No",
        },
      };

  Map<String, Map<String, String>> get keys => checkNewsTranslates();

  Map<String, Map<String, String>> checkNewsTranslates() {
    if (newTranslations != null) {
      return {...defaultTranslations, ...newTranslations!};
    }
    return defaultTranslations;
  }
}

extension DateTimeExt on DateTime {
  int get daysSince => this.difference(DateTime.now()).inDays;
}

extension TransDialog on String {
  String translate(Translate tranlate) {
    String deviceLanguage = Platform.localeName.substring(0, 2);
    final defaultLocale = Locale('en', 'US');

    final translates = tranlate.keys[deviceLanguage] != null
        ? tranlate.keys[deviceLanguage]
        : tranlate.keys[defaultLocale.languageCode];

    final translated = translates![this];

    if (translated != null) {
      return translated;
    } else {
      return this;
    }
  }
}
