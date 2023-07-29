
import '../../models/account_info_parent_model.dart';

abstract class IAccountInformationDataSource {

  Future<AccountInfoParentModel> getAccountInformation();
}
