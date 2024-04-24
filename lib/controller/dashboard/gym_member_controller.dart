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
  var isSortedAscending = true.obs;
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
    try {
      isLoading(true);
      await GetGymMembersRepo.getAllGymMembers(onSuccess: (members) {
        memberList.assignAll(members);
        filteredMembers.assignAll(members);
        isLoading(false);
        CustomSnackBar.success(
            message: "Members fetched successfully", title: "Success");
      }, onError: (message) {
        CustomSnackBar.error(message: message, title: "Error");
      });
    } catch (e) {
      CustomSnackBar.error(message: e.toString(), title: "Error");
    }
  }

  bool hasError = false;

  void fetchMembers() async {
    try {
      isLoading(true);
      var gymPageController = Get.put(GymPageController());
      await gymPageController.fetchGyms();
      var gymIds = gymPageController.gyms.map((gym) => gym.gymId).toList();
      Set<GymMember> allMembers = {};
      for (var gymId in gymIds) {
        await GetGymMembersRepo.getGymMembers(
          gymId: gymId,
          onSuccess: (members) {
            allMembers.addAll(members);
            // CustomSnackBar.success(
            //   message: "Members fetched successfully",
            //   title: "Success",
            // );
          },
          onError: (message) {
            // log("Error fetching members for gymId $gymId: $message");
            // CustomSnackBar.error(message: message, title: "Error");
            hasError = true;
          },
        );
      }

      memberList.assignAll(allMembers);
      filteredMembers.assignAll(allMembers);
      sortMembers();
      // memberList.value = allMembers;
      if (hasError == false) {
        CustomSnackBar.success(
          message: "Members fetched successfully",
          title: "Success",
        );
      } else {
        CustomSnackBar.error(
          message: "Failed to load all members",
          title: "Error",
        );
      }
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
    isSortedAscending.value = !isSortedAscending.value;
    sortMembers();
  }

  void sortMembers() {
    filteredMembers.sort((a, b) {
      int aIsValid = a.memberId ?? 0;
      int bIsValid = b.memberId ?? 0;

      if (isSortedAscending.value) {
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
