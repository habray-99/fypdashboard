import 'dart:developer';

import 'package:fypdashboard/controller/dashboard/gym_page_controller.dart';
import 'package:fypdashboard/models/user_details.dart';
import 'package:get/get.dart';

import '../../models/gym_member.dart';
import '../../repo/gym_repo.dart';
import '../../utils/custom_snackbar.dart';

class MemberController extends GetxController {
  var memberList = RxList<GymMember>();
  var filteredMembers = RxList<GymMember>();
  var isLoading = true.obs;
  bool isSortedAscending = true;

  @override
  void onInit() {
    fetchMembers();
    super.onInit();
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
