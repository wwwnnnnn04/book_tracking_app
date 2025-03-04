class Validators{
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Поле не может быть пустым';
    }
    return null;
  }
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Поле не может быть пустым';
    }
    if (RegExp(r'[А-Яа-яЁё]').hasMatch(value)) {
      return 'Поле не должно содержать кириллические символы';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Неверный формат e-mail';
    }
    return null;
  }
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Поле не может быть пустым';
    }
    if (value.length < 6) {
      return 'Пароль должен быть не меньше 6 символов';
    }
    return null;
  }
  
}