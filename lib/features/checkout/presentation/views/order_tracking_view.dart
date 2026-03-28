// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fruits_app/core/utils/constants/app_constants.dart';
// import 'package:fruits_app/core/utils/styles/app_colors.dart';
// import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
// import 'package:fruits_app/core/widgets/app_primary_button.dart';
// import 'package:fruits_app/core/widgets/app_text_widget.dart';
// import 'package:fruits_app/core/widgets/custom_main_app_bar.dart';
// import 'package:fruits_app/features/checkout/domain/entities/order_status.dart';
// import 'package:fruits_app/features/checkout/domain/entities/order_tracking_entity.dart';
// import 'package:fruits_app/features/checkout/presentation/manager/cubit/order_tracking_cubit/order_tracking_cubit.dart';

// class OrderTrackingView extends StatelessWidget {
//   const OrderTrackingView({super.key, required this.orderId});

//   static const routeName = 'order_tracking';
//   final String orderId;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => OrderTrackingCubit()..watchOrder(orderId),
//       child: const _OrderTrackingScaffold(),
//     );
//   }
// }

// class _OrderTrackingScaffold extends StatelessWidget {
//   const _OrderTrackingScaffold();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
//           child: Column(
//             children: [
//               const SizedBox(height: kTopPadding),
//               const CustomMainAppBar(
//                 title: 'تتبع الطلب',
//                 isShowNotification: false,
//               ),
//               const SizedBox(height: 24),
//               Expanded(child: _buildBody()),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBody() {
//     return BlocBuilder<OrderTrackingCubit, OrderTrackingState>(
//       builder: (context, state) {
//         return switch (state) {
//           OrderTrackingInitial() || OrderTrackingLoading() => const Center(
//             child: CircularProgressIndicator(color: AppColors.green1_500),
//           ),
//           OrderTrackingFailure(:final message) => _ErrorView(message: message),
//           OrderTrackingLoaded(:final order) => _TrackingContent(order: order),
//         };
//       },
//     );
//   }
// }

// // ── Loaded content ──────────────────────────────────────────────────────────

// class _TrackingContent extends StatelessWidget {
//   const _TrackingContent({required this.order});
//   final OrderTrackingEntity order;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         _OrderInfoCard(order: order),
//         const SizedBox(height: 24),
//         Expanded(child: _StatusTimeline(currentStatus: order.status)),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: kTopPadding),
//           child: AppPrimaryButton(
//             text: 'الرئيسية',
//             onPressed: () => Navigator.pushNamedAndRemoveUntil(
//               context,
//               '/app_shell',
//               (_) => false,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ── Order info card ──────────────────────────────────────────────────────────

// class _OrderInfoCard extends StatelessWidget {
//   const _OrderInfoCard({required this.order});
//   final OrderTrackingEntity order;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Row(
//         textDirection: TextDirection.rtl,
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: AppColors.green1_500.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Icon(
//               Icons.inventory_2_outlined,
//               color: AppColors.green1_500,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 AppTextWidget(
//                   'طلب رقم: #${order.orderId.length > 10 ? order.orderId.substring(0, 10) : order.orderId}',
//                   style: AppTextStyles.styleBold16.copyWith(
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   textDirection: TextDirection.rtl,
//                   children: [
//                     AppTextWidget(
//                       'عدد الطلبات: ${order.itemCount}',
//                       style: AppTextStyles.styleRegular13.copyWith(
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     AppTextWidget(
//                       '${order.totalPrice} جنيه',
//                       style: AppTextStyles.styleSemiBold13.copyWith(
//                         color: AppColors.green1_500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Timeline ─────────────────────────────────────────────────────────────────

// class _StatusTimeline extends StatelessWidget {
//   const _StatusTimeline({required this.currentStatus});
//   final OrderStatus currentStatus;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: OrderStatus.values.length,
//       itemBuilder: (context, index) {
//         final step = OrderStatus.values[index];
//         final isDone = step.stepIndex <= currentStatus.stepIndex;
//         final isActive = step == currentStatus;
//         final isLast = index == OrderStatus.values.length - 1;

//         return _TimelineItem(
//           step: step,
//           isDone: isDone,
//           isActive: isActive,
//           isLast: isLast,
//         );
//       },
//     );
//   }
// }

// class _TimelineItem extends StatelessWidget {
//   const _TimelineItem({
//     required this.step,
//     required this.isDone,
//     required this.isActive,
//     required this.isLast,
//   });

//   final OrderStatus step;
//   final bool isDone;
//   final bool isActive;
//   final bool isLast;

//   @override
//   Widget build(BuildContext context) {
//     return IntrinsicHeight(
//       child: Row(
//         textDirection: TextDirection.rtl,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ── Icon + connector line column ──
//           Column(
//             children: [
//               _StepIcon(isDone: isDone, isActive: isActive),
//               if (!isLast)
//                 Expanded(
//                   child: Container(
//                     width: 2,
//                     color: isDone
//                         ? AppColors.green1_500
//                         : AppColors.border,
//                   ),
//                 ),
//             ],
//           ),
//           const SizedBox(width: 16),
//           // ── Label + date ──
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 28),
//               child: Row(
//                 textDirection: TextDirection.rtl,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       AppTextWidget(
//                         step.label,
//                         style: AppTextStyles.styleBold16.copyWith(
//                           color: isDone
//                               ? AppColors.textPrimary
//                               : AppColors.textDisabled,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       AppTextWidget(
//                         isActive ? step.description : '',
//                         style: AppTextStyles.styleRegular13.copyWith(
//                           color: AppColors.textSecondary,
//                         ),
//                       ),
//                     ],
//                   ),
//                   if (isDone && step.stepIndex == 0)
//                     AppTextWidget(
//                       '22 مارس ، 2024',
//                       style: AppTextStyles.styleRegular13.copyWith(
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _StepIcon extends StatelessWidget {
//   const _StepIcon({required this.isDone, required this.isActive});
//   final bool isDone;
//   final bool isActive;

//   @override
//   Widget build(BuildContext context) {
//     if (isDone) {
//       return Container(
//         width: 36,
//         height: 36,
//         decoration: BoxDecoration(
//           color: isActive
//               ? AppColors.green1_500
//               : AppColors.green1_500.withOpacity(0.15),
//           shape: BoxShape.circle,
//         ),
//         child: Icon(
//           Icons.check_rounded,
//           color: isActive ? Colors.white : AppColors.green1_500,
//           size: 20,
//         ),
//       );
//     }
//     return Container(
//       width: 36,
//       height: 36,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.circle,
//         border: Border.all(color: AppColors.border, width: 2),
//       ),
//     );
//   }
// }

// // ── Error view ───────────────────────────────────────────────────────────────

// class _ErrorView extends StatelessWidget {
//   const _ErrorView({required this.message});
//   final String message;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(
//             Icons.error_outline_rounded,
//             color: AppColors.error,
//             size: 56,
//           ),
//           const SizedBox(height: 12),
//           AppTextWidget(
//             message,
//             style: AppTextStyles.styleSemiBold16.copyWith(
//               color: AppColors.textSecondary,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
