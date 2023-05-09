import 'package:suzuki/util/mode_util.dart';

class ApiEndPoint {
  String baseUrl = "https://sfimos.sfi.co.id/survey/api/";
  String baseUrlDebug = "https://sfimos.sfi.co.id/survey/api/";
  // String baseUrl = "https://form.bagdja.com/api/";
  // String baseUrlDebug = "https://form.bagdja.com/api/";
  String webSocketUrl = "";
  String webSocketUrlDebug = "";
  String loginUrl = "auth/loginWithSFI";

  //sso
  String loginCMO = "https://uat.sfi.co.id/mobilesurvey_ci/TestApi/checklogin";
  //sso

  //application
  String applicationInbox = "application/inbox";
  String applicationFinished = "application/finished";
  String applicationFormRef = "application/formRef";
  String applicationForm = "application/form";
  String applicationConfirmReaded = "application/confirmRead";
  String applicationConfirmProcess = "application/confirmProcess";
  String applicationConfirmUploading = "application/confirmUploading";
  String applicationConfirmUploaded = "application/upload";
  String applicationConfirmFinished = "application/confirmFinish";
  String getValuesUrl = "application/value";
  //application

  //collection
  String collectionListUrl = "collection/list";
  String collectionDataUrl = "collection/data";
  //collection

  String get url {
    if (ModeUtil.debugMode == true) {
      return baseUrlDebug;
    } else {
      return baseUrl;
    }
  }

  String get wwebSocketUrl {
    if (ModeUtil.debugMode == true) {
      return webSocketUrlDebug;
    } else {
      return webSocketUrl;
    }
  }
}
