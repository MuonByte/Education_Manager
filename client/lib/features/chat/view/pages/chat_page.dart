import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<_Message> _messages = [];
  bool _isLoading = false;

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Message(text: text, isUser: true));
      _isLoading = true;
    });
    _controller.clear();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _messages.add(_Message(text: 'AI response for: "$text"', isUser: false));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F7),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildChatSections()),
            if (_isLoading) _buildStopButton(),
            if (!_isLoading) _buildRegenerateButton(),
            _buildInputField(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          GestureDetector(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back_ios, size: 20)),
          SizedBox(width: 12),
          Text('TutorAI', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Spacer(),
          Icon(Icons.more_horiz, size: 24),
        ],
      ),
    );
  }

  Widget _buildChatSections() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: _messages.length + (_isLoading ? 1 : 0),
      itemBuilder: (context, i) {
        if (_isLoading && i == _messages.length) {
          // placeholder for loading spot; button shown below
          return SizedBox.shrink();
        }
        final msg = _messages[i];
        return msg.isUser ? _UserSection(text: msg.text) : _AISection(text: msg.text);
      },
    );
  }

  Widget _buildStopButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.stop, color: Colors.black),
        label: Text('Stop generating...', style: TextStyle(color: Colors.black)),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildRegenerateButton() {
    if (_messages.any((m) => !m.isUser)) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.refresh, color: Colors.black),
          label: Text('Regenerate Response', style: TextStyle(color: Colors.black)),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            side: BorderSide(color: Colors.grey.shade300),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildInputField() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Send a message.',
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: _sendMessage,
            child: Icon(Icons.send, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _Message {
  final String text;
  final bool isUser;
  _Message({required this.text, required this.isUser});
}

class _UserSection extends StatelessWidget {
  final String text;
  const _UserSection({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.person_2_rounded, size: 30),
          SizedBox(width: 12),
          Expanded(child: Text(text)),
          Icon(Icons.edit, size: 20, color: Colors.grey),
        ],
      ),
    );
  }
}

class _AISection extends StatelessWidget {
  final String text;
  const _AISection({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFE5E5EA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/icon/app_icon.png', width: 55),
              SizedBox(width: 8),
              Spacer(),
              Icon(Icons.copy, size: 20),
              SizedBox(width: 12),
              Icon(Icons.share, size: 20),
            ],
          ),
          SizedBox(height: 8),
          Text(text),
        ],
      ),
    );
  }
}