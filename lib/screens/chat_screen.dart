import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // ============================================================
  // COLORS
  // ============================================================

  static const Color green = Color(0xFF087F5B);
  static const Color darkGreen = Color(0xFF173D2D);

  // ============================================================
  // SEARCH
  // ============================================================

  final TextEditingController searchController = TextEditingController();

  String searchText = '';

  // ============================================================
  // DEMO CHAT DATA
  // ============================================================

  final List<Map<String, dynamic>> chats = [
    {
      'id': 'chat1',
      'name': 'Mahesh Agro Center',
      'message': 'Tomato leaves issue',
      'time': '2m ago',
      'unreadCount': 2,
      'imageUrl': '',
    },
    {
      'id': 'chat2',
      'name': 'Ganesh Traders',
      'message': 'Fertilizer suggestion',
      'time': '1h ago',
      'unreadCount': 1,
      'imageUrl': '',
    },
    {
      'id': 'chat3',
      'name': 'Suresh Agro',
      'message': 'Pest control discussion',
      'time': '2h ago',
      'unreadCount': 0,
      'imageUrl': '',
    },
    {
      'id': 'chat4',
      'name': 'Pravin Agri Store',
      'message': 'Seed variety',
      'time': '3h ago',
      'unreadCount': 0,
      'imageUrl': '',
    },
  ];

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      setState(() {
        searchText = searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // FILTER CHAT DATA
  // ============================================================

  List<Map<String, dynamic>> get filteredChats {
    if (searchText.trim().isEmpty) {
      return chats;
    }

    return chats.where((chat) {
      final name = chat['name'].toString().toLowerCase();

      final message = chat['message'].toString().toLowerCase();

      return name.contains(searchText) || message.contains(searchText);
    }).toList();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ========================================================
      // YOUR EXISTING CHAT UI
      // ========================================================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: darkGreen, size: 25),
        ),

        titleSpacing: 0,

        title: const Text(
          'Chat',
          style: TextStyle(
            color: darkGreen,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ========================================================
      // YOUR EXISTING CHAT BODY
      // ========================================================
      body: Column(
        children: [
          // ======================================================
          // SEARCH BAR
          // ======================================================
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),

            child: Container(
              height: 46,

              decoration: BoxDecoration(
                color: const Color(0xFFFAFCFA),

                borderRadius: BorderRadius.circular(8),

                border: Border.all(color: const Color(0xFFE6ECE8)),
              ),

              child: TextField(
                controller: searchController,

                decoration: const InputDecoration(
                  border: InputBorder.none,

                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF71827A),
                    size: 24,
                  ),

                  hintText: 'Search chats...',

                  hintStyle: TextStyle(color: Color(0xFFA4B2AA), fontSize: 14),

                  contentPadding: EdgeInsets.symmetric(vertical: 13),
                ),
              ),
            ),
          ),

          // ======================================================
          // CHAT LIST
          // ======================================================
          Expanded(
            child: filteredChats.isEmpty
                ? _emptySearch()
                : ListView.separated(
                    padding: const EdgeInsets.only(top: 3, bottom: 20),

                    itemCount: filteredChats.length,

                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                        thickness: 0.6,
                        color: Color(0xFFE8EDE9),
                        indent: 82,
                        endIndent: 16,
                      );
                    },

                    itemBuilder: (context, index) {
                      final chat = filteredChats[index];

                      return _ChatTile(
                        chat: chat,
                        onTap: () {
                          _openChat(chat);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY SEARCH
  // ============================================================

  Widget _emptySearch() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Icon(Icons.search_off, size: 45, color: Color(0xFFAAB8B1)),

          SizedBox(height: 12),

          Text(
            'No chats found',
            style: TextStyle(fontSize: 14, color: Color(0xFF687970)),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // OPEN CHAT
  // ============================================================

  void _openChat(Map<String, dynamic> chat) {
    Navigator.push(
      context,

      MaterialPageRoute(
        builder: (context) {
          return ChatDetailScreen(chatId: chat['id'], name: chat['name']);
        },
      ),
    );
  }
}

// ==================================================================
// CHAT TILE
// ==================================================================

class _ChatTile extends StatelessWidget {
  final Map<String, dynamic> chat;

  final VoidCallback onTap;

  const _ChatTile({required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF173D2D);

    final int unreadCount = chat['unreadCount'] ?? 0;

    return Material(
      color: Colors.white,

      child: InkWell(
        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

          child: Row(
            children: [
              // ==================================================
              // PROFILE IMAGE
              // ==================================================
              _ChatAvatar(imageUrl: chat['imageUrl'] ?? ''),

              const SizedBox(width: 14),

              // ==================================================
              // NAME + MESSAGE
              // ==================================================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      chat['name'] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        color: darkGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      chat['message'] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        color: Color(0xFF71827A),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // ==================================================
              // TIME + UNREAD
              // ==================================================
              SizedBox(
                width: 38,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    Text(
                      chat['time'] ?? '',

                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFFA0ADA7),
                      ),
                    ),

                    const SizedBox(height: 8),

                    if (unreadCount > 0)
                      Container(
                        width: 21,
                        height: 21,

                        alignment: Alignment.center,

                        decoration: const BoxDecoration(
                          color: Color(0xFF087F5B),
                          shape: BoxShape.circle,
                        ),

                        child: Text(
                          '$unreadCount',

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================================================================
// CHAT AVATAR
// ==================================================================

class _ChatAvatar extends StatelessWidget {
  final String imageUrl;

  const _ChatAvatar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        color: const Color(0xFFE8F2EC),

        border: Border.all(color: const Color(0xFFD5E4DB)),
      ),

      child: ClipOval(
        child: imageUrl.trim().isEmpty
            ? const Icon(Icons.person, size: 30, color: Color(0xFF087F5B))
            : Image.network(
                imageUrl,

                width: 52,
                height: 52,

                fit: BoxFit.cover,

                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.person,
                    size: 30,
                    color: Color(0xFF087F5B),
                  );
                },
              ),
      ),
    );
  }
}

// ==================================================================
// CHAT DETAIL
// ==================================================================

class ChatDetailScreen extends StatelessWidget {
  final String chatId;

  final String name;

  const ChatDetailScreen({super.key, required this.chatId, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),

        backgroundColor: const Color(0xFF087F5B),

        foregroundColor: Colors.white,
      ),

      body: Center(child: Text('Chat ID: $chatId')),
    );
  }
}
