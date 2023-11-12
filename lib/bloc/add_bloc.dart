class AddScreenBloc{
  String? titleValidator({String? title}) {
    if (title == null || title.trim().isEmpty) {
      return 'Title should not be empty';
    } return null;
  }
}