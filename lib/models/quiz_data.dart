import '../models/question.dart';

class QuizData {
  static final List<Question> questions = [
    const Question(
      id: '1',
      question: 'Kapan KMNZ pertama kali debut sebagai unit VTuber?',
      options: ['2016', '2018', '2019', '2020'],
      correctAnswerIndex: 1,
    ),
    const Question(
      id: '2',
      question: 'Siapa dua anggota asli KMNZ saat debut?',
      options: ['LITA & LIZ', 'NERO & TINA', 'LITA & NERO', 'LIZ & TINA'],
      correctAnswerIndex: 0,
    ),
    const Question(
      id: '3',
      question: 'Dari kata apa nama "KMNZ" berasal?',
      options: ['"kemono" (binatang)', '"kamon" (kain)', 'Singkatan acak', 'Kata Inggris "kmon"'],
      correctAnswerIndex: 0,
    ),
    const Question(
      id: '4',
      question: 'Genre musik utama KMNZ adalah apa?',
      options: ['Pop', 'Hip-hop / Rap', 'Klasik', 'Rock'],
      correctAnswerIndex: 1,
    ),
    const Question(
      id: '5',
      question: 'Siapa anggota yang mengumumkan kelulusan efektif akhir 2023?',
      options: ['LITA', 'LIZ', 'NERO', 'TINA'],
      correctAnswerIndex: 1,
    ),
    const Question(
      id: '6',
      question: 'Anggota baru mana yang bergabung dan mengubah lineup pada 2024?',
      options: ['NERO & TINA', 'LITA & NERO', 'LIZ & TINA', 'LITA & LIZ'],
      correctAnswerIndex: 0,
    ),
    const Question(
      id: '7',
      question: 'Album mana yang dirilis KMNZ pada 2019?',
      options: ['KMNVERSE', 'KMNROUND', 'KMNSTREET', 'KMNCULTURE'],
      correctAnswerIndex: 0,
    ),
    const Question(
      id: '8',
      question: 'KMNZ sering disebut terkait dengan platform atau label apa?',
      options: ['REALITY / RK Music', 'Hololive', 'Nijisanji', 'VShojo'],
      correctAnswerIndex: 0,
    ),
    const Question(
      id: '9',
      question: 'Apa ciri khas visual dan branding KMNZ?',
      options: ['Robot futuristik', 'Bertelinga binatang / tema kemono', 'Superhero', 'Makhluk luar angkasa'],
      correctAnswerIndex: 1,
    ),
    const Question(
      id: '10',
      question: 'Album mana yang termasuk rilisan mereka pada 2022?',
      options: ['KMNVERSE', 'KMNROUND', 'KMNSTREET', 'KMNCULTURE'],
      correctAnswerIndex: 2,
    ),
  ];
}