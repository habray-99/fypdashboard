class Apis {
  static const baseUrl = "http://127.0.0.1/fyp_backend";
  static const loginUrl = "$baseUrl/apis/login.php";
  // gym owner
  static const registerGymUrl = "$baseUrl/Gym/AddGym.php";
  static const getGymByOwnerUrl = "$baseUrl/Gym/FetchAllGymByOwner.php";
  static const getGymByIdUrl = "$baseUrl/Gym/FetchGymById.php";
  static const updateGymUrl = "$baseUrl/Gym/updateGym.php";
  static const deleteGymUrl = "$baseUrl/Gym/removeGym.php";
  static const fetchAllMemberByGym = "$baseUrl/apis/FetchAllMemberByGym.php";
  static const fetchAllPaymentByGym = "$baseUrl/apis/FetchAllPayment.php";
  static const registerMember = "$baseUrl/payment/PaymentDone.php";
  // static const allPaymentsOfGym ="$baseUrl/";

  // admin
  static const allMembers = "$baseUrl/member/FetchAllMember.php";
  static const allGyms = "$baseUrl/Gym/FetchAllGym.php";
  static const allPayments = "$baseUrl/apis/FetchAllPayment.php";
  // static const allPayments ="$baseUrl/";
}
