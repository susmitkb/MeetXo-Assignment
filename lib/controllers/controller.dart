// controllers/explore_experts_controller.dart
import 'package:get/get.dart';
import 'package:newproject/repos/expert_repository.dart';
import 'package:newproject/models/expert_model.dart';

class ExploreExpertsController extends GetxController {
  final ExpertRepository _repository = ExpertRepository();

  var experts = <Expert>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var selectedFilter = 'Top rated'.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var canLoadMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchExperts();
  }

  Future<void> fetchExperts() async {
    try {
      isLoading(true);
      hasError(false);
      errorMessage('');

      final response = await _repository.getExperts(page: currentPage.value);
      if (currentPage.value == 1) {
        experts.assignAll(response.hosts.hosts);
      } else {
        experts.addAll(response.hosts.hosts);
      }
      totalPages.value = response.hosts.pagination.totalPages;
      canLoadMore.value = currentPage.value < totalPages.value;
    } catch (e) {
      hasError(true);
      errorMessage(e.toString());
      if (currentPage.value == 1) {
        experts.clear();
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadMoreExperts() async {
    if (canLoadMore.value && !isLoading.value) {
      currentPage.value++;
      await fetchExperts();
    }
  }

  Future<void> refreshExperts() async {
    currentPage.value = 1;
    await fetchExperts();
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
    // Implement filtering logic here
    if (filter == 'Top rated') {
      experts.sort((a, b) => b.averageRating.compareTo(a.averageRating));
    } else if (filter == 'Advanced') {
      // Your advanced filtering logic
      experts.sort((a, b) => b.minSessionPrice.compareTo(a.minSessionPrice));
    }
  }
}