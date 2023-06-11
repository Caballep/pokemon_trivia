class DateTimeHelper {
  String getCurrentTimeString() {
    final now = DateTime.now();
    final formattedTime =
        '${_formatTwoDigits(now.month)}/${_formatTwoDigits(now.day)}/${now.year} ${_formatTwoDigits(now.hour)}:${_formatTwoDigits(now.minute)}';
    return formattedTime;
  }

  String _formatTwoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }
}
