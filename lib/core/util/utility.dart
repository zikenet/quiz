import 'package:html/parser.dart';

class Utility {
  String htmlDecoder(String string) {
    RegExp exp = RegExp(r"&(?:[a-z]+|#x?\d+);");
    Iterable<RegExpMatch> matches = exp.allMatches(string);
    Set<String> characters = {};
    for (final m in matches) {
      characters.add(m[0]!);
    }
    characters.toList().forEach((character) {
      string = string.replaceAll(character, parseFragment(character).text!);
    });
    return string;
  }
}
