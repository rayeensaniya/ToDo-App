import 'package:rxdart/rxdart.dart';

class DashboardBloc{
 final isChecked=BehaviorSubject<bool>.seeded(false);
 final isHideFab=BehaviorSubject<bool>.seeded(false);
}
