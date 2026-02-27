import 'package:fruits_app/core/utils/styles/app_images.dart';

class BottomNavigationBarEntity {
  final String activeIcon;
  final String inactiveIcon;
  final String title;

  BottomNavigationBarEntity({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.title,
  });
}

List<BottomNavigationBarEntity> get bottomNavigationBarItems => [
  BottomNavigationBarEntity(
    activeIcon: AppImages.imagesBottomNavBarActiveHome,
    inactiveIcon: AppImages.imagesBottomNavBarInactiveHome,
    title: 'الرئيسية',
  ),
  BottomNavigationBarEntity(
    activeIcon: AppImages.imagesBottomNavBarActiveProduct,
    inactiveIcon: AppImages.imagesBottomNavBarInactiveProduct,
    title: 'المنتجات',
  ),
  BottomNavigationBarEntity(
    activeIcon: AppImages.imagesBottomNavBarActiveShoppingCart,
    inactiveIcon: AppImages.imagesBottomNavBarInactiveShoppingCart,
    title: 'السلة',
  ),
  BottomNavigationBarEntity(
    activeIcon: AppImages.imagesBottomNavBarActiveProfile,
    inactiveIcon: AppImages.imagesBottomNavBarInactiveProfile,
    title: 'حسابي',
  ),
];
