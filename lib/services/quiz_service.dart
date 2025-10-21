import 'dart:math';

import '../models/question.dart';

class QuizService {
  // Full pool of questions. Add up to 40 items here. For brevity some are concise.
  final List<Question> _pool = [
    Question(
      id: 'q1',
      question: 'What does HTTP stand for?',
      options: [
        'HyperText Transfer Protocol',
        'Hyperlink Transfer Text Protocol',
        'HyperText Transmission Program',
        'Hyperlink Transmission Protocol',
      ],
      correctIndex: 0,
    ),
    Question(
      id: 'q2',
      question: 'Which language is primarily used for Android app development?',
      options: ['Swift', 'Kotlin', 'Dart', 'Objective-C'],
      correctIndex: 1,
    ),
    Question(
      id: 'q3',
      question: 'Which company developed the React library?',
      options: ['Google', 'Microsoft', 'Facebook', 'Twitter'],
      correctIndex: 2,
    ),
    Question(
      id: 'q4',
      question: 'What does CSS stand for?',
      options: [
        'Computer Style Sheets',
        'Cascading Style Sheets',
        'Creative Style System',
        'Coded Style Sheets',
      ],
      correctIndex: 1,
    ),
    Question(
      id: 'q5',
      question: 'Which database is a NoSQL document store?',
      options: ['PostgreSQL', 'MongoDB', 'MySQL', 'SQLite'],
      correctIndex: 1,
    ),
    Question(
      id: 'q6',
      question: 'What is the purpose of Git?',
      options: ['Design UI', 'Version control', 'Compile code', 'Run tests'],
      correctIndex: 1,
    ),
    Question(
      id: 'q7',
      question: 'Which protocol is used to securely browse the web?',
      options: ['HTTP', 'FTP', 'SSH', 'HTTPS'],
      correctIndex: 3,
    ),
    Question(
      id: 'q8',
      question: 'Flutter uses which programming language?',
      options: ['Java', 'Dart', 'C#', 'JavaScript'],
      correctIndex: 1,
    ),
    Question(
      id: 'q9',
      question: 'Which tool is commonly used for CI/CD?',
      options: ['Jenkins', 'Photoshop', 'Figma', 'Postman'],
      correctIndex: 0,
    ),
    Question(
      id: 'q10',
      question: 'What does CPU stand for?',
      options: [
        'Central Process Unit',
        'Central Processing Unit',
        'Control Processing Unit',
        'Computer Processing Unit',
      ],
      correctIndex: 1,
    ),
    Question(
      id: 'q11',
      question: 'What does SSD stand for?',
      options: [
        'Solid State Drive',
        'Secure Storage Disk',
        'Super Speed Drive',
        'Solid Storage Device',
      ],
      correctIndex: 0,
    ),
    Question(
      id: 'q12',
      question: 'Which IP version uses 128-bit addresses?',
      options: ['IPv4', 'IPv5', 'IPv6', 'IPv7'],
      correctIndex: 2,
    ),
    Question(
      id: 'q13',
      question: 'What is an API?',
      options: [
        'Application Programming Interface',
        'Applied Protocol Internet',
        'Advanced Programming Instruction',
        'Application Process Integration',
      ],
      correctIndex: 0,
    ),
    Question(
      id: 'q14',
      question: 'OAuth is primarily used for?',
      options: [
        'Data storage',
        'User authentication and authorization',
        'Designing UI',
        'Compiling code',
      ],
      correctIndex: 1,
    ),
    Question(
      id: 'q15',
      question: 'SQL is used to:',
      options: [
        'Style web pages',
        'Query relational databases',
        'Version control code',
        'Send HTTP requests',
      ],
      correctIndex: 1,
    ),
    Question(
      id: 'q16',
      question: 'Docker is a tool for:',
      options: [
        'Containerization',
        'Database management',
        'Mobile development',
        'Graphic design',
      ],
      correctIndex: 0,
    ),
    Question(
      id: 'q17',
      question: 'Kubernetes is used to:',
      options: [
        'Build mobile apps',
        'Orchestrate containers',
        'Design websites',
        'Monitor network traffic',
      ],
      correctIndex: 1,
    ),
    Question(
      id: 'q18',
      question: 'Which command lists files in Linux?',
      options: ['ls', 'dir', 'list', 'show'],
      correctIndex: 0,
    ),
    Question(
      id: 'q19',
      question: 'Big-O notation measures:',
      options: [
        'Storage size',
        'Algorithm complexity',
        'Network speed',
        'Battery life',
      ],
      correctIndex: 1,
    ),
    Question(
      id: 'q20',
      question: 'A byte contains how many bits?',
      options: ['4', '8', '16', '32'],
      correctIndex: 1,
    ),
    Question(
      id: 'q21',
      question: 'Unicode is primarily for:',
      options: [
        'Image formats',
        'Text encoding of many scripts',
        'Video compression',
        'Network protocols',
      ],
      correctIndex: 1,
    ),
    Question(
      id: 'q22',
      question: 'REST stands for:',
      options: [
        'Representational State Transfer',
        'Remote State Transfer',
        'Read Easily State Transfer',
        'Representational Static Transfer',
      ],
      correctIndex: 0,
    ),
    Question(
      id: 'q23',
      question: 'GraphQL is primarily used for:',
      options: [
        'Styling',
        'APIs with flexible queries',
        'Database engines',
        'OS kernels',
      ],
      correctIndex: 1,
    ),
    Question(
      id: 'q24',
      question: 'MVC is a pattern that stands for:',
      options: [
        'Model View Controller',
        'Main View Control',
        'Module View Class',
        'Model View Component',
      ],
      correctIndex: 0,
    ),
    Question(
      id: 'q25',
      question: 'Agile is a:',
      options: [
        'Programming language',
        'Project management methodology',
        'Database',
        'Encryption algorithm',
      ],
      correctIndex: 1,
    ),
    Question(
      id: 'q26',
      question: 'Scrum is associated with:',
      options: [
        'Agile process',
        'Database indexing',
        'Network routing',
        'Compiler optimization',
      ],
      correctIndex: 0,
    ),
    Question(
      id: 'q27',
      question: 'TDD stands for:',
      options: [
        'Test-Driven Development',
        'Type-Driven Design',
        'Test Data Deployment',
        'Time-Driven Debugging',
      ],
      correctIndex: 0,
    ),
    Question(
      id: 'q28',
      question: 'CI in CI/CD stands for:',
      options: [
        'Continuous Integration',
        'Centralized Interface',
        'Code Inspection',
        'Continuous Installation',
      ],
      correctIndex: 0,
    ),
    Question(
      id: 'q29',
      question: 'CD in CI/CD stands for:',
      options: [
        'Continuous Delivery/Deployment',
        'Code Distribution',
        'Content Delivery',
        'Continuous Debugging',
      ],
      correctIndex: 0,
    ),
    Question(
      id: 'q30',
      question: 'Semantic HTML improves:',
      options: [
        'Performance only',
        'Accessibility and SEO',
        'Color schemes',
        'Database access',
      ],
      correctIndex: 1,
    ),
    Question(
      id: 'q31',
      question: 'Flutter widget that does not hold state is:',
      options: [
        'StatefulWidget',
        'StatelessWidget',
        'InheritedWidget',
        'StreamBuilder',
      ],
      correctIndex: 1,
    ),
    Question(
      id: 'q32',
      question: 'Null safety helps prevent:',
      options: [
        'Memory leaks',
        'Null reference exceptions',
        'Slow performance',
        'Large binary size',
      ],
      correctIndex: 1,
    ),
    Question(
      id: 'q33',
      question: 'Garbage collection is used to:',
      options: [
        'Allocate new memory',
        'Automatically free unused memory',
        'Compile code',
        'Encrypt data',
      ],
      correctIndex: 1,
    ),
    Question(
      id: 'q34',
      question: 'Compiler vs Interpreter: a compiler:',
      options: [
        'Executes code line-by-line',
        'Translates entire source to machine code before running',
        'Is only for web',
        'Is a database tool',
      ],
      correctIndex: 1,
    ),
    Question(
      id: 'q35',
      question: 'Popular IDE for Flutter development is:',
      options: ['Android Studio', 'Photoshop', 'Excel', 'Notepad'],
      correctIndex: 0,
    ),
    Question(
      id: 'q36',
      question: 'Regex is used for:',
      options: [
        'Regular expression pattern matching',
        'Image editing',
        'Audio processing',
        'Network routing',
      ],
      correctIndex: 0,
    ),
    Question(
      id: 'q37',
      question: 'JSON stands for:',
      options: [
        'JavaScript Object Notation',
        'Java Serialized Object Notation',
        'Java Standard Output Notation',
        'JavaScript Ordered Notation',
      ],
      correctIndex: 0,
    ),
    Question(
      id: 'q38',
      question: 'SSL/TLS is used to:',
      options: [
        'Secure communications over a network',
        'Store files locally',
        'Render graphics',
        'Manage databases',
      ],
      correctIndex: 0,
    ),
    Question(
      id: 'q39',
      question: 'SSH is commonly used to:',
      options: [
        'Securely connect to remote servers',
        'Send emails',
        'Design UI',
        'Compile programs',
      ],
      correctIndex: 0,
    ),
    Question(
      id: 'q40',
      question: 'Which is a markup language?',
      options: ['HTML', 'C++', 'Python', 'Dart'],
      correctIndex: 0,
    ),
  ];

  // Return N random questions from the pool, shuffled.
  List<Question> loadQuestions({int count = 10}) {
    final rnd = Random();
    final poolCopy = List<Question>.from(_pool);
    poolCopy.shuffle(rnd);
    if (count >= poolCopy.length) return poolCopy;
    return poolCopy.sublist(0, count);
  }
}
