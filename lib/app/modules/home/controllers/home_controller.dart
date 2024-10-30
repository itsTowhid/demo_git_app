import 'package:get/get.dart';
import 'package:git_repo_fetcher/app/modules/home/model/repo_model.dart';
import 'package:git_repo_fetcher/app/modules/home/providers/git_repo_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var username = ''.obs;
  var repos = <RepoModel>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var isDarkMode = false.obs;

  final GitHubService _gitHubService = GitHubService();

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void fetchRepos() async {
    isLoading(true);
    isError(false);
    try {
      repos.value = await _gitHubService.fetchRepos(username.value);
    } catch (e) {
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  void toggleTheme() async {
    isDarkMode(!isDarkMode.value);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode.value);
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode(prefs.getBool('isDarkMode') ?? false);
  }
}