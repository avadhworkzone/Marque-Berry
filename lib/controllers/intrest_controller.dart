import 'package:get/get.dart';
import 'package:socialv/utils/const_utils.dart';
import 'package:socialv/utils/shared_preference_utils.dart';
import 'package:socialv/utils/variable_utils.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/viewModel/auth_view_model.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/model/apiModel/responseModel/meme_res_model.dart';

class InterestController extends GetxController {
  List<Category> selectedIndex = [];
  List tempIndex = [];

  addIndex(String id, String name) {
    logs("ISSSSSSS $id   $name ${selectedIndex.length}");
    if (selectedIndex.isEmpty) {
      selectedIndex.add(Category(name: name, id: id));
      tempIndex.add(name);
    } else if (tempIndex.contains(name) == true) {
      selectedIndex.remove(Category(name: name, id: id));
      tempIndex.remove(name);
    } else {
      selectedIndex.add(Category(name: name, id: id));
      tempIndex.add(name);
    }
    logs("message ${selectedIndex.length}   ${tempIndex.length}");
    update();
  }

  setPreference() async {
    for (int i = 0; i < selectedIndex.length; i++) {
      await PreferenceUtils.setCategory(
        id: selectedIndex[i].id.toString(),
        name: selectedIndex[i].name.toString(),
      );
    }
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
