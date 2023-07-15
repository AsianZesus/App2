import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<Message> _messages = [];
  final Map<String, String?> predefinedResponses = {
    'What is the app about?': 'The app is designed to...',
    'How do I get started?': 'To get started, you need to...',
    'Can I customize the settings?':
        'Yes, you can customize the settings by...',
    // Add more predefined questions and answers as needed
  };

  final TextEditingController _textEditingController = TextEditingController();
  List<String> questions = [];
  int currentQuestionIndex = -1;

  bool _isWaitingForResponse = false;

  @override
  void initState() {
    super.initState();
    questions = predefinedResponses.keys.toList();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  leading: message.sender == 'User'
                      ? const CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/images/apple.png'),
                        )
                      : const CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/images/splash.png'),
                        ),
                  title: Text(message.text),
                  subtitle: Text(message.sender),
                );
              },
            ),
          ),
          Container(
            height: 48.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final isSelected = index == currentQuestionIndex;
                return Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      if (!_isWaitingForResponse) {
                        setState(() {
                          currentQuestionIndex = index;
                          _sendMessage(questions[currentQuestionIndex]);
                        });
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.black,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        questions[index],
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                  ),
                  onSubmitted: _sendMessage,
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (!_isWaitingForResponse) {
                    _sendMessage(_getTextFromTextField());
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    setState(() {
      final userMessage = Message(text: text, sender: 'User');
      _messages.insert(0, userMessage);

      if (currentQuestionIndex != -1 && !_isWaitingForResponse) {
        final question = questions[currentQuestionIndex];
        final response = predefinedResponses[question];
        setState(() {
          _isWaitingForResponse = true;
        });
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            final chatbotResponse =
                Message(text: response ?? '', sender: 'Floodbot');
            _messages.insert(0, chatbotResponse);
            _isWaitingForResponse = false;
          });
        });
      }

      _textEditingController.clear();
      currentQuestionIndex = -1;
    });
  }

  String _getTextFromTextField() {
    return _textEditingController.text.trim();
  }
}

class Message {
  final String text;
  final String sender;

  Message({required this.text, required this.sender});
}
