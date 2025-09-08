import 'package:flutter/material.dart';
import 'package:open_arch_browser/resources/string_manager.dart';
import 'package:open_arch_browser/resources/values_manager.dart';

class ArcMiniWindow extends StatelessWidget {
  final VoidCallback onClose;

  const ArcMiniWindow({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSize.s12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.s12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: AppSize.s12,
            offset: Offset(AppSize.s0, AppSize.s4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: AppStrings.searchHint,
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      Navigator.of(context).pop(); // close overlay
                    }
                  },
                ),
              ),
              IconButton(icon: const Icon(Icons.close), onPressed: onClose),
            ],
          ),
          const Divider(),
          const ListTile(
              leading: Icon(Icons.public),
              title: Text(AppStrings.listTileTitlePlaceholder1)),
          const ListTile(
              leading: Icon(Icons.people),
              title: Text(AppStrings.listTileTitlePlaceholder1)),
        ],
      ),
    );
  }
}
