import 'package:logger/logger.dart';
import '../models/models.dart';
class Log{
  Logger logger = Logger();
  Log();

  writeLog(LogType logTyep, String message ){
    switch (logTyep) {
      case LogType.debug:
        logger.d(message);
      case LogType.info:
        logger.i(message);
        case LogType.warning:
        logger.w(message);
        case LogType.error:
        logger.e(message);
    }
  }

}