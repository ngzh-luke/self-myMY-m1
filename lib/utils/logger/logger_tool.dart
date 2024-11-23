/// a custom logger for the app for shorthand usage
///
///
import 'package:logger/logger.dart';

class LoggerTool {
  final Logger _logger = Logger();

  StackTrace _stackTrace = StackTrace.current;
  bool _isInUTC = false;

  bool get isInUTC => _isInUTC;
  StackTrace get stackTrace => _stackTrace;

  set setIsInUTC(bool isInUTC) {
    _isInUTC = isInUTC;
  }

  set setStackTrace(StackTrace stackTrace) {
    _stackTrace = stackTrace;
  }

  LoggerTool();

  /// returns a local [DateTime] if `useUTC` is `false`
  ///
  /// otherwise return current [DateTime] in UTC
  DateTime _getDateTime({bool useUTC = false}) {
    if (useUTC) {
      return DateTime.timestamp();
    } else {
      return DateTime.now();
    }
  }

  /// Log a message at level [Level.debug] with [DateTime] attached in ISO8601 String format
  ///
  /// returns [String] msg that is being logged
  String d({required String debugMsg, StackTrace? stackTrace}) {
    final now = _getDateTime(useUTC: _isInUTC);
    final msg = "[${now.toIso8601String()}]: $debugMsg";
    _logger.d(msg, stackTrace: stackTrace ?? _stackTrace, time: now);
    return msg;
  }

  /// Log a message at level [Level.error] with [DateTime] attached in ISO8601 String format
  ///
  /// returns [String] msg that is being logged
  String e({required String errMsg, StackTrace? stackTrace, Object? err}) {
    final now = _getDateTime(useUTC: _isInUTC);
    final msg = "[${now.toIso8601String()}]: $errMsg";
    _logger.e(msg,
        time: now, error: err, stackTrace: stackTrace ?? _stackTrace);
    return msg;
  }

  /// Log a message at level [Level.fatal] with [DateTime] attached in ISO8601 String format
  ///
  /// returns [String] msg that is being logged
  String f({required String fatalMsg, StackTrace? stackTrace}) {
    final now = _getDateTime(useUTC: _isInUTC);
    final msg = "[${now.toIso8601String()}]: $fatalMsg";
    _logger.f(msg, time: now, stackTrace: stackTrace ?? _stackTrace);
    return msg;
  }

  /// Log a message at level [Level.info] with [DateTime] attached in ISO8601 String format
  ///
  /// returns [String] msg that is being logged
  String i({required String infoMsg, StackTrace? stackTrace}) {
    final now = _getDateTime(useUTC: _isInUTC);
    final msg = "[${now.toIso8601String()}]: $infoMsg";
    _logger.i(msg, time: now, stackTrace: stackTrace ?? _stackTrace);
    return msg;
  }

  /// Log a message at level [Level.trace] with [DateTime] attached in ISO8601 String format
  ///
  /// returns [String] msg that is being logged
  String t({required String traceMsg, StackTrace? stackTrace}) {
    final now = _getDateTime(useUTC: _isInUTC);
    final msg = "[${now.toIso8601String()}]: $traceMsg";
    _logger.t(msg, time: now, stackTrace: stackTrace ?? _stackTrace);
    return msg;
  }

  /// Log a message at level [Level.warning] with [DateTime] attached in ISO8601 String format
  ///
  /// returns [String] msg that is being logged
  String w({required String warnMsg, StackTrace? stackTrace}) {
    final now = _getDateTime(useUTC: _isInUTC);
    final msg = "[${now.toIso8601String()}]: $warnMsg";
    _logger.w(msg, time: now, stackTrace: stackTrace ?? _stackTrace);
    return msg;
  }
}
