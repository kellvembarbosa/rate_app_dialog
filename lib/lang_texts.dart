class LangTexts {
  var text = {
    "en": {
      "title": "Rating this App",
      "description": "Are you enjoying the app? \n Can you rate our app now?",
      "btnLater": "Later",
      "badRateDescription": "Tell us why you don't like this app?",
      "badBtnSend": "Submit",
      "goodRateDescription": "Help us rate our app on the PlayStore.",
      "gootBtnRate": "Rate now!"
    },
    "pt": {
      "title": "Avalie este app",
      "description": "Você está gostando do app? \n Pode avaliar nosso app agora? ",
      "btnLater": "Depois",
      "badRateDescription": "Diga-nos por que você não gosta deste aplicativo?",
      "badBtnSend": "Enviar",
      "goodRateDescription": "Ei, Ajuda aí, avalie nosso app na PlayStore!",
      "gootBtnRate": "Avaliar agora!"
    },
    "es": {
      "title": "Calificación de esta app",
      "description": "¿Estás disfrutando la aplicación? \n ¿Puedes calificar nuestra aplicación ahora?",
      "btnLater": "Later",
      "badRateDescription": "Dinos por qué no te gusta esta aplicación?",
      "badBtnSend": "Enviar",
      "goodRateDescription": "¡Ayúdanos a calificar nuestra aplicación en PlayStore!",
      "gootBtnRate": "Evaluar ahora!"
    },
  };

  get langText => text.values.toList();
}
