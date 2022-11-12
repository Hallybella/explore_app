// ignore_for_file: prefer_is_empty, unnecessary_this

extension CapExtension on String {
  String get inCaps {
    return this.length > 0
        ? '${this[0].toUpperCase()}${this.substring(1)}'
        : '';
  }

  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
}
