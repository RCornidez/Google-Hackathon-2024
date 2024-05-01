import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

class SimpleLogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    final logMessage = '$dateTime - ${event.level.name} - ${event.message}';
    // Directly print to console
    //print(logMessage);
    return [logMessage];
  }
}

class Log {
  static late Logger _logger;

  static void init() {
    _logger = Logger(printer: SimpleLogPrinter());
  }

  static void debug(String message) {
    _logger.d(message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
