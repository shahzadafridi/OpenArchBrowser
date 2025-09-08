// Custom Title Bar Widget
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class MacOSTitleBar extends StatelessWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onForwardTap;
  final VoidCallback? onRefreshTap;
  final VoidCallback? onAddressTap;
  final GlobalKey? searchBarKey;

  const MacOSTitleBar({
    Key? key,
    this.onBackTap,
    this.onForwardTap,
    this.onRefreshTap,
    this.onAddressTap,
    this.searchBarKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52, // macOS title bar height
      decoration: BoxDecoration(
        color: Color(0xFFE5E5E5), // macOS title bar color
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFD1D1D6),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // Traffic Light Buttons (Close, Minimize, Maximize)
          Container(
            width: 78, // Standard macOS spacing
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                // Close button (red)
                GestureDetector(
                  onTap: () => windowManager.close(),
                  child: Container(
                    width: 12,
                    height: 12,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF5F57),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFE0443E),
                        width: 0.5,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        size: 6,
                        color: Color(0xFFBF0A02),
                      ),
                    ),
                  ),
                ),
                // Minimize button (yellow)
                GestureDetector(
                  onTap: () => windowManager.minimize(),
                  child: Container(
                    width: 12,
                    height: 12,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFBD2E),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFDEA123),
                        width: 0.5,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 8,
                        height: 1,
                        color: Color(0xFFBF8E00),
                      ),
                    ),
                  ),
                ),
                // Maximize button (green)
                GestureDetector(
                  onTap: () async {
                    if (await windowManager.isMaximized()) {
                      windowManager.unmaximize();
                    } else {
                      windowManager.maximize();
                    }
                  },
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Color(0xFF28CA42),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFF1AAB29),
                        width: 0.5,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.fullscreen,
                        size: 6,
                        color: Color(0xFF006315),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Browser Navigation Controls
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                // Sidebar toggle (like your image)
                Container(
                  width: 28,
                  height: 28,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFD1D1D6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    Icons.view_sidebar,
                    size: 16,
                    color: Colors.black54,
                  ),
                ),

                // Back button
                GestureDetector(
                  onTap: onBackTap,
                  child: Container(
                    width: 28,
                    height: 28,
                    margin: EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),

                // Forward button
                GestureDetector(
                  onTap: onForwardTap,
                  child: Container(
                    width: 28,
                    height: 28,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),

                // Refresh button
                GestureDetector(
                  onTap: onRefreshTap,
                  child: Container(
                    width: 28,
                    height: 28,
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.refresh,
                      size: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Address Bar (Google search)
          Expanded(
            child: GestureDetector(
              onTap: onAddressTap,
              child: Container(
                key: searchBarKey,
                height: 32,
                margin: EdgeInsets.only(right: 20),
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xFFE1E1E1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Google icon
                    Container(
                      width: 16,
                      height: 16,
                      margin: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFF4285F4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Center(
                        child: Text(
                          'G',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Search text
                    Expanded(
                      child: Text(
                        'Google Workspace',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Draggable area for window movement
          GestureDetector(
            onPanStart: (details) {
              windowManager.startDragging();
            },
            child: Container(
              width: 50,
              height: 52,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}