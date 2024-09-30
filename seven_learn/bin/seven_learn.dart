import 'package:seven_learn/seven_learn.dart' as seven_learn;

enum PersianMonth {
  farvardin,
  ordibehesht,
  khordad,
  tir,
  mordad,
  shahrivar,
  mehr,
  aban,
  azar,
  dey,
  bahman,
  esfand;

  String get name {
    switch (this) {
      case farvardin:
        return 'فروردین';
      case ordibehesht:
        return 'اردیبهشت';
      case khordad:
        return 'خرداد';
      case tir:
        return 'تیر';
      case mordad:
        return 'مرداد';
      case shahrivar:
        return 'شهریور';
      case mehr:
        return 'مهر';
      case aban:
        return 'آبان';
      case azar:
        return 'آذر';
      case dey:
        return 'دی';
      case bahman:
        return 'بهمن';
      case esfand:
        return 'اسفند';
    }
  }

  int get dayCount {
    switch (this) {
      case farvardin:
        return 31;
      case ordibehesht:
        return 31;
      case khordad:
        return 31;
      case tir:
        return 31;
      case mordad:
        return 31;
      case shahrivar:
        return 31;
      case mehr:
        return 30;
      case aban:
        return 30;
      case azar:
        return 30;
      case dey:
        return 30;
      case bahman:
        return 30;
      case esfand:
        return 30;
    }
  }
}

void main() {
  print(PersianMonth.khordad.name);
  print(PersianMonth.tir.dayCount);
}
