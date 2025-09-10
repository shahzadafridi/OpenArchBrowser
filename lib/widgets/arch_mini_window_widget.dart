import 'package:flutter/material.dart';
import 'package:open_arch_browser/resources/string_manager.dart';
import 'package:open_arch_browser/resources/values_manager.dart';

class ArcMiniWindow extends StatefulWidget {
  final VoidCallback onClose;
  final ValueChanged<String> onSearch; // callback with search text

  const ArcMiniWindow({
    super.key,
    required this.onClose,
    required this.onSearch,
  });

  @override
  State<ArcMiniWindow> createState() => _ArcMiniWindowState();
}

class _ArcMiniWindowState extends State<ArcMiniWindow> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
    });
  }

  void _onSubmit() {
    if (_controller.text.isNotEmpty) {
      widget.onSearch(_controller.text); // pass text to callback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSize.s8),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: AppStrings.searchHint,
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _onSubmit(),
                  ),
                ),
                IconButton(
                  icon: Icon(_hasText ? Icons.arrow_forward : Icons.clear),
                  onPressed: () {
                    if (_hasText) {
                      _onSubmit();
                    } else {
                      Navigator.of(context).pop(); // close overlay if needed
                    }
                  },
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.s16),
            child: Divider(),
          ),
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