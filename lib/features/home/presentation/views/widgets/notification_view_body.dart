import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/constants/app_constants.dart';
import 'package:fruits_app/core/widgets/custom_main_app_bar.dart';
import 'package:fruits_app/features/home/domain/entities/notification_entity.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/notification_item.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/notification_section_header.dart';

class NotificationViewBody extends StatefulWidget {
  const NotificationViewBody({super.key});

  @override
  State<NotificationViewBody> createState() => _NotificationViewBodyState();
}

class _NotificationViewBodyState extends State<NotificationViewBody> {
  late List<NotificationEntity> _newNotifications;
  late List<NotificationEntity> _earlierNotifications;

  @override
  void initState() {
    super.initState();
    _newNotifications = NotificationEntity.mockNewList();
    _earlierNotifications = NotificationEntity.mockEarlierList();
  }

  // ── Select All ─────────────────────────────────────────────────
  void _selectAllNew(bool selectAll) {
    setState(() {
      for (var n in _newNotifications) {
        n.isSelected = selectAll;
      }
    });
  }

  void _selectAllEarlier(bool selectAll) {
    setState(() {
      for (var n in _earlierNotifications) {
        n.isSelected = selectAll;
      }
    });
  }

  // ── Toggle single item ─────────────────────────────────────────
  void _toggleNew(int index) {
    setState(
      () => _newNotifications[index].isSelected =
          !_newNotifications[index].isSelected,
    );
  }

  void _toggleEarlier(int index) {
    setState(
      () => _earlierNotifications[index].isSelected =
          !_earlierNotifications[index].isSelected,
    );
  }

  bool get _allNewSelected => _newNotifications.every((n) => n.isSelected);

  bool get _allEarlierSelected =>
      _earlierNotifications.every((n) => n.isSelected);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: kTopPadding),
                const Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: kHorizontalPadding,
                  ),
                  child: CustomMainAppBar(title: 'الاشعارات'),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(
                    horizontal: kHorizontalPadding,
                  ),
                  child: NotificationSectionHeader(
                    label: 'جديد',
                    count: _newNotifications.length,
                    isAllSelected: _allNewSelected,
                    onSelectAll: _selectAllNew,
                  ),
                ),
                const SizedBox(height: 16),
                ..._newNotifications.asMap().entries.map(
                  (e) => NotificationItem(
                    notification: e.value,
                    onTap: () => _toggleNew(e.key),
                  ),
                ),
                const SizedBox(height: 11),

                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(
                    horizontal: kHorizontalPadding,
                  ),
                  child: NotificationSectionHeader(
                    label: 'في وقت سابق',
                    count: _earlierNotifications.length,
                    isAllSelected: _allEarlierSelected,
                    onSelectAll: _selectAllEarlier,
                  ),
                ),
                const SizedBox(height: 16),
                ..._earlierNotifications.asMap().entries.map(
                  (e) => NotificationItem(
                    notification: e.value,
                    onTap: () => _toggleEarlier(e.key),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
