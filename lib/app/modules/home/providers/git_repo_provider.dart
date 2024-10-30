import 'dart:convert';

import 'package:get/get.dart';
import 'package:git_repo_fetcher/app/modules/home/model/repo_model.dart';
import 'package:http/http.dart' as http;

class GitHubService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<List<RepoModel>> fetchRepos(String username) async {
    final response = await http.get(Uri.parse('https://api.github.com/users/$username/repos'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((repo) => RepoModel.fromJson(repo)).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }


}
