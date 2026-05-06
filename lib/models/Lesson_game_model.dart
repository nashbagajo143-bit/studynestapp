import 'package:flutter/material.dart';

class LessonGame {
  final String id;
  final String title;
  final String gameTitle;
  final String gameDescription;
  final IconData gameIcon;
  final Color gameColor;
  final String gameImage;
  final int highScore;
  final String bestTime;
  final int level;

  const LessonGame({
    required this.id,
    required this.title,
    required this.gameTitle,
    required this.gameDescription,
    required this.gameIcon,
    required this.gameColor,
    required this.gameImage,
    required this.highScore,
    required this.bestTime,
    required this.level,
  });
}

class Aralin {
  final int number;
  final String title;
  final String topic;       // grammar/skill focus in parentheses
  final int page;
  final String content;     // short lesson summary shown in review
  final LessonGame? game;   // null = no game for this lesson

  const Aralin({
    required this.number,
    required this.title,
    required this.topic,
    required this.page,
    required this.content,
    this.game,
  });

  bool get hasGame => game != null;
}

class Yunit {
  final int number;
  final String title;
  final List<Aralin> lessons;

  const Yunit({
    required this.number,
    required this.title,
    required this.lessons,
  });
}

// ─────────────────────────────────────────────────────────────
//  Data — All 4 units from the textbook photos
// ─────────────────────────────────────────────────────────────
final List<Yunit> allYunits = [

  // ── YUNIT 1: Ako sa Aking Sambahayan ─────────────────────
  Yunit(
    number: 1,
    title: 'Ako sa Aking Sambahayan',
    lessons: [
      Aralin(
        number: 1,
        title: 'Simula ang Ibig Sabihin',
        topic: 'Pangngalan',
        page: 13,
        content: 'Matuto tungkol sa mga pangngalan at ang kanilang kahulugan sa pang-araw-araw na buhay.',
        game: const LessonGame(
          id: 'noun_match',
          title: 'Noun Match',
          gameTitle: 'Noun Match',
          gameDescription: 'Match the pangngalan to their correct pictures!',
          gameIcon: Icons.abc_rounded,
          gameColor: Color(0xFF7C3AED),
          gameImage: 'https://api.dicebear.com/9.x/bottts/png?seed=nounmatch&backgroundColor=ede9fe',
          highScore: 0,
          bestTime: '--:--',
          level: 1,
        ),
      ),
      Aralin(
        number: 2,
        title: "Biyaya Mo'y Kagila-gilalas",
        topic: 'Awit',
        page: 20,
        content: 'Pag-aralan ang isang awit na nagpapakita ng pagpapasalamat sa mga biyaya ng Diyos.',
        // No game
      ),
      Aralin(
        number: 3,
        title: 'Usapan sa AUP Store',
        topic: 'Mga salitang may paggalang',
        page: 28,
        content: 'Matuto ng mga magagalang na salitang ginagamit sa pang-araw-araw na pakikipag-usap.',
        game: const LessonGame(
          id: 'polite_words',
          title: 'Polite Words',
          gameTitle: 'Word Sort',
          gameDescription: 'Sort the magalang na salita from rude ones!',
          gameIcon: Icons.sort_rounded,
          gameColor: Color(0xFF10B981),
          gameImage: 'https://api.dicebear.com/9.x/bottts/png?seed=politewords&backgroundColor=d1fae5',
          highScore: 0,
          bestTime: '--:--',
          level: 2,
        ),
      ),
      Aralin(
        number: 4,
        title: 'Tumingin sa mga Langgam',
        topic: 'Elemento ng Tula',
        page: 33,
        content: 'Alamin ang mga elemento ng tula tulad ng sukat, tugma, at imahe.',
        // No game
      ),
      Aralin(
        number: 5,
        title: 'Ang Batang Pari',
        topic: 'Dalawang Uri ng Pangngalan',
        page: 43,
        content: 'Pag-aralan ang dalawang uri ng pangngalan: pantangi at pambalana.',
        game: const LessonGame(
          id: 'noun_types',
          title: 'Noun Types',
          gameTitle: 'Noun Sorter',
          gameDescription: 'Sort pangngalang pantangi vs pambalana!',
          gameIcon: Icons.category_rounded,
          gameColor: Color(0xFFF59E0B),
          gameImage: 'https://api.dicebear.com/9.x/bottts/png?seed=nountypes&backgroundColor=fef3c7',
          highScore: 0,
          bestTime: '--:--',
          level: 3,
        ),
      ),
      Aralin(
        number: 6,
        title: 'Ang Nagagawa ng Panalangin',
        topic: 'Panghalip',
        page: 50,
        content: 'Matuto ng mga panghalip at kung paano gamitin ang mga ito nang wasto.',
        // No game
      ),
      Aralin(
        number: 7,
        title: 'Iniahon mula sa Tubig',
        topic: 'Paggamit ng Talatinigan',
        page: 57,
        content: 'Alamin kung paano gamitin ang talatinigan upang mahanap ang kahulugan ng mga salita.',
        game: const LessonGame(
          id: 'dictionary_hunt',
          title: 'Dictionary Hunt',
          gameTitle: 'Dictionary Hunt',
          gameDescription: 'Find the meaning of words in the talatinigan!',
          gameIcon: Icons.search_rounded,
          gameColor: Color(0xFFEF4444),
          gameImage: 'https://api.dicebear.com/9.x/bottts/png?seed=dictionary&backgroundColor=fee2e2',
          highScore: 0,
          bestTime: '--:--',
          level: 2,
        ),
      ),
    ],
  ),

  // ── YUNIT 2: Ako sa Aking Pamayanan ──────────────────────
  Yunit(
    number: 2,
    title: 'Ako sa Aking Pamayanan',
    lessons: [
      Aralin(
        number: 1,
        title: 'Paano na Kung?',
        topic: 'Pang-uri',
        page: 72,
        content: 'Alamin ang mga pang-uri at kung paano nila inilalarawan ang mga pangngalan.',
        game: const LessonGame(
          id: 'adjective_race',
          title: 'Adjective Race',
          gameTitle: 'Pang-uri Race',
          gameDescription: 'Choose the correct pang-uri for each picture!',
          gameIcon: Icons.speed_rounded,
          gameColor: Color(0xFF3B82F6),
          gameImage: 'https://api.dicebear.com/9.x/bottts/png?seed=adjrace&backgroundColor=dbeafe',
          highScore: 1250,
          bestTime: '2:15',
          level: 4,
        ),
      ),
      Aralin(
        number: 2,
        title: 'Ang Pamilyang Nakasumpong ng Biyaya',
        topic: 'Liham Paanyaya',
        page: 80,
        content: 'Pag-aralan ang wastong paraan ng pagsulat ng liham paanyaya.',
        // No game
      ),
      Aralin(
        number: 3,
        title: 'Purihin ang Panginoon sa Hirap at Ginhawa',
        topic: 'Pandiwa',
        page: 92,
        content: 'Alamin ang mga pandiwa at ang kanilang papel sa pangungusap.',
        game: const LessonGame(
          id: 'verb_blast',
          title: 'Verb Blast',
          gameTitle: 'Pandiwa Blast',
          gameDescription: 'Identify the pandiwa in each sentence before time runs out!',
          gameIcon: Icons.flash_on_rounded,
          gameColor: Color(0xFF10B981),
          gameImage: 'https://api.dicebear.com/9.x/bottts/png?seed=verbblast&backgroundColor=d1fae5',
          highScore: 89,
          bestTime: '1:42',
          level: 5,
        ),
      ),
      Aralin(
        number: 4,
        title: 'Tumitingin sa Puso',
        topic: 'Pang-uri',
        page: 99,
        content: 'Dagdag na pag-aaral ng mga pang-uri at iba\'t ibang uri nito.',
        // No game
      ),
      Aralin(
        number: 5,
        title: 'Ang Mapapalad',
        topic: 'Aspekto ng Pandiwa',
        page: 106,
        content: 'Pag-aralan ang tatlong aspekto ng pandiwa: naganap, nagaganap, at mangyayari.',
        game: const LessonGame(
          id: 'verb_tense',
          title: 'Verb Tense',
          gameTitle: 'Aspekto Challenge',
          gameDescription: 'Match the pandiwa to the correct aspekto!',
          gameIcon: Icons.access_time_rounded,
          gameColor: Color(0xFF8B5CF6),
          gameImage: 'https://api.dicebear.com/9.x/bottts/png?seed=verbtense&backgroundColor=ede9fe',
          highScore: 342,
          bestTime: '3:28',
          level: 6,
        ),
      ),
      Aralin(
        number: 6,
        title: 'Nasa Kanya na ang Lahat',
        topic: 'Pang-uring Panlarawan',
        page: 114,
        content: 'Alamin ang mga pang-uring panlarawan at kung paano ginagamit ang mga ito.',
        // No game
      ),
      Aralin(
        number: 7,
        title: 'Ipinanganak ang Tagapagligtas',
        topic: 'Sanhi at Bunga',
        page: 122,
        content: 'Pag-aralan ang relasyon ng sanhi at bunga sa mga pangyayari.',
        game: const LessonGame(
          id: 'cause_effect',
          title: 'Cause & Effect',
          gameTitle: 'Sanhi at Bunga',
          gameDescription: 'Connect each sanhi to its correct bunga!',
          gameIcon: Icons.link_rounded,
          gameColor: Color(0xFFEF4444),
          gameImage: 'https://api.dicebear.com/9.x/bottts/png?seed=causeeffect&backgroundColor=fee2e2',
          highScore: 210,
          bestTime: '1:58',
          level: 4,
        ),
      ),
    ],
  ),

  // ── YUNIT 3: Ako sa Aking Kapaligiran ────────────────────
  Yunit(
    number: 3,
    title: 'Ako sa Aking Kapaligiran',
    lessons: [
      Aralin(
        number: 1,
        title: 'Pagiging Katiwala / Bantay',
        topic: 'Pang-abay',
        page: 134,
        content: 'Alamin ang mga pang-abay at kung paano nila binabago ang kahulugan ng pandiwa.',
        game: const LessonGame(
          id: 'adverb_hunt',
          title: 'Adverb Hunt',
          gameTitle: 'Pang-abay Hunt',
          gameDescription: 'Find all the pang-abay hidden in the sentences!',
          gameIcon: Icons.search_rounded,
          gameColor: Color(0xFF0EA5E9),
          gameImage: 'https://api.dicebear.com/9.x/bottts/png?seed=adverbhunt&backgroundColor=e0f2fe',
          highScore: 1890,
          bestTime: '0:56',
          level: 7,
        ),
      ),
      Aralin(
        number: 2,
        title: 'Mabuti sa Iyo at sa Akin',
        topic: 'Uri ng Pang-abay',
        page: 142,
        content: 'Pag-aralan ang iba\'t ibang uri ng pang-abay: pamanahon, pananlunan, at paraan.',
        // No game
      ),
      Aralin(
        number: 3,
        title: 'Mga Puno na Itinanim: Nakalulugod sa Paningin',
        topic: 'Pang-angkop',
        page: 151,
        content: 'Matuto tungkol sa pang-angkop na "na" at "ng" at ang tamang paggamit nito.',
        game: const LessonGame(
          id: 'linker_game',
          title: 'Linker Game',
          gameTitle: 'Pang-angkop Quiz',
          gameDescription: 'Choose na or ng to complete each sentence correctly!',
          gameIcon: Icons.join_inner_rounded,
          gameColor: Color(0xFF10B981),
          gameImage: 'https://api.dicebear.com/9.x/bottts/png?seed=linker&backgroundColor=d1fae5',
          highScore: 0,
          bestTime: '--:--',
          level: 5,
        ),
      ),
      Aralin(
        number: 4,
        title: 'Kamangha-manghang Manlalalang',
        topic: 'Pangatnig',
        page: 160,
        content: 'Alamin ang mga pangatnig at kung paano nila pinagtatambal ang mga pangungusap.',
        // No game
      ),
      Aralin(
        number: 5,
        title: 'Ang Samaritanong Hero',
        topic: 'Opinyon at katotohanan',
        page: 167,
        content: 'Pag-aralan ang pagkakaiba ng opinyon at katotohanan sa mga babasahin.',
        game: const LessonGame(
          id: 'fact_opinion',
          title: 'Fact or Opinion',
          gameTitle: 'Fact or Opinion?',
          gameDescription: 'Sort each statement: Katotohanan o Opinyon?',
          gameIcon: Icons.balance_rounded,
          gameColor: Color(0xFFF59E0B),
          gameImage: 'https://api.dicebear.com/9.x/bottts/png?seed=factopinion&backgroundColor=fef3c7',
          highScore: 0,
          bestTime: '--:--',
          level: 6,
        ),
      ),
      Aralin(
        number: 6,
        title: 'Ang Dalawang Nagtayo ng Bahay',
        topic: 'Simuno at Panaguri',
        page: 175,
        content: 'Alamin ang simuno at panaguri bilang mga pangunahing bahagi ng pangungusap.',
        // No game
      ),
      Aralin(
        number: 7,
        title: 'Pinagpala sa Lahat ng Bagay',
        topic: 'Pagsulat ng Sulatin',
        page: 182,
        content: 'Matuto kung paano magsulat ng maikling sulatin batay sa nabasang kwento.',
        // No game
      ),
    ],
  ),

  // ── YUNIT 4: Ako sa Bagong Sanlibutan ────────────────────
  Yunit(
    number: 4,
    title: 'Ako sa Bagong Sanlibutan',
    lessons: [
      Aralin(
        number: 1,
        title: 'Ang Bagong Langit at ang Bagong Lupa',
        topic: 'Pangungusap',
        page: 195,
        content: 'Pag-aralan ang wastong pagbuo ng pangungusap at ang mga bahagi nito.',
        game: const LessonGame(
          id: 'sentence_builder',
          title: 'Sentence Builder',
          gameTitle: 'Pangungusap Builder',
          gameDescription: 'Arrange the words to form a correct pangungusap!',
          gameIcon: Icons.text_fields_rounded,
          gameColor: Color(0xFF7C3AED),
          gameImage: 'https://api.dicebear.com/9.x/bottts/png?seed=sentence&backgroundColor=ede9fe',
          highScore: 0,
          bestTime: '--:--',
          level: 5,
        ),
      ),
      Aralin(
        number: 2,
        title: 'Ang Kautusan ng Diyos',
        topic: 'Pagsulat ng Balita',
        page: 202,
        content: 'Alamin ang mga sangkap ng balita at ang tamang paraan ng pagsulat nito.',
        // No game
      ),
      Aralin(
        number: 3,
        title: 'Ang Kapahingahan',
        topic: 'Uri ng Pangungusap',
        page: 210,
        content: 'Pag-aralan ang apat na uri ng pangungusap: pasalaysay, patanong, pautos, at padamdam.',
        game: const LessonGame(
          id: 'sentence_types',
          title: 'Sentence Types',
          gameTitle: 'Uri ng Pangungusap',
          gameDescription: 'Classify each sentence: pasalaysay, patanong, pautos, o padamdam!',
          gameIcon: Icons.quiz_rounded,
          gameColor: Color(0xFF3B82F6),
          gameImage: 'https://api.dicebear.com/9.x/bottts/png?seed=sentencetype&backgroundColor=dbeafe',
          highScore: 0,
          bestTime: '--:--',
          level: 6,
        ),
      ),
      Aralin(
        number: 4,
        title: 'Ilog ng Buhay',
        topic: 'Infomersyal',
        page: 217,
        content: 'Matuto tungkol sa infomersyal at ang mga katangian nito bilang uri ng pahayag.',
        // No game
      ),
      Aralin(
        number: 5,
        title: 'Panawagan Tungo sa Banal na Pamumuhay',
        topic: 'Editoryal',
        page: 224,
        content: 'Alamin ang layunin at katangian ng editoryal bilang uri ng pagsulat.',
        // No game
      ),
      Aralin(
        number: 6,
        title: 'Ang Bautismo',
        topic: 'Ang Balangkas',
        page: 231,
        content: 'Pag-aralan kung paano gumawa ng balangkas para sa isang paksa o kwento.',
        game: const LessonGame(
          id: 'outline_game',
          title: 'Outline Game',
          gameTitle: 'Balangkas Builder',
          gameDescription: 'Arrange the ideas into the correct balangkas order!',
          gameIcon: Icons.format_list_numbered_rounded,
          gameColor: Color(0xFF10B981),
          gameImage: 'https://api.dicebear.com/9.x/bottts/png?seed=outline&backgroundColor=d1fae5',
          highScore: 0,
          bestTime: '--:--',
          level: 7,
        ),
      ),
      Aralin(
        number: 7,
        title: 'Ang Ikalawang Pagdating ni Cristo',
        topic: 'Radio Broadcast / Teleradyo',
        page: 238,
        content: 'Alamin ang kaibahan ng radio broadcast at teleradyo bilang mga uri ng pahayag.',
        // No game
      ),
    ],
  ),
];