import 'package:open_arch_browser/model/TabModel.dart';
import '../local/browser_database_service.dart';
import 'tab_repository.dart';

class TabRepositoryImpl implements TabRepository {
  final BrowserDatabaseService _databaseService;

  TabRepositoryImpl(this._databaseService);

  @override
  Future<void> init() async {
    await _databaseService.init();
  }

  // Tab methods
  @override
  Future<void> insertTab(TabModel tab) async {
    await _databaseService.insertTab(tab);
  }

  @override
  Future<void> deleteTab(String id) async {
    await _databaseService.deleteTab(id);
  }

  @override
  Future<List<TabModel>> getAllTabs() async {
    return await _databaseService.getAllTabs();
  }

  @override
  Future<void> clearAllTabs() async {
    await _databaseService.clearAllTabs();
  }

}