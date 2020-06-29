# rate_app_dialog

Para adicionar este pacote ao seu projeto será necessário colocar isto ao seu pubspec:

```dart 
  rate_app_dialog:
    git:
      url: git://github.com/kellvembarbosa/rate_app_dialog.git
      ref: master 
```

Para chamar o dialog request, adicione o seguinte código onde acredita ser um bom local para pedir a avaliação:

```dart 
RateAppDialog(
      context: context, minimeRateIsGood: 4, minimeRequestToShow: 15)
  .requestRate();
```

1.  **context:** é obrigatório.
2. **minimeRateIsGood:** Atribuito opicional, define o numero de estrelas que será solicitado para avaliação na loja. (default: 4)
3. **minimeRequestToShow:** Atributo opicional, define o numero de requisições para exibir o popup solicitando as estrelas. (default: 5)

##### ** Para que seja contabilizado e exibido será necessário chamar o metodo requestRate();

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

