import 'package:flutter/material.dart';

import '../di/injection.dart';
import '../firebase/analytics_service.dart';

/// Firebase Analytics screen tracking için mixin
mixin AnalyticsScreenMixin<T extends StatefulWidget> on State<T> {
  String get screenName;
  String? get screenClass => null;

  late final AnalyticsService _analyticsService = getIt<AnalyticsService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _trackScreenView();
    });
  }

  Future<void> _trackScreenView() async {
    try {
      await _analyticsService.logScreenView(screenName: screenName, screenClass: screenClass);
    } catch (e) {
      // Silently handle analytics errors
      debugPrint('Analytics error: $e');
    }
  }
}

/// Firebase Analytics için StatelessWidget wrapper
class AnalyticsScreenWrapper extends StatefulWidget {
  final Widget child;
  final String screenName;
  final String? screenClass;

  const AnalyticsScreenWrapper({
    super.key,
    required this.child,
    required this.screenName,
    this.screenClass,
  });

  @override
  State<AnalyticsScreenWrapper> createState() => _AnalyticsScreenWrapperState();
}

class _AnalyticsScreenWrapperState extends State<AnalyticsScreenWrapper> {
  late final AnalyticsService _analyticsService = getIt<AnalyticsService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _trackScreenView();
    });
  }

  Future<void> _trackScreenView() async {
    try {
      await _analyticsService.logScreenView(
        screenName: widget.screenName,
        screenClass: widget.screenClass,
      );
    } catch (e) {
      // Silently handle analytics errors
      debugPrint('Analytics error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
