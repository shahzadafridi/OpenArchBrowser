import 'package:open_arch_browser/model/RecentSearchModel.dart';
import 'package:open_arch_browser/model/TabModel.dart';

abstract class TabRepository {
  // Tab methods
  Future<void> insertTab(TabModel tab);
  Future<void> deleteTab(String id);
  Future<List<TabModel>> getAllTabs();
  Future<void> clearAllTabs();
  Future<void> init();
}
