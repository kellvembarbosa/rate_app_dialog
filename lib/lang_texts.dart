class LangTexts {
  var text = {
    "en": {
      "title": "Rating this App",
      "description": "Are you enjoying the app? \n Can you rate our app now?",
      "btnLater": "Later",
      "badRateDescription": "Tell us why you don't like this app?",
      "badRateTextAreaHinit": "Leave feedback here.",
      "badValidation": "Required!",
      "badBtnSend": "Submit",
      "goodRateDescription": "Help us rate our app on the PlayStore.",
      "goodBtnRate": "Rate now!",
    },
    "pt": {
      "title": "Avalie este app",
      "description": "Você está gostando do app? \n Pode avaliar nosso app agora? ",
      "btnLater": "Depois",
      "badRateDescription": "Diga-nos por que você não gosta deste aplicativo?",
      "badRateTextAreaHinit": "Deixe aqui sua avaliação.",
      "badValidation": "Necessário!",
      "badBtnSend": "Enviar",
      "goodRateDescription": "Ei, Ajuda aí, avalie nosso app na PlayStore!",
      "goodBtnRate": "Avaliar agora!"
    },
    "es": {
      "title": "Calificación de esta app",
      "description": "¿Estás disfrutando la aplicación? \n ¿Puedes calificar nuestra aplicación ahora?",
      "btnLater": "Later",
      "badRateDescription": "Dinos por qué no te gusta esta aplicación?",
      "badRateTextAreaHinit": "Deje comentarios aquí.",
      "badValidation": "Requerido!",
      "badBtnSend": "Enviar",
      "goodRateDescription": "¡Ayúdanos a calificar nuestra aplicación en PlayStore!",
      "goodBtnRate": "Evaluar ahora!"
    },
  };

  get langText => text.values.toList();
}
