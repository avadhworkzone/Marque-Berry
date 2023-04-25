import 'package:get/get.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/viewModel/auth_view_model.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/model/apiModel/responseModel/meme_res_model.dart';

class InterestController extends GetxController {
  List<Category> selectedCategoryList = [];
  List tempCategoryIndex = [];

  addIndex(String id, String name) {
    if (selectedCategoryList.isEmpty) {
      selectedCategoryList.add(Category(name: name, id: id));
      tempCategoryIndex.add(name);
    } else if (tempCategoryIndex.contains(name) == true) {
      final containIndex =
          selectedCategoryList.indexWhere((element) => element.name == name);
      if (containIndex > -1) {
        selectedCategoryList.removeAt(containIndex);
      }
      tempCategoryIndex.remove(name);
    } else {
      selectedCategoryList.add(Category(name: name, id: id));
      tempCategoryIndex.add(name);
    }
    update();
  }

  setPreference() async {
    await PreferenceUtils.setCategory(selectedCategoryList);
  }

  ///
  AuthViewModel authViewModel = Get.find<AuthViewModel>();

  Future<void> memeCategoryApiCall() async {
    await authViewModel.memeCategory();
    if (authViewModel.memeCategoryApiResponse.status == Status.COMPLETE) {
      MemeCategoryResModel memeResponse =
          authViewModel.memeCategoryApiResponse.data;

      if (memeResponse.status.toString() == "200") {
      } else {
        showSnackBar(
          message: memeResponse.msg ?? VariableUtils.somethingWentWrong,
        );
      }
    }
  }
}
