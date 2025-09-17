import 'package:flutter/foundation.dart'; // for debugPrint
import 'package:open_arch_browser/model/RecentSearchModel.dart';
import '../local/browser_database_service.dart';
import '../repository/recent_search_repository.dart';

class RecentSearchRepositoryImpl implements RecentSearchRepository {
  final BrowserDatabaseService _databaseService;

  RecentSearchRepositoryImpl(this._databaseService);

  @override
  Future<void> init() async {
    debugPrint("🟡[RecentSearchRepo] Initializing RecentSearchRepository...");
    await _databaseService.init();
    debugPrint("✅[RecentSearchRepo] RecentSearchRepository initialized");
  }

  @override
  Future<void> insertRecentSearch(RecentSearchModel search) async {
    debugPrint("🟡[RecentSearchRepo] Inserting recent search: '${search.query}' (id=${search.id})");
    await _databaseService.insertRecentSearch(search);
    debugPrint("✅[RecentSearchRepo] Insert complete for '${search.query}'");
  }

  @override
  Future<void> deleteRecentSearch(String query) async {
    debugPrint("🟡[RecentSearchRepo] Deleting recent search: '$query'");
    await _databaseService.deleteRecentSearch(query);
    debugPrint("✅[RecentSearchRepo] Delete complete for '$query'");
  }

  @override
  Future<List<RecentSearchModel>> getAllRecentSearches() async {
    debugPrint("🟡 [RecentSearchRepo] Fetching all recent searches...");
    final results = await _databaseService.getAllRecentSearches();
    debugPrint("✅ [RecentSearchRepo] Retrieved ${results.length} recent search(es)");
    return results;
  }

  @override
  Future<void> clearAllRecentSearches() async {
    debugPrint("🟡 [RecentSearchRepo] Clearing all recent searches...");
    await _databaseService.clearAllRecentSearches();
    debugPrint("✅ [RecentSearchRepo] Cleared all recent searches");
  }
}