
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('GitHub Repository Fetcher'),
          actions: [
            IconButton(
              icon: Icon(controller.isDarkMode.value ? Icons.dark_mode : Icons.light_mode),
              onPressed: controller.toggleTheme,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'GitHub Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (value) => controller.username.value = value,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.fetchRepos,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Fetch Repos'),
              ),
              const SizedBox(height: 16),
              if (controller.isLoading.value)
                const CircularProgressIndicator()
              else if (controller.isError.value)
                Column(
                  children: [
                    const Text(
                      'Failed to load repositories',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: controller.fetchRepos,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.repos.length,
                    itemBuilder: (context, index) {
                      final repo = controller.repos[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(repo.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(repo.description),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Stars: ${repo.stargazersCount}'),
                              Text('Language: ${repo.language}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}