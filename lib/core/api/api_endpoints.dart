import 'package:peanut_app/core/config.dart';

class APIEndPoints {
  static const String loginEndPoint =
      '${Config.kBaseUrl}/ClientCabinetBasic/IsAccountCredentialsCorrect';

  static const String accountInformationEndPoint =
      '${Config.kBaseUrl}/ClientCabinetBasic/GetAccountInformation';

  static const String lastFourNumberEndPoint =
      '${Config.kBaseUrl}/ClientCabinetBasic/GetLastFourNumbersPhone';

  static const String openTradesEndPoint =
      '${Config.kBaseUrl}/ClientCabinetBasic/GetOpenTrades';
}
