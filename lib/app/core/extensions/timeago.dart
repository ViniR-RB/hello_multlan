// ignore: depend_on_referenced_packages
import 'package:timeago/timeago.dart' as timeago;

extension TimeAgoStringExtension on String {
  String toTimeAgo({String locale = 'pt_br'}) {
    try {
      final date = DateTime.parse(this);

      // Retornar o tempo relativo
      final String timeFormated = timeago.format(date, locale: locale);
      return timeFormated;
    } catch (e) {
      return "Data inválida";
    }
  }
}
