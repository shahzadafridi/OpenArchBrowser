import 'package:open_arch_browser/model/RecentSearchModel.dart';

abstract class RecentSearchRepository {
  Future<void> init();
  Future<void> insertRecentSearch(RecentSearchModel search);
  Future<void> deleteRecentSearch(String query);
  Future<List<RecentSearchModel>> getAllRecentSearches();
  Future<void> clearAllRecentSearches();
}

