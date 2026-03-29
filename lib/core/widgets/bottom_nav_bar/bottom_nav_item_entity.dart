import '../../utils/styles/app_images.dart';

class BottomNavBarEntity {
  final String activeIcon;
  final String inactiveIcon;
  final String title;

  BottomNavBarEntity({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.title,
  });
}

List<BottomNavBarEntity> get bottomNavigationBarItems => [
  BottomNavBarEntity(
    activeIcon: AppImages.imagesBottomNavBarActiveHome,
    inactiveIcon: AppImages.imagesBottomNavBarInactiveHome,
    title: 'الرئيسية',
  ),
  BottomNavBarEntity(
    activeIcon: AppImages.imagesBottomNavBarActiveProduct,
    inactiveIcon: AppImages.imagesBottomNavBarInactiveProduct,
    title: 'المنتجات',
  ),
  BottomNavBarEntity(
    activeIcon: AppImages.imagesBottomNavBarActiveShoppingCart,
    inactiveIcon: AppImages.imagesBottomNavBarInactiveShoppingCart,
    title: 'السلة',
  ),
  BottomNavBarEntity(
    activeIcon: AppImages.imagesBottomNavBarActiveProfile,
    inactiveIcon: AppImages.imagesBottomNavBarInactiveProfile,
    title: 'حسابي',
  ),
];
