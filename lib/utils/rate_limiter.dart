/// a rate limiter
// ignore: unused_import
import 'dart:async';

import 'package:mymy_m1/utils/dependency_inj/get_it.dart';
import 'package:mymy_m1/utils/logger/logger_tool.dart';

class RateLimiter {
  final Map<String, int> _attempts = {};
  final Map<String, DateTime> _lastAttempt = {};
  final Duration _defaultDuration = const Duration(minutes: 15);

  RateLimiter();

  /// a function to limit the attempt rate to perform such action(s)
  bool canAttempt(String identifier, {Duration? duration}) {
    final now = DateTime.now();
    duration ??= _defaultDuration;
    if (_lastAttempt.containsKey(identifier) &&
        now.difference(_lastAttempt[identifier]!) < duration) {
      _attempts[identifier] = (_attempts[identifier] ?? 0) + 1;
      if (_attempts[identifier]! > 5) {
        return false;
      }
    } else {
      _attempts[identifier] = 1;
    }
    _lastAttempt[identifier] = now;
    return true;
  }

  DateTime? getLastAttempt(String identifier) {
    return _lastAttempt[identifier];
  }

  int? getAttempts(String identifier) {
    return _attempts[identifier];
  }

  Duration? getCanAttemptAfter(String identifier, {Duration? duration}) {
    final now = DateTime.now();
    duration ??= _defaultDuration;
    if (_lastAttempt.containsKey(identifier)) {
      return duration - now.difference(_lastAttempt[identifier]!);
    }
    return null;
  }

  void resetAttempts(String identifier) {
    _attempts[identifier] = 0;
    _lastAttempt.remove(identifier);
  }
}

class RateLimitExceededException implements Exception {
  final String? message;
  final RateLimiter rateLimiter;
  final String identifier;
  final LoggerTool _log = getIt<LoggerTool>();
  RateLimitExceededException(
      {this.message, required this.rateLimiter, required this.identifier});

  String getErrorDetails() {
    final String errString =
        'Rate limit exceeded for identifier: $identifier\nAttempts: ${rateLimiter.getAttempts(identifier)}\nLast attempt: ${rateLimiter.getLastAttempt(identifier)}\nCan attempt after: ${rateLimiter.getCanAttemptAfter(identifier)}\noptional msg: $message';
    _log.e(errMsg: errString);
    return toString();
  }

  @override
  String toString() {
    return "please wait ${rateLimiter.getCanAttemptAfter(identifier)?.inMinutes} minutes for next attempt";
  }
}
