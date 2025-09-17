import 'package:open_arch_browser/model/RecentSearchModel.dart';
import '../local/browser_database_service.dart';
import '../repository/recent_search_repository.dart';

class RecentSearchRepositoryImpl implements RecentSearchRepository {
  final BrowserDatabaseService _databaseService;

  RecentSearchRepositoryImpl(this._databaseService);

  @override
  Future<void> init() async {
    await _databaseService.init();
  }

  @override
  Future<void> insertRecentSearch(RecentSearchModel search) async {
    await _databaseService.insertRecentSearch(search);
  }

  @override
  Future<void> deleteRecentSearch(String id) async {
    await _databaseService.deleteRecentSearch(id);
  }

  @override
  Future<List<RecentSearchModel>> getAllRecentSearches() async {
    return await _databaseService.getAllRecentSearches();
  }

  @override
  Future<void> clearAllRecentSearches() async {
    await _databaseService.clearAllRecentSearches();
  }
}