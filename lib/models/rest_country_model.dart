// To parse this JSON data, do
//
//     final restCountryModel = restCountryModelFromJson(jsonString);

import 'dart:convert';

List<RestCountryModel> restCountryModelFromJson(String str) =>
    List<RestCountryModel>.from(
        json.decode(str).map((x) => RestCountryModel.fromJson(x)));

String restCountryModelToJson(List<RestCountryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestCountryModel {
  RestCountryModel({
    this.name,
    this.tld,
    // this.cca2,
    // this.ccn3,
    // this.cca3,
    // this.cioc,
    this.independent,
    this.status,
    this.unMember,
    this.currencies,
    // this.idd,
    this.capital,
    this.altSpellings,
    this.region,
    this.subregion,
    this.languages,
    this.translations,
    this.latlng,
    this.landlocked,
    this.borders,
    this.area,
    // this.demonyms,
    this.flag,
    this.maps,
    this.population,
    // this.gini,
    // this.fifa,
    this.car,
    this.timezones,
    this.continents,
    this.flags,
    this.coatOfArms,
    this.startOfWeek,
    this.capitalInfo,
    // this.postalCode,
  });

  // String? cca2;
  // String? ccn3;
  // String? cca3;
  // String? cioc;
  // Idd? idd;
  Map<String, Translation>? translations;
  // Demonyms? demonyms;
  // Map<String, dynamic>? gini;
  // String? fifa;
  // PostalCode? postalCode;

  Name? name;
  List<String>? tld;
  bool? independent;
  String? status;
  bool? unMember;
  Map<String, Aed>? currencies;
  List<String>? capital;
  List<String>? altSpellings;
  String? region;
  String? subregion;
  Map<String, dynamic>? languages;
  List<double>? latlng;
  bool? landlocked;
  List<String>? borders;
  double? area;
  String? flag;
  Maps? maps;
  int? population;
  Car? car;
  List<String>? timezones;
  List<String>? continents;
  CoatOfArms? flags;
  CoatOfArms? coatOfArms;
  String? startOfWeek;
  CapitalInfo? capitalInfo;

  factory RestCountryModel.fromJson(Map<String, dynamic> json) =>
      RestCountryModel(
        name: json["name"] == null
            ? Name(
                common: "",
                // official: "",
              )
            : Name.fromJson(json["name"]),
        tld: json["tld"] == null
            ? []
            : List<String>.from(json["tld"].map((x) => x)),
        // cca2: json["cca2"] ?? "",
        // ccn3: json["ccn3"] ?? "",
        // cca3: json["cca3"] ?? "",
        // cioc: json["cioc"] ?? "",
        independent: json["independent"] ?? false,
        status: json["status"] ?? "",
        unMember: json["unMember"] ?? false,
        currencies: json["currencies"] == null
            ? null
            : Map.from(json["currencies"])
                .map((k, v) => MapEntry<String, Aed>(k, Aed.fromJson(v))),
        // idd: json["idd"] == null
        //     ? Idd(root: "", suffixes: [])
        //     : Idd.fromJson(json["idd"]),
        capital: json["capital"] == null
            ? []
            : List<String>.from(json["capital"].map((x) => x)),
        altSpellings: json["altSpellings"] == null
            ? []
            : List<String>.from(json["altSpellings"].map((x) => x)),
        region: json["region"] ?? "",
        subregion: json["subregion"] ?? "",
        languages: json["languages"],
        translations: json["translations"] == null
            ? null
            : Map.from(json["translations"]).map((k, v) =>
                MapEntry<String, Translation>(k, Translation.fromJson(v))),
        latlng: json["latlng"] == null
            ? []
            : List<double>.from(json["latlng"].map((x) => x.toDouble())),
        landlocked: json["landlocked"] ?? false,
        borders: json["borders"] == null
            ? []
            : List<String>.from(json["borders"].map((x) => x)),
        area: json["area"] == null ? "" : json["area"].toDouble(),
        // demonyms: json["demonyms"] == null
        //     ? Demonyms()
        //     : Demonyms.fromJson(json["demonyms"]),
        flag: json["flag"] ?? "",
        maps: json["maps"] == null
            ? Maps(
                googleMaps: "",
                openStreetMaps: "",
              )
            : Maps.fromJson(json["maps"]),
        population: json["population"] ?? "",
        // gini: json["gini"],
        // fifa: json["fifa"] ?? "",
        car: json["car"] == null
            ? Car(signs: [], side: "")
            : Car.fromJson(json["car"]),
        timezones: json["timezones"] == null
            ? []
            : List<String>.from(json["timezones"].map((x) => x)),
        continents: json["continents"] == null
            ? []
            : List<String>.from(json["continents"].map((x) => x)),
        flags: json["flags"] == null
            ? CoatOfArms(
                png: "",
                svg: "",
              )
            : CoatOfArms.fromJson(json["flags"]),
        coatOfArms: json["coatOfArms"] == null
            ? CoatOfArms(
                png: "",
                svg: "",
              )
            : CoatOfArms.fromJson(json["coatOfArms"]),
        startOfWeek: json["startOfWeek"] ?? "",
        capitalInfo: json["capitalInfo"] == null
            ? CapitalInfo(latlng: [])
            : CapitalInfo.fromJson(json["capitalInfo"]),
        // postalCode: json["postalCode"] == null
        //     ? PostalCode(format: "", regex: "")
        //     : PostalCode.fromJson(json["postalCode"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "tld": tld,
        // "cca2": cca2,
        // "ccn3": ccn3,
        // "cca3": cca3,
        // "cioc": cioc,
        "independent": independent,
        "status": status,
        "unMember": unMember,
        "currencies": currencies,
        // "idd": idd,
        "capital": capital,
        "altSpellings": altSpellings,
        "region": region,
        "subregion": subregion,
        "languages": languages,
        "translations": translations,
        "latlng": latlng,
        "landlocked": landlocked,
        "borders": borders,
        "area": area,
        // "demonyms": demonyms,
        "flag": flag,
        "maps": maps,
        "population": population,
        // "gini": gini,
        // "fifa": fifa,
        "car": car,
        "timezones": timezones,
        "continents": continents,
        "flags": flags,
        "coatOfArms": coatOfArms,
        "startOfWeek": startOfWeek,
        "capitalInfo": capitalInfo,
        // "postalCode": postalCode,
      };
}

class CapitalInfo {
  CapitalInfo({
    this.latlng,
  });

  List<double>? latlng;

  factory CapitalInfo.fromJson(Map<String, dynamic> json) => CapitalInfo(
        latlng: json["latlng"] == null
            ? []
            : List<double>.from(json["latlng"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "latlng":
            latlng == null ? null : List<dynamic>.from(latlng!.map((x) => x)),
      };
}

class Car {
  Car({
    this.signs,
    this.side,
  });

  List<String>? signs;
  String? side;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        signs: json["signs"] == null
            ? []
            : List<String>.from(json["signs"].map((x) => x)),
        side: json["side"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "signs": signs,
        "side": side,
      };
}

class CoatOfArms {
  CoatOfArms({
    this.png,
    this.svg,
  });

  String? png;
  String? svg;

  factory CoatOfArms.fromJson(Map<String, dynamic> json) => CoatOfArms(
        png: json["png"] ?? "",
        svg: json["svg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "png": png,
        "svg": svg,
      };
}

class Aed {
  Aed({
    this.name,
    this.symbol,
  });

  String? name;
  String? symbol;

  factory Aed.fromJson(Map<String, dynamic> json) => Aed(
        name: json["name"] ?? "",
        symbol: json["symbol"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
      };
}

class Bam {
  Bam({
    this.name,
  });

  String? name;

  factory Bam.fromJson(Map<String, dynamic> json) => Bam(
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Demonyms {
  Demonyms({
    this.eng,
    this.fra,
  });

  Eng? eng;
  Eng? fra;

  factory Demonyms.fromJson(Map<String, dynamic> json) => Demonyms(
        eng: json["eng"] == null ? Eng() : Eng.fromJson(json["eng"]),
        fra: json["fra"] == null ? Eng() : Eng.fromJson(json["fra"]),
      );

  Map<String, dynamic> toJson() => {
        "eng": eng,
        "fra": fra,
      };
}

class Eng {
  Eng({
    this.f,
    this.m,
  });

  String? f;
  String? m;

  factory Eng.fromJson(Map<String, dynamic> json) => Eng(
        f: json["f"] ?? "",
        m: json["m"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "f": f,
        "m": m,
      };
}

class Idd {
  Idd({
    this.root,
    this.suffixes,
  });

  String? root;
  List<String>? suffixes;

  factory Idd.fromJson(Map<String, dynamic> json) => Idd(
        root: json["root"] ?? "",
        suffixes: json["suffixes"] == null
            ? []
            : List<String>.from(json["suffixes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "root": root,
        "suffixes": suffixes == null
            ? null
            : List<dynamic>.from(suffixes!.map((x) => x)),
      };
}

class Maps {
  Maps({
    this.googleMaps,
    this.openStreetMaps,
  });

  String? googleMaps;
  String? openStreetMaps;

  factory Maps.fromJson(Map<String, dynamic> json) => Maps(
        googleMaps: json["googleMaps"] ?? "",
        openStreetMaps: json["openStreetMaps"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "googleMaps": googleMaps,
        "openStreetMaps": openStreetMaps,
      };
}

class Name {
  Name({
    this.common,
    // this.official,
    // this.nativeName,
  });

  String? common;
  // String? official;
  // Map<String, Translation>? nativeName;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        common: json["common"] ?? "",
        // official: json["official"] ?? "",
        // nativeName: json["nativeName"] == null
        //     ? {}
        //     : Map.from(json["nativeName"]).map((k, v) =>
        //         MapEntry<String, Translation>(k, Translation.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "common": common,
        // "official": official,
        // "nativeName": nativeName == null
        //     ? null
        //     : Map.from(nativeName)
        //         .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Translation {
  Translation({
    this.official,
    this.common,
  });

  String? official;
  String? common;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        official: json["official"] ?? "",
        common: json["common"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "official": official,
        "common": common,
      };
}

class PostalCode {
  PostalCode({
    this.format,
    this.regex,
  });

  String? format;
  String? regex;

  factory PostalCode.fromJson(Map<String, dynamic> json) => PostalCode(
        format: json["format"] ?? "",
        regex: json["regex"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "format": format,
        "regex": regex,
      };
}
