import 'package:get/get.dart';

import '../models/activity.dart';

class ActivityController extends GetxController {
  final RxList<Activity> activities = <Activity>[].obs;
  final RxString selectedCategory = 'All'.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadActivities();
  }

  void loadActivities() {
    isLoading.value = true;
      activities.value = [
        Activity(
          id: '1',
          title: 'Beach Yoga',
          time: DateTime.now().add(const Duration(hours: 1)),
          duration: 55,
          location: 'BeachFit Studio',
          spotsLeft: 4,
          price: 9,
          category: 'Sports',
          intensity: 'light',hasChildcare: true,
        ),
        Activity(
          id: '2',
          title: 'Reformer Pilates',
          time: DateTime.now().add(const Duration(hours: 2)),
          duration: 60,
          location: 'Wellness Studio',
          spotsLeft: 4,
          price: 15,
          category: 'Sports',
          intensity: 'medium',hasChildcare: false,
        ),
        Activity(
          id: '3',
          title: '5-a-side Football',
          time: DateTime.now().add(const Duration(hours: 4)),
          duration: 60,
          location: 'Municipal Sports Center',
          spotsLeft: 0,
          price: 19,
          category: 'Sports',
          intensity: 'high',hasChildcare: true,
        ),
        Activity(
          id: '4',
          title: 'Standing Tapas Lunch',
          time: DateTime.now().add(const Duration(hours: 5)),
          duration: 60,
          location: 'Casa Marina',
          spotsLeft: 8,
          price: 15,
          category: 'Food',
          intensity: 'light', hasChildcare: true,
        ),
      ];
      isLoading.value = false;
  }

  List<Activity> get filteredActivities {
    if (selectedCategory.value == 'All') {
      return activities;
    }
    return activities.where((activity) =>
    activity.category == selectedCategory.value).toList();
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  final RxInt selectedNavIndex = 0.obs;

  void updateNavIndex(int index) {
    selectedNavIndex.value = index;
  }
}