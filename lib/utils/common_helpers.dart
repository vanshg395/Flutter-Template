import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as ul;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../services/navigation.service.dart';
import '../services/shared_preferences.service.dart';

import '../models/shared/user_agent.model.dart';
import '../models/shared/cta.model.dart';

import '../utils/enums/cta_type.enum.dart';
import '../utils/design/colors.dart';

class CommonHelpers {
  CommonHelpers._();

  static void copyToClipboard(String copyTxt) {
    Clipboard.setData(ClipboardData(text: copyTxt));
  }

  static bool isNotEmptyList(List arr) {
    return arr.isNotEmpty;
  }

  static bool isNotEmptyMap(Map map) {
    return map.isNotEmpty;
  }

  static bool isNotEmptyString(String? str) {
    return str != null && str.isNotEmpty && str != '';
  }

  static T? enumFromString<T>(Iterable<T> values, String? value) {
    try {
      return values.firstWhere(
        (T type) => type.toString().split(".").last == value,
      );
    } catch (e) {
      return null;
    }
  }

  static bool isNotIos() {
    return !Platform.isIOS;
  }

  static bool isIos() {
    return Platform.isIOS;
  }

  static Future<void> launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await ul.canLaunchUrl(uri)) {
      await ul.launchUrl(uri);
    }
  }

  static Future<void> launchWhatsapp({
    required String message,
    String? phone,
  }) async {
    if (phone != null) {
      launchUrl("https://api.whatsapp.com/send/?phone=$phone&text=$message");
    } else {
      launchUrl("https://api.whatsapp.com/send/?text=$message");
    }
  }

  static String getDurationString(Duration time) {
    String timeText = time.toString().split('.').first;
    if (timeText.split(':').first == "0") {
      timeText = timeText.split(':').sublist(1).join(':');
    }
    return timeText;
  }

  static Future<String> getLocalFilepathFromUrl(
    String url,
    String fileName,
  ) async {
    final String directory = Platform.isAndroid
        ? (await getExternalStorageDirectory())!.path
        : (await getApplicationDocumentsDirectory()).path;
    final String filePath = '$directory/$fileName';
    final Response response = await get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static Color getColorFromHex(String? hexColor) {
    if (hexColor == null) {
      return AppColors.transparent;
    } else {
      String hexCode = hexColor.replaceAll('#', '');
      if (hexCode.length == 3) {
        hexCode = hexCode.characters.map((String e) => e + e).join();
      }
      return Color(
        int.parse(
          'FF$hexCode',
          radix: 16,
        ),
      );
    }
  }

  static String cleanMobileNumber(String num) {
    return num.replaceAll('-', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll(' ', '')
        .trim();
  }

  static Future<String?> getFileNameWithExtension(File file) async {
    if (await file.exists()) {
      //To get file name without extension
      //path.basenameWithoutExtension(file.path);

      //return file with file extension
      return path.basename(file.path);
    }
    return null;
  }

  static String getCompactNumber(int? val) {
    return NumberFormat.compact().format(val ?? 0);
  }

  static Map<String, dynamic>? removeNullParams(
    Map<String, dynamic>? data, {
    List<String>? excludeParams,
  }) {
    if (excludeParams != null) {
      data!.removeWhere(
          (String k, dynamic v) => v == null && !excludeParams.contains(k));
    } else {
      data!.removeWhere((String k, dynamic v) => v == null);
    }
    return data;
  }

  static bool isNumber(String str) {
    return int.tryParse(str) != null;
  }

  static bool isValidEmail(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }

  static bool isValidName(String name) {
    return RegExp("^[A-Za-zs]{1,}[.]{0,1}[A-Za-zs]{0,}").hasMatch(name) &&
        name.length >= 2;
  }

  static Alignment getAlignmentFromString(String? alignment) {
    switch (alignment) {
      case 'TOP_LEFT':
        return Alignment.topLeft;
      case 'TOP_CENTER':
        return Alignment.topCenter;
      case 'TOP_RIGHT':
        return Alignment.topRight;
      case 'BOTTOM_LEFT':
        return Alignment.bottomLeft;
      case 'BOTTOM_CENTER':
        return Alignment.bottomCenter;
      case 'BOTTOM_RIGHT':
        return Alignment.bottomRight;
      case 'CENTER_LEFT':
        return Alignment.centerLeft;
      case 'CENTER':
        return Alignment.center;
      case 'CENTER_RIGHT':
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }

  static MainAxisAlignment getFlexAlignmentFromString(String? alignment) {
    switch (alignment) {
      case 'CENTER':
        return MainAxisAlignment.center;
      case 'FLEX_START':
        return MainAxisAlignment.start;
      case 'FLEX_END':
        return MainAxisAlignment.end;
      case 'SPACE_AROUND':
        return MainAxisAlignment.spaceAround;
      case 'SPACE_BETWEEN':
        return MainAxisAlignment.spaceBetween;
      case 'SPACE_EVENLY':
        return MainAxisAlignment.spaceEvenly;
      default:
        return MainAxisAlignment.center;
    }
  }

  static TextAlign getTextAlignmentFromString(String? alignment) {
    switch (alignment) {
      case 'LEFT':
        return TextAlign.left;
      case 'CENTER':
        return TextAlign.center;
      case 'RIGHT':
        return TextAlign.right;
      default:
        return TextAlign.left;
    }
  }

  static String getUUID() {
    final Uuid uuid = Uuid();
    String id = uuid
        .v5(null, DateTime.now().toUtc().toString())
        .split('-')
        .join('')
        .toLowerCase();
    return id;
  }

  static String? getCommaSeparatedNumber(int? number) {
    NumberFormat f = NumberFormat("###,###", "en_US");
    return f.format(number);
  }

  static Map<String, String> getApiHeaders() {
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:
          SharedPreferencesService.accessToken ?? '',
      'userAgent': UserAgent().toJson(),
    };
  }

  static Future<dynamic> getAction({
    required CTA clickToAction,
  }) async {
    switch (clickToAction.ctaType) {
      case CTAType.DISABLED:
        break;
      case CTAType.APP_LINK:
        if (clickToAction.ctaUrl != null) {
          Uri? appPath = Uri.parse(clickToAction.ctaUrl!);
          Map<String, String>? queryParams = appPath.queryParameters;
          List<String> pathSegments = appPath.pathSegments;
          return NavigationService.pushNamed(
            pathSegments.first,
            arguments: queryParams,
          );
        } else {
          return;
        }
      case CTAType.EXTERNAL_LINK:
        if (clickToAction.ctaUrl != null) {
          launchUrl(clickToAction.ctaUrl!);
        }
        break;
      default:
        return;
    }
  }
}
