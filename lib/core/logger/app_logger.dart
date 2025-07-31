import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static AppLogger? _instance;
  late Logger _logger;

  AppLogger._internal() {
    _logger = Logger(printer: _AppLogPrinter(), output: _AppLogOutput(), filter: _AppLogFilter());
  }

  static AppLogger get instance {
    _instance ??= AppLogger._internal();
    return _instance!;
  }

  // Log methods
  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  void verbose(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  // Network logging methods
  void logRequest(String method, String url, Map<String, dynamic>? headers, dynamic body) {
    if (kDebugMode) {
      info('🚀 REQUEST: $method $url');
      if (headers != null && headers.isNotEmpty) {
        debug('📋 Headers: $headers');
      }
      if (body != null) {
        debug('📦 Body: $body');
      }
    }
  }

  void logResponse(String method, String url, int statusCode, dynamic body) {
    if (kDebugMode) {
      final emoji = statusCode >= 200 && statusCode < 300 ? '✅' : '❌';
      info('$emoji RESPONSE: $method $url - Status: $statusCode');
      if (body != null) {
        debug('📦 Response Body: $body');
      }
    }
  }

  void logError(String method, String url, dynamic error) {
    if (kDebugMode) {
      this.error('💥 ERROR: $method $url - Error: $error');
    }
  }

  // Auth logging methods
  void logAuthEvent(String event, {String? userId, dynamic data}) {
    if (kDebugMode) {
      info('🔐 AUTH: $event${userId != null ? ' - User: $userId' : ''}');
      if (data != null) {
        debug('📊 Auth Data: $data');
      }
    }
  }

  // Navigation logging methods
  void logNavigation(String from, String to) {
    if (kDebugMode) {
      info('🧭 NAVIGATION: $from → $to');
    }
  }

  // Feature logging methods
  void logFeatureEvent(String feature, String event, {dynamic data}) {
    if (kDebugMode) {
      info('🎯 FEATURE: $feature - $event');
      if (data != null) {
        debug('📊 Feature Data: $data');
      }
    }
  }
}

class _AppLogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final time = DateTime.now().toString().substring(11, 23);
    final level = event.level.name.toUpperCase().padRight(7);
    final message = event.message;

    var output = '[$time] $level: $message';

    if (event.error != null) {
      output += '\n❌ Error: ${event.error}';
    }

    if (event.stackTrace != null && event.level == Level.error) {
      output += '\n📋 Stack Trace:\n${event.stackTrace}';
    }

    return [output];
  }
}

class _AppLogOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    if (kDebugMode) {
      for (final line in event.lines) {
        developer.log(line, name: 'Sinflix');
      }
    }
  }
}

class _AppLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    // Debug modunda tüm logları göster
    if (kDebugMode) {
      return true;
    }

    // Production'da sadece warning ve error'ları göster
    return event.level.index >= Level.warning.index;
  }
}

// Global logger instance
final appLogger = AppLogger.instance;
