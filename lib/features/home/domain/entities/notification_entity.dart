import 'package:fruits_app/core/utils/styles/app_images.dart';

class NotificationEntity {
  final String id;
  final String title;
  final String boldAmount;
  final String time;
  final String imageUrl;
  bool isRead;
  bool isSelected;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.boldAmount,
    required this.time,
    required this.imageUrl,
    this.isRead = false,
    this.isSelected = false,
  });

  static List<NotificationEntity> mockNewList() => [
    NotificationEntity(
      id: '1',
      title: ' على اسعار الفواكه بمناسبه العيد',
      boldAmount: 'خصم %50',
      time: '9 صباحاً',
      imageUrl: AppImages.imagesNotificationSale,
    ),
    NotificationEntity(
      id: '2',
      title: ' على اسعار الفواكه بمناسبه العيد',
      boldAmount: 'خصم %50',
      time: '9 صباحاً',
      imageUrl: AppImages.imagesNotificationDiscount,
    ),
    NotificationEntity(
      id: '3',
      title: ' على اسعار الفواكه بمناسبه العيد',
      boldAmount: 'خصم %50',
      time: '9 صباحاً',
      imageUrl: AppImages.imagesNotificationSale,
    ),
  ];

  static List<NotificationEntity> mockEarlierList() => [
    NotificationEntity(
      id: '4',
      title: ' على اسعار الفواكه بمناسبه العيد',
      boldAmount: 'خصم %50',
      time: '9 صباحاً',
      imageUrl: AppImages.imagesNotificationSale,
      isRead: true,
    ),
    NotificationEntity(
      id: '5',
      title: ' على اسعار الفواكه بمناسبه العيد',
      boldAmount: 'خصم %50',
      time: '9 صباحاً',
      imageUrl: AppImages.imagesNotificationDiscount,
      isRead: true,
    ),
    NotificationEntity(
      id: '6',
      title: ' على اسعار الفواكه بمناسبه العيد',
      boldAmount: 'خصم %50',
      time: '9 صباحاً',
      imageUrl: AppImages.imagesNotificationSale,
      isRead: true,
    ),
  ];
}
