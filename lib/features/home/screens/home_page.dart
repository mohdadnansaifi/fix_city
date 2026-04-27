import 'package:flutter/material.dart';
import '../widgets/create_report_button.dart';
import '../widgets/home_header.dart';
import '../widgets/welcome_and_subtitle_text.dart';

class FixCityHomeScreen extends StatelessWidget {
  const FixCityHomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                HomeHeaderWithAnimation(),
                const SizedBox(height: 32),
                // Welcome Text
                WelcomeAndSubtitle(),
                const SizedBox(height: 40),

                // Button
                CreateReportButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}







// lib/features/home/fix_city_home_screen.dart
//
// import 'package:flutter/material.dart';
// import 'dart:math' as math;
//
// class FixCityHomeScreen extends StatefulWidget {
//   const FixCityHomeScreen({super.key});
//
//   @override
//   State<FixCityHomeScreen> createState() => _FixCityHomeScreenState();
// }
//
// class _FixCityHomeScreenState extends State<FixCityHomeScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _masterController;
//   late AnimationController _floatController;
//   late AnimationController _pulseController;
//   late AnimationController _rippleController;
//   late AnimationController _countController;
//
//   late Animation<double> _headerFade, _headerSlide;
//   late Animation<double> _heroFade;
//   late Animation<double> _statsFade;
//   late Animation<double> _nearbyFade;
//   late Animation<double> _btnFade;
//   late Animation<double> _floatAnim;
//   late Animation<double> _pulseAnim;
//   late Animation<double> _ripple1, _ripple2;
//   late Animation<double> _countAnim;
//
//   // Count-up targets
//   static const int _totalReports = 247;
//   static const int _resolved = 138;
//   static const int _cities = 12;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Master stagger controller
//     _masterController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//
//     // Float animation for hero icon
//     _floatController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 3000),
//     )..repeat(reverse: true);
//
//     // Pulse for live badge dot
//     _pulseController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1800),
//     )..repeat(reverse: true);
//
//     // Ripple rings
//     _rippleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2500),
//     )..repeat();
//
//     // Count-up
//     _countController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//
//     // Staggered fade+slide animations
//     _headerFade = _interval(0.0, 0.3);
//     _headerSlide = _slideInterval(0.0, 0.3);
//     _heroFade = _interval(0.05, 0.45);
//     _statsFade = _interval(0.25, 0.6);
//     _nearbyFade = _interval(0.4, 0.75);
//     _btnFade = _interval(0.6, 0.9);
//
//     _floatAnim = Tween<double>(begin: 0, end: -8).animate(
//       CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
//     );
//
//     _pulseAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
//       CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
//     );
//
//     _ripple1 = Tween<double>(begin: 0.8, end: 1.4).animate(
//       CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
//     );
//     _ripple2 = Tween<double>(begin: 0.8, end: 1.6).animate(
//       CurvedAnimation(
//         parent: _rippleController,
//         curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
//       ),
//     );
//
//     _countAnim = CurvedAnimation(
//       parent: _countController,
//       curve: Curves.easeOutCubic,
//     );
//
//     _masterController.forward();
//     Future.delayed(const Duration(milliseconds: 400), () {
//       if (mounted) _countController.forward();
//     });
//   }
//
//   Animation<double> _interval(double begin, double end) =>
//       CurvedAnimation(
//         parent: _masterController,
//         curve: Interval(begin, end, curve: Curves.easeOut),
//       );
//
//   Animation<double> _slideInterval(double begin, double end) =>
//       Tween<double>(begin: -16.0, end: 0.0).animate(
//         CurvedAnimation(
//           parent: _masterController,
//           curve: Interval(begin, end, curve: Curves.easeOutCubic),
//         ),
//       );
//
//   @override
//   void dispose() {
//     _masterController.dispose();
//     _floatController.dispose();
//     _pulseController.dispose();
//     _rippleController.dispose();
//     _countController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0F172A),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _buildTopBar(),
//               _buildHeroSection(),
//               const SizedBox(height: 24),
//               _buildStatsRow(),
//               const SizedBox(height: 24),
//               _buildNearbySection(),
//               const SizedBox(height: 24),
//               _buildCTAButton(),
//               const SizedBox(height: 8),
//               _buildCTASub(),
//               const SizedBox(height: 32),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ── Top Bar ──────────────────────────────────────────────────────────────
//
//   Widget _buildTopBar() {
//     return FadeTransition(
//       opacity: _headerFade,
//       child: AnimatedBuilder(
//         animation: _headerSlide,
//         builder: (_, child) => Transform.translate(
//           offset: Offset(0, _headerSlide.value),
//           child: child,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // App chip
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF1E293B),
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: Colors.white.withOpacity(0.08)),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       width: 22, height: 22,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF2563EB),
//                         borderRadius: BorderRadius.circular(7),
//                       ),
//                       child: const Icon(
//                         Icons.location_on_rounded,
//                         color: Colors.white, size: 13,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     const Text(
//                       'FixCity',
//                       style: TextStyle(
//                         color: Color(0xFFE2E8F0),
//                         fontSize: 14, fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Notification button
//               Stack(
//                 children: [
//                   Container(
//                     width: 38, height: 38,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF1E293B),
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.white.withOpacity(0.08)),
//                     ),
//                     child: const Icon(
//                       Icons.notifications_outlined,
//                       color: Color(0xFF64748B), size: 18,
//                     ),
//                   ),
//                   Positioned(
//                     top: 7, right: 8,
//                     child: Container(
//                       width: 7, height: 7,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFEF4444),
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: const Color(0xFF0F172A), width: 1.5,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ── Hero Section ─────────────────────────────────────────────────────────
//
//   Widget _buildHeroSection() {
//     return FadeTransition(
//       opacity: _heroFade,
//       child: Column(
//         children: [
//           const SizedBox(height: 8),
//
//           // Floating icon with ripple rings
//           AnimatedBuilder(
//             animation: Listenable.merge([
//               _floatAnim, _ripple1, _ripple2,
//             ]),
//             builder: (_, __) => Transform.translate(
//               offset: Offset(0, _floatAnim.value),
//               child: SizedBox(
//                 width: 140, height: 140,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // Outer ripple
//                     Transform.scale(
//                       scale: _ripple2.value,
//                       child: Container(
//                         width: 140, height: 140,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: const Color(0xFF2563EB).withOpacity(
//                               (1 - (_ripple2.value - 0.8) / 0.8).clamp(0, 0.15),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Inner ripple
//                     Transform.scale(
//                       scale: _ripple1.value,
//                       child: Container(
//                         width: 120, height: 120,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: const Color(0xFF2563EB).withOpacity(
//                               (1 - (_ripple1.value - 0.8) / 0.6).clamp(0, 0.2),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Icon circle
//                     Container(
//                       width: 96, height: 96,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF1E293B),
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.08),
//                         ),
//                       ),
//                       child: const Icon(
//                         Icons.location_on_rounded,
//                         color: Color(0xFF3B82F6), size: 42,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 20),
//
//           // Live badge
//           AnimatedBuilder(
//             animation: _pulseAnim,
//             builder: (_, __) => Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF2563EB).withOpacity(0.15),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: const Color(0xFF2563EB).withOpacity(0.25),
//                 ),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     width: 6, height: 6,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF3B82F6)
//                           .withOpacity(_pulseAnim.value),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   const SizedBox(width: 7),
//                   const Text(
//                     'Live city monitoring',
//                     style: TextStyle(
//                       color: Color(0xFF60A5FA),
//                       fontSize: 12, fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 14),
//
//           // Title
//           RichText(
//             textAlign: TextAlign.center,
//             text: const TextSpan(
//               style: TextStyle(
//                 fontSize: 26, fontWeight: FontWeight.w600,
//                 color: Color(0xFFF1F5F9), height: 1.25,
//               ),
//               children: [
//                 TextSpan(text: 'Report. Track.\nFix '),
//                 TextSpan(
//                   text: 'Your City.',
//                   style: TextStyle(color: Color(0xFF3B82F6)),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 10),
//
//           // Subtitle
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               'Help make your city better. Report civic issues and track resolutions in real time.',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Color(0xFF475569), fontSize: 13, height: 1.6,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ── Stats Row ────────────────────────────────────────────────────────────
//
//   Widget _buildStatsRow() {
//     return FadeTransition(
//       opacity: _statsFade,
//       child: AnimatedBuilder(
//         animation: _countAnim,
//         builder: (_, __) {
//           final total = (_totalReports * _countAnim.value).round();
//           final resolved = (_resolved * _countAnim.value).round();
//           final cities = (_cities * _countAnim.value).round();
//
//           return Row(
//             children: [
//               Expanded(child: _MiniStat(
//                 value: total.toString(),
//                 label: 'Reports',
//                 valueColor: const Color(0xFFF1F5F9),
//               )),
//               const SizedBox(width: 10),
//               Expanded(child: _MiniStat(
//                 value: resolved.toString(),
//                 label: 'Resolved',
//                 valueColor: const Color(0xFF34D399),
//               )),
//               const SizedBox(width: 10),
//               Expanded(child: _MiniStat(
//                 value: cities.toString(),
//                 label: 'Cities',
//                 valueColor: const Color(0xFFFBBF24),
//               )),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   // ── Nearby Section ───────────────────────────────────────────────────────
//
//   Widget _buildNearbySection() {
//     const issues = [
//       _IssueData(
//         type: 'Pothole',
//         address: 'MG Road, Sector 14',
//         status: 'Reported',
//         time: '2h ago',
//         iconColor: Color(0xFFF87171),
//         bgColor: Color(0x1AEF4444),
//         badgeClass: 'red',
//       ),
//       _IssueData(
//         type: 'Street Light',
//         address: 'Nehru Nagar, Lane 3',
//         status: 'In Progress',
//         time: '5h ago',
//         iconColor: Color(0xFFFBBF24),
//         bgColor: Color(0x1AF59E0B),
//         badgeClass: 'amber',
//       ),
//       _IssueData(
//         type: 'Garbage',
//         address: 'Civil Lines, Block B',
//         status: 'Resolved',
//         time: '1d ago',
//         iconColor: Color(0xFF34D399),
//         bgColor: Color(0x1A10B981),
//         badgeClass: 'green',
//       ),
//     ];
//
//     return FadeTransition(
//       opacity: _nearbyFade,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Nearby issues',
//                 style: TextStyle(
//                   color: Color(0xFFE2E8F0),
//                   fontSize: 15, fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 'See all',
//                 style: TextStyle(
//                   color: const Color(0xFF3B82F6), fontSize: 13,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           ...issues.map((issue) => _IssueCard(issue: issue)),
//         ],
//       ),
//     );
//   }
//
//   // ── CTA Button ───────────────────────────────────────────────────────────
//
//   Widget _buildCTAButton() {
//     return FadeTransition(
//       opacity: _btnFade,
//       child: _PressableButton(
//         onTap: () {
//           // Navigate to report screen
//         },
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(vertical: 17),
//           decoration: BoxDecoration(
//             color: const Color(0xFF2563EB),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: const Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.add_circle_outline_rounded, color: Colors.white, size: 20),
//               SizedBox(width: 10),
//               Text(
//                 'Report an Issue',
//                 style: TextStyle(
//                   color: Colors.white, fontSize: 16,
//                   fontWeight: FontWeight.w500, letterSpacing: 0.3,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCTASub() {
//     return FadeTransition(
//       opacity: _btnFade,
//       child: const Text(
//         'Takes less than 2 minutes',
//         textAlign: TextAlign.center,
//         style: TextStyle(color: Color(0xFF334155), fontSize: 12),
//       ),
//     );
//   }
// }
//
// // ── Reusable Sub-widgets ─────────────────────────────────────────────────────
//
// class _MiniStat extends StatelessWidget {
//   final String value;
//   final String label;
//   final Color valueColor;
//
//   const _MiniStat({
//     required this.value,
//     required this.label,
//     required this.valueColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 14),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1E293B),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: Colors.white.withOpacity(0.07)),
//       ),
//       child: Column(
//         children: [
//           Text(
//             value,
//             style: TextStyle(
//               color: valueColor, fontSize: 20, fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 3),
//           Text(
//             label,
//             style: const TextStyle(color: Color(0xFF475569), fontSize: 11),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _IssueData {
//   final String type;
//   final String address;
//   final String status;
//   final String time;
//   final Color iconColor;
//   final Color bgColor;
//   final String badgeClass;
//
//   const _IssueData({
//     required this.type, required this.address, required this.status,
//     required this.time, required this.iconColor, required this.bgColor,
//     required this.badgeClass,
//   });
// }
//
// class _IssueCard extends StatefulWidget {
//   final _IssueData issue;
//   const _IssueCard({required this.issue});
//
//   @override
//   State<_IssueCard> createState() => _IssueCardState();
// }
//
// class _IssueCardState extends State<_IssueCard> {
//   bool _hovered = false;
//
//   Color get _badgeColor {
//     switch (widget.issue.badgeClass) {
//       case 'green': return const Color(0xFF34D399);
//       case 'amber': return const Color(0xFFFBBF24);
//       default: return const Color(0xFFF87171);
//     }
//   }
//
//   Color get _badgeBg {
//     switch (widget.issue.badgeClass) {
//       case 'green': return const Color(0x1A10B981);
//       case 'amber': return const Color(0x1AF59E0B);
//       default: return const Color(0x1AEF4444);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _hovered = true),
//       onExit: (_) => setState(() => _hovered = false),
//       child: GestureDetector(
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 150),
//           margin: const EdgeInsets.only(bottom: 10),
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: _hovered
//                 ? const Color(0xFF263548)
//                 : const Color(0xFF1E293B),
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(color: Colors.white.withOpacity(0.07)),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 42, height: 42,
//                 decoration: BoxDecoration(
//                   color: widget.issue.bgColor,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   _iconForType(widget.issue.type),
//                   color: widget.issue.iconColor, size: 18,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.issue.type,
//                       style: const TextStyle(
//                         color: Color(0xFFE2E8F0),
//                         fontSize: 13, fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       widget.issue.address,
//                       style: const TextStyle(
//                         color: Color(0xFF475569), fontSize: 11,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8, vertical: 3,
//                     ),
//                     decoration: BoxDecoration(
//                       color: _badgeBg,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       widget.issue.status,
//                       style: TextStyle(
//                         color: _badgeColor,
//                         fontSize: 10, fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 3),
//                   Text(
//                     widget.issue.time,
//                     style: const TextStyle(
//                       color: Color(0xFF334155), fontSize: 10,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   IconData _iconForType(String type) {
//     switch (type) {
//       case 'Street Light': return Icons.bolt_outlined;
//       case 'Garbage': return Icons.check_circle_outline;
//       default: return Icons.error_outline_rounded;
//     }
//   }
// }
//
// class _PressableButton extends StatefulWidget {
//   final Widget child;
//   final VoidCallback onTap;
//   const _PressableButton({required this.child, required this.onTap});
//
//   @override
//   State<_PressableButton> createState() => _PressableButtonState();
// }
//
// class _PressableButtonState extends State<_PressableButton> {
//   double _scale = 1.0;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => setState(() => _scale = 0.97),
//       onTapUp: (_) { setState(() => _scale = 1.0); widget.onTap(); },
//       onTapCancel: () => setState(() => _scale = 1.0),
//       child: AnimatedScale(
//         scale: _scale,
//         duration: const Duration(milliseconds: 100),
//         child: widget.child,
//       ),
//     );
//   }
// }
