import 'package:art_sweetalert/art_sweetalert.dart';
import 'navigatorKey.dart';


void AlertSucess (String message){
  ArtSweetAlert.show(
      context: NavigationService.navigatorKey.currentContext!,
      artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.success,
          title: "Information",
          text: message,
      )
  );
}

void AlertWarning (String message){
  ArtSweetAlert.show(
      context: NavigationService.navigatorKey.currentContext!,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.warning,
        title: "Information",
        text: message,
      )
  );
}

void AlertFail(String message){
  ArtSweetAlert.show(
      context: NavigationService.navigatorKey.currentContext!,
      artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: "Information",
          text: message)
  );
}
