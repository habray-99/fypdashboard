import 'dart:developer';

import 'package:fypdashboard/controller/dashboard/gym_page_controller.dart';
import 'package:get/get.dart';

import '../../models/gym_member.dart';
import '../../repo/gym_repo.dart';
import '../../utils/custom_snackbar.dart';
import '../../utils/storage_keys.dart';

class MemberController extends GetxController {
  var memberList = RxList<GymMember>();
  var filteredMembers = RxList<GymMember>();
  var isLoading = true.obs;
  bool isSortedAscending = true;
  var selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    if (StorageHelper.getUserType() == 0) {
      fetchAllMembers();
    } else {
      fetchMembers();
    }
    super.onInit();
  }

  Future<void> fetchAllMembers() async {
    // try {
    //   isLoading(true);
    //   var headers = {
    //     "Accept": "application/json",
    //     "Content-Type": "application/json",
    //   };
    //   http.Response response = await http.get(
    //     Uri.parse(Apis.allMembers),
    //     headers: headers,
    //   );

    //   dynamic data = json.decode(response.body);
    //   log(data.toString());
    //   if (response.statusCode == 200 && response.statusCode < 300) {
    //     List<GymMember> members = gymMembersFromJson(data["users"]);
    //     // onSuccess(gyms);
    //     memberList.assignAll(members);
    //     filteredMembers.assignAll(members);
    //     CustomSnackBar.success(
    //       title: "Success",
    //       message: "Members fetched successfully",
    //     );
    //   } else {
    //     // onError(data['message']);
    //     CustomSnackBar.error(title: "Error", message: "Failed to load members");
    //   }
    // } catch (e) {
    //   log(e.toString());
    //   // onError("Something went wrong");
    //   CustomSnackBar.error(title: "Error", message: "Failed to load members");
    // } finally {
    //   isLoading(false);
    // }
    try {
      isLoading(true);
      await GetGymMembersRepo.getAllGymMembers(onSuccess: (members) {
        memberList.assignAll(members);
        filteredMembers.assignAll(members);
      }, onError: (message) {
        CustomSnackBar.error(message: message, title: "Error");
      });
    } catch (e) {
      CustomSnackBar.error(message: e.toString(), title: "Error");
    }
  }

  void fetchMembers() async {
    try {
      isLoading(true);
      var gymPageController = Get.put(GymPageController());
      await gymPageController.fetchGyms();
      var gymIds = gymPageController.gyms.map((gym) => gym.gymId).toList();

      List<GymMember> allMembers = [];

      for (var gymId in gymIds) {
        await GetGymMembersRepo.getGymMembers(
          gymId: gymId.toString(),
          onSuccess: (members) {
            allMembers.addAll(members);
          },
          onError: (message) {
            log("Error fetching members for gymId $gymId: $message");
            CustomSnackBar.error(message: message, title: "Error");
          },
        );
      }

      memberList.assignAll(allMembers);
      filteredMembers.assignAll(allMembers);
      // memberList.value = allMembers;
      CustomSnackBar.success(
        message: "Members fetched successfully",
        title: "Success",
      );
    } finally {
      isLoading(false);
    }
  }

  void filterMembers(String searchText) {
    String lowerCaseSearchText = searchText.toLowerCase().trim();
    filteredMembers.value = memberList
        .where((member) =>
            (member.memberName?.toLowerCase().contains(lowerCaseSearchText) ??
                false) ||
            (member.memberEmail?.toLowerCase().contains(lowerCaseSearchText) ??
                false) ||
            (member.memberPhone?.toLowerCase().contains(lowerCaseSearchText) ??
                false))
        .toList();
  }

  void toggleSortOrder() {
    isSortedAscending = !isSortedAscending;
    sortMembers();
  }

  void sortMembers() {
    filteredMembers.sort((a, b) {
      int aIsValid = a.isValid ?? 0;
      int bIsValid = b.isValid ?? 0;

      if (isSortedAscending) {
        return bIsValid.compareTo(aIsValid);
      } else {
        return aIsValid.compareTo(bIsValid);
      }
    });
  }

  Future<void> addMember(GymMember member) {
    return GetGymMembersRepo.addGymMember(
      member: member,
      onSuccess: (message) {
        CustomSnackBar.success(
            message: 'Member Added successfully', title: "Success");
        fetchMembers();
      },
      onError: (message) {
        CustomSnackBar.error(message: message, title: "Error");
      },
    );
  }
}
