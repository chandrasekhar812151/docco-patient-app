
import 'package:rxdart/rxdart.dart';

class NotificationsBloc {
  final _subject = BehaviorSubject<String>();

  void setNotification(String msg) {
    _subject.add(msg);
  }

  void dispose() {
    _subject.close();
  }
}