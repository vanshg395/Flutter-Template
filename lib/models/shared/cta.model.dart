import 'dart:convert';

import '../../utils/common_helpers.dart';
import '../../utils/enums/cta_type.enum.dart';

class CTA {
  CTAType ctaType;
  String? ctaUrl;

  CTA({
    required this.ctaType,
    this.ctaUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'ctaType': ctaType.name,
      'ctaUrl': ctaUrl,
    };
  }

  factory CTA.fromMap(Map<String, dynamic> map) {
    return CTA(
      ctaType: CommonHelpers.enumFromString(
        CTAType.values,
        map['ctaType'],
      )!,
      ctaUrl: map['ctaUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CTA.fromJson(String source) => CTA.fromMap(json.decode(source));
}
