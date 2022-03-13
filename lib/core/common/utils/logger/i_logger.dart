abstract class ILogger {
  void v(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void d(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void i(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void w(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]);
}
