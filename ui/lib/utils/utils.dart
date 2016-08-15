class Utils {
  static RegExp LOG_FORMAT_REGEXP_WILDFLY = new RegExp(r"^(^.*m)?( +)?(\d{4}-\d{2}-\d{2})?( +)?(\d{1,2}:\d{1,2}:\d{1,2},\d{1,3}) ([^\s]+) (.*)");

  static Map retryFormatWildfly({String log}) {
    Map json = new Map();

    // Test the fomat
    json.addAll(retryFormat(log: log, regExp: LOG_FORMAT_REGEXP_WILDFLY));

    // Check if always empty , check if contains started by any JAVA error
    if(json.isEmpty && (log.contains("Caused by:") || log.contains("Exception in"))) {
      json['level'] = "ERROR";
      json['message'] = log;
    }

    return json;
  }

  static Map retryFormat({String log, RegExp regExp}) {
    Map json = new Map();
    var matches = regExp.allMatches(log);
    if(matches.isNotEmpty){
      Match match = matches.elementAt(0);
      if (match.groupCount == 7) {
        json['time_forward'] = match[5].trim();
        json['level'] = match[6].trim();
        json['message'] = match[7].trim();
      }
    }

    return json;
  }
}
