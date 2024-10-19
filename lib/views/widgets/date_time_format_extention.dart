extension DateTimeFormat on DateTime {
  String toFormattedString() {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    // ignore: unnecessary_this
    final monthName = months[this.month - 1];
    final day = this.day.toString().padLeft(2, '0');
    final hour =
        this.hour % 12 == 0 ? 12 : this.hour % 12; // Convert to 12-hour format
    final minute = this.minute.toString().padLeft(2, '0');
    final period = this.hour >= 12 ? 'PM' : 'AM';

    return '$monthName $day, $hour:$minute $period';
  }
}
