import 'package:gsheets/gsheets.dart';

class UserSheetApi {
  static const _credential = r'''
{
  "type": "service_account",
  "project_id": "fluttersheet-413003",
  "private_key_id": "26ad68ada0bfd5f15c3de82106453389002fd24c",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDZWE9+4qMDJmHX\nTzK2u7OWrhT1Pr+FTNXlng3nEx5OKz/Ij3rIYdjWnVoERKwE7HMLudRQ/a7owMAO\njMqBpvq+LmnASZ2Gj1621fxJ8bz+ZxK9tdSclXerPaoKl/RANHInIsRYoqRLizXm\nrLDoK6U8mPAhz3ivQBZw44wVc1Lx/GnQY/Zf4DQmJUvzRPHty79B6N94Gt8Zb/AN\neBrtjjYRg3YSC+sIM23dXMaVsgIBkbFq0snH72/QXaSYlwc3+RvwnURgjjcENaKB\nWhqFF2FRyPycQhi1VKrAUOzcCpUCjocdL3n1kcE+Ncff3pVE1FNKfgVUVbWW1sii\n2HsTDMK7AgMBAAECggEAYfbDkiIOLrfIpvccGTA+cL7TVH0tbyRkTuRwSMSdxscI\nr1o4kgREa+utrLnVPTzkWBcxAzZs9Z0XlBdSmaDNaRZbdR/ZQFLz8n4+AohS0upb\nkKXaCJ/4OfeH4tF99siM4WXy0S6x1hkPuQMClAtEJa2boum0cG13D/gIZoy+CLKT\nyRJ4KSTQC+kIRhhRsZTXT5tiMMtIuLbm1rCRUC6ksvY81WzNPzOBISTDun886THl\nIwkQP82zDBwXOgndh1M1qtUoymWG93/bsop13+CB0Abs4z5egzmBFGG1CDpsHSCD\nqfG47yR3/crQbDeybh//Fbh+XR+QL3d36SHpfSs7lQKBgQDutmOc8NlkwG0ShbP0\n8nLJPnNZwXyHfErsbAplNxubtI7OcRCu2BYWuMExOYhqQqNRVpXzpsOFxeE0IJx6\nFlk7gDBTPbynhGGwaQ47xPTuXOtK3IwSIOnrQj/r3Q7DzgFr1Z4OCYR6hFNAzO3M\nxUfCQA7EH5XVAetdkWV8Ko4EzwKBgQDpFcdU0nyAhL18z+uLe9JaBhZussMgYPkU\nYKX3rK5Zk6mi3p2JiQMQwgLvbEPOEk2g9dshISILZkHgt/Yv7EfvU933siqH1W1V\nkXsnjtvRCcny4j+kFw7TW1MnrLAzQqnLRaZBrddaXtivY76jappmjVJs4i1Tj/p7\nP1SY8Ga2VQKBgQDqDNhUa22rNGR9MazFMOZM3Ld6vJQdv0cy0afLn6GpI/qU/RTP\nab0WoCWD3xYaoaXBvXSfBdZVFjR9yK/DoJ/zD/fR1glf8hNaRVcYUT+Zam+k4eNQ\nbwcLjNRhrUepwhVwpm0m9Dv5aD68nXFXQeLe2bHgp9tfk1czUbjAanT+zwKBgByU\nkxCPjryjiiiXxiYgVLa9MFr6iHqb6W7aOv+XqPlK5e4WpfKLXljbsUhyWg4WqHYo\nL2psiaQkMcfARuuxaVCrU/hfXF+zh+iKIjPDjKihLqYdn/ga67J27EddIW3nqrJG\nJBDBpDpsjt1SubmIBM62XXkEctJgQTKDnXfzYmTRAoGARrVD/MoMuP4wFAUfEP/f\nx3GM0Kn1H27x7TQJkWE6Dpi4uN3qC2SyLOZ3lc2xA5fmoBqXu16dGlfyhyLM86ZQ\nzvJb7UQgnG/QV3P/JeRzcRSILjyvdLquEmsEM9uyK9tmm2pKq4DMPMM6saHfFzr2\nkM0vSzhkxCZK5rFZbYfsttA=\n-----END PRIVATE KEY-----\n",
  "client_email": "fluttersheet@fluttersheet-413003.iam.gserviceaccount.com",
  "client_id": "116369637243443231513",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/fluttersheet%40fluttersheet-413003.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';
  static final _spreadhseetId = '1cPhMZquwNh9hU3xjL7UmU_fhq8ZeITrG9aPime4CtdM';
  static final _gsheet = GSheets(_credential);
  static Worksheet? _userSheet;

  static Future init() async {
    final spreadsheet = await _gsheet.spreadsheet(_spreadhseetId);
    _userSheet = await _getWorkSheet(spreadsheet, title: 'Test');
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
}
