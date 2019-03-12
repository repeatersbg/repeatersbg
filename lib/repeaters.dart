// To parse this JSON data, do
//
//     final repeaters = repeatersFromJson(jsonString);

import 'dart:convert';

RepeatersList repeatersListFromJson(String str) {
    final jsonData = json.decode(str);
    return RepeatersList.fromJson(jsonData);
}

String repeatersListToJson(RepeatersList data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class RepeatersList {
    List<Repeater> repeaters;

    RepeatersList({
        this.repeaters,
    });

    factory RepeatersList.fromJson(Map json) => new RepeatersList(
        repeaters: new List<Repeater>.from(json["repeaters"].map((x) => Repeater.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "repeaters": new List<dynamic>.from(repeaters.map((x) => x.toJson())),
    };
}

class Repeater {
    String irlp;
    String altitude;
    Band band;
    String callsign;
    String channel;
    Ctcss ctcss;
    String details;
    String echolink;
    String repeaterIn;
    String lat;
    String location;
    String locationEnglish;
    String long;
    Mode mode;
    String out;
    String qthr;
    Status status;
    String trustee;

    Repeater({
        this.irlp,
        this.altitude,
        this.band,
        this.callsign,
        this.channel,
        this.ctcss,
        this.details,
        this.echolink,
        this.repeaterIn,
        this.lat,
        this.location,
        this.locationEnglish,
        this.long,
        this.mode,
        this.out,
        this.qthr,
        this.status,
        this.trustee,
    });

    factory Repeater.fromJson(Map json) => new Repeater(
        irlp: json["IRLP"],
        altitude: json["altitude"],
        band: bandValues.map[json["band"]],
        callsign: json["callsign"],
        channel: json["channel"],
        ctcss: ctcssValues.map[json["ctcss"]],
        details: json["details"],
        echolink: json["echolink"],
        repeaterIn: json["in"],
        lat: json["lat"],
        location: json["location"],
        locationEnglish: json["location-english"],
        long: json["long"],
        mode: modeValues.map[json["mode"]],
        out: json["out"],
        qthr: json["qthr"],
        status: statusValues.map[json["status"]],
        trustee: json["trustee"],
    );

    Map<String, dynamic> toJson() => {
        "IRLP": irlp,
        "altitude": altitude,
        "band": bandValues.reverse[band],
        "callsign": callsign,
        "channel": channel,
        "ctcss": ctcssValues.reverse[ctcss],
        "details": details,
        "echolink": echolink,
        "in": repeaterIn,
        "lat": lat,
        "location": location,
        "location-english": locationEnglish,
        "long": long,
        "mode": modeValues.reverse[mode],
        "out": out,
        "qthr": qthr,
        "status": statusValues.reverse[status],
        "trustee": trustee,
    };
}

enum Band { THE_70_CM, THE_2_M }

final bandValues = new EnumValues({
    "2M": Band.THE_2_M,
    "70CM": Band.THE_70_CM
});

enum Ctcss { THE_797, EMPTY, THE_744, THE_915, THE_1035 }

final ctcssValues = new EnumValues({
    "": Ctcss.EMPTY,
    "103.5": Ctcss.THE_1035,
    "74.4": Ctcss.THE_744,
    "79.7": Ctcss.THE_797,
    "91.5": Ctcss.THE_915
});

enum Mode { ANALOG, DSTAR }

final modeValues = new EnumValues({
    "analog": Mode.ANALOG,
    "DSTAR": Mode.DSTAR
});

enum Status { OPERATIONAL, NON_OPERATIONAL, MAINTENANCE }

final statusValues = new EnumValues({
    "maintenance": Status.MAINTENANCE,
    "non-operational": Status.NON_OPERATIONAL,
    "operational": Status.OPERATIONAL
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
