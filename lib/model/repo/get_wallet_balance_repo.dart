import 'package:socialv/model/apiModel/responseModel/get_wallet_balance_res_model.dart';
import 'package:socialv/model/apiService/api_service.dart';
import 'package:socialv/model/apiService/base_service.dart';
import 'package:socialv/utils/enum_utils.dart';

class GetWalletBalanceRepo extends BaseService {
  Future<GetWalletBalanceResModel> getWalletBalanceRepo() async {
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: '$baseURL$getWalletBalance',
    );

    return GetWalletBalanceResModel.fromJson(response);
  }
}
