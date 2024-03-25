class NotificationType {
  static String get checkIn => 'checkIn';
  static String get checkOut => 'checkOut';
  static String get task => 'task';
  static String get leavePermission => 'leavePermission';
}

class NotificationSubType {
  static String get checkInLate => 'checkInLate';
  static String get checkOutLate => 'checkOutLate';
  static String get taskReminder => 'taskReminder';

  // Leave Permission
  static String get leaveRequest => 'leaveRequest';
  static String get leaveApproval => 'leaveApproval';
}
