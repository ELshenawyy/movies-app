import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/global/resources/app_color.dart';
import 'package:provider/provider.dart';
import '../../../movies/presentation/screens/movies_screen.dart';
import '../../../search/presentation/screens/search_view.dart';
import '../../../favourits/presentation/favoutite_screen.dart';
import '../../../settings/presentation/screens/settings_view_body.dart';
import '../manager/navigation_provider.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _getScreen(navigationProvider.currentPageIndex),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 52.h,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  iconPath: navigationProvider.currentPageIndex == 0
                      ? "assets/icons/Home_fill.svg"
                      : "assets/icons/Home_light.svg",
                  isSelected: navigationProvider.currentPageIndex == 0,
                  onTap: () => navigationProvider.setCurrentPageIndex(0),
                  isDarkMode: isDarkMode,
                ),
                _buildNavItem(
                  iconPath: navigationProvider.currentPageIndex == 1
                      ? "assets/icons/Search_fill.svg"
                      : "assets/icons/Search_duotone.svg",
                  isSelected: navigationProvider.currentPageIndex == 1,
                  onTap: () => navigationProvider.setCurrentPageIndex(1),
                  isDarkMode: isDarkMode,
                ),
                _buildNavItem(
                  iconPath: navigationProvider.currentPageIndex == 2
                      ? "assets/icons/Favorite_fill.svg"
                      : "assets/icons/Favorite_light.svg",
                  isSelected: navigationProvider.currentPageIndex == 2,
                  onTap: () => navigationProvider.setCurrentPageIndex(2),
                  isDarkMode: isDarkMode,
                ),
                _buildNavItem(
                  iconPath: navigationProvider.currentPageIndex == 3
                      ? "assets/icons/Setting_fill.svg"
                      : "assets/icons/Setting_line_light.svg",
                  isSelected: navigationProvider.currentPageIndex == 3,
                  onTap: () => navigationProvider.setCurrentPageIndex(3),
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
          ),
          // Animated underline
          AnimatedPositioned(
            bottom: 0,
            left: navigationProvider.currentPageIndex *
                (MediaQuery.of(context).size.width / 4), // Divides the width equally
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Container(
              width: MediaQuery.of(context).size.width / 4, // Each icon takes 1/4 of screen
              height: 4.h, // Height of the underline
              color: AppColors.gold, // Underline color
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build the navigation items
  Widget _buildNavItem({
    required String iconPath,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque, // Makes the whole area clickable
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 30.w,
              height: 30.h,
              color: isSelected
                  ? AppColors.gold
                  : (isDarkMode ? Colors.white54 : Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to return the current screen based on index
  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const MoviesScreen();
      case 1:
        return const SearchView();
      case 2:
        return FavoriteScreen();
      case 3:
        return const SettingsViewBody();
      default:
        return const MoviesScreen();
    }
  }
}
