import 'package:get/get.dart';
import 'package:socialv/commanWidget/custom_snackbar.dart';
import 'package:socialv/model/apiModel/responseModel/meme_res_model.dart';
import 'package:socialv/model/apis/api_response.dart';
import 'package:socialv/viewModel/auth_view_model.dart';

class IntrestController extends GetxController {
  List selectedIndex = [];

  addIndex(index) {
    if (selectedIndex.contains(index) == false) {
      selectedIndex.add(index);
    } else if (selectedIndex.contains(index) == true) {
      selectedIndex.remove(index);
    }
    update();
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
        showSnackBar(message: "Something went wrong");
      }
    }
  }
}
