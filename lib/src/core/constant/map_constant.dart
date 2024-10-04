
import 'package:bird_guard/src/core/classes/enum.dart';

class MapConstant {
  static Map <String,ConversationStatus> conversationStatusMap = {
    'Near Threatened (NT)' : ConversationStatus.nt,
    'Critically Endangered (CR)' : ConversationStatus.cr,
    'Endangered (EN)' : ConversationStatus.en,
    'Least Concerned (LC)' : ConversationStatus.lc,
    'Least Concerned' : ConversationStatus.lc,
    'Vulnerable (VU)' : ConversationStatus.vu
  };
}