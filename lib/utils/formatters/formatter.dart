import 'package:intl/intl.dart';

class AFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    ).format(amount);
  }

  static String formatCount(int count) {
    return NumberFormat.decimalPattern().format(count);
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Format 10-digit Indian phone numbers as: 12345 67890
    if (phoneNumber.length == 10) {
      return '${phoneNumber.substring(0, 5)} ${phoneNumber.substring(5)}';
    }

    return phoneNumber;
  }

  static String internationalFormatPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters from the phone number
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Determine country code, defaulting to India (+91) if no country code is specified
    String countryCode;
    if (digitsOnly.startsWith('91')) {
      countryCode = '+91';
      digitsOnly = digitsOnly.substring(2); // Remove '91' from the start
    } else {
      countryCode = '+${digitsOnly.substring(0, 2)}';
      digitsOnly = digitsOnly.substring(2); // Remove the assumed country code
    }

    // Format as an Indian number if it’s a 10-digit number
    if (countryCode == '+91' && digitsOnly.length == 10) {
      return '$countryCode ${digitsOnly.substring(0, 5)} ${digitsOnly.substring(5)}';
    }

    // General fallback for other international formats, grouping by 2 digits
    final formattedNumber = StringBuffer();
    formattedNumber.write(countryCode);
    int i = 0;

    while (i < digitsOnly.length) {
      int groupLength = (i == 0 && countryCode == '+1') ? 3 : 2;
      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));
      if (end < digitsOnly.length) {
        formattedNumber.write('-');
      }
      i = end;
    }

    return formattedNumber.toString();
  }
}
