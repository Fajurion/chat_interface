import 'package:get/get.dart';

class GeneralTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {

    //* English US
    'en_US': {
      // Actions
      'create': 'Create',
      'ok': 'Okay',
      'retry': 'Retry',
      'back': 'Back',
      'no.got': 'No, you got me',
      'yeah': 'Yeah',
      'yes': 'Yes',
      'no': 'No',
      'change': 'Change',
      'save': 'Save',
      'delete': 'Delete',
      'select': 'Select',
      'zoom': 'Zoom',
      'x': 'X',
      'y': 'Y',

      // Time TODO: Differentiate between PM and AM
      'message.time': '@hour:@minute',
      'time.now': 'Today at @hour:@minute',
      'time': '@month/@day/@year @hour:@minute',
    },

    //* German
    'de_DE': {
      // Actions
      'create': 'Erstellen',
      'ok': 'Verstanden',
      'retry': 'Nochmal versuchen',
      'back': 'Zurück',
      'no.got': 'Nein, sorry',
      'yeah': 'Natürlich',
      'yes': 'Ja',
      'no': 'Nein',
      'change': 'Ändern',
      'save': 'Speichern',
      'delete': 'Löschen',
      'select': 'Auswählen',
      'zoom': 'Zoom',
      'x': 'X',
      'y': 'Y',

      // Time
      'message.time': '@hour:@minute',
      'time.now': 'Heute um @hour:@minute',
      'time': '@day.@month.@year @hour:@minute',
    }
  };
}