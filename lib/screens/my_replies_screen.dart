import 'package:flutter/material.dart';

class MyRepliesScreen extends StatefulWidget {
  final ValueChanged<String>? onDiscussionTap;

  const MyRepliesScreen({
    super.key,
    this.onDiscussionTap,
  });

  @override
  State<MyRepliesScreen> createState() => _MyRepliesScreenState();
}

class _MyRepliesScreenState extends State<MyRepliesScreen> {
  int selectedTab = 0;

  // ============================================================
  // DEMO MAP DATA
  // ============================================================

  final List<Map<String, dynamic>> items = [
    {
      'discussionId': 'discuss1',
      'discussionTitle': 'Tomato leaves turning yellow',
      'discussionDescription':
          'Check for micronutrient deficiency...',
      'authorName': 'Farmer1',
      'imageUrl': '',
      'time': '1h ago',
      'likeCount': 4,
      'replyCount': 2,
      'isLiked': true,
    },

    {
      'discussionId': 'discuss2',
      'discussionTitle': 'Which fertilizer for onion?',
      'discussionDescription':
          'Use DAP for better results...',
      'authorName': 'Farmer2',
      'imageUrl': '',
      'time': '9h ago',
      'likeCount': 3,
      'replyCount': 5,
      'isLiked': true,
    },

    {
      'discussionId': 'discuss3',
      'discussionTitle': 'Pest in chili crop',
      'discussionDescription':
          'Try neem oil spray...',
      'authorName': 'Farmer3',
      'imageUrl': '',
      'time': '1d ago',
      'likeCount': 5,
      'replyCount': 3,
      'isLiked': true,
    },
  ];

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF087F5B);
    const darkGreen = Color(0xFF173D2D);

    // ==========================================================
    // FILTER DATA
    // ==========================================================

    final List<Map<String, dynamic>> displayedItems;

    if (selectedTab == 0) {
      // ALL
      displayedItems = items;
    } else {
      // LIKED
      displayedItems = items
          .where(
            (item) => item['isLiked'] == true,
          )
          .toList();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAFCFA),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back,
            color: darkGreen,
            size: 24,
          ),
        ),

        titleSpacing: 0,

        title: const Text(
          'My Replies',
          style: TextStyle(
            color: darkGreen,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: Column(
        children: [

          // ======================================================
          // TABS
          // ======================================================

          Container(
            width: double.infinity,
            color: Colors.white,

            padding: const EdgeInsets.only(
              left: 16,
              top: 8,
              bottom: 9,
            ),

            child: Row(
              children: [

                // =================================================
                // ALL TAB
                // =================================================

                _TabButton(
                  title: 'All',
                  selected: selectedTab == 0,

                  onTap: () {
                    setState(() {
                      selectedTab = 0;
                    });
                  },
                ),

                const SizedBox(width: 8),

                // =================================================
                // LIKED TAB
                // =================================================

                _TabButton(
                  title: 'Liked',
                  selected: selectedTab == 1,

                  onTap: () {
                    setState(() {
                      selectedTab = 1;
                    });
                  },
                ),
              ],
            ),
          ),

          // ======================================================
          // REPLY LIST
          // ======================================================

          Expanded(
            child: displayedItems.isEmpty
                ? const Center(
                    child: Text(
                      'No liked replies yet.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF687970),
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.only(
                      top: 3,
                      bottom: 20,
                    ),

                    itemCount: displayedItems.length,

                    separatorBuilder:
                        (context, index) {
                      return const Divider(
                        height: 1,
                        thickness: 0.6,
                        color: Color(0xFFE8EDE9),
                      );
                    },

                    itemBuilder: (context, index) {
                      final item =
                          displayedItems[index];

                      return _ReplyTile(
                        item: item,

                        onTap: () {
                          if (widget.onDiscussionTap !=
                              null) {
                            widget.onDiscussionTap!(
                              item['discussionId']
                                  .toString(),
                            );
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ==================================================================
// TAB BUTTON
// ==================================================================

class _TabButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF087F5B);

    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 150),

        height: 32,

        padding: const EdgeInsets.symmetric(
          horizontal: 21,
        ),

        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: selected
              ? green
              : const Color(0xFFF0F4F1),

          borderRadius:
              BorderRadius.circular(9),
        ),

        child: Text(
          title,

          style: TextStyle(
            color: selected
                ? Colors.white
                : const Color(0xFF60756A),

            fontSize: 12,

            fontWeight: selected
                ? FontWeight.w600
                : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ==================================================================
// REPLY TILE
// ==================================================================

class _ReplyTile extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const _ReplyTile({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF173D2D);

    return Material(
      color: Colors.white,

      child: InkWell(
        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),

          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // =================================================
              // IMAGE
              // =================================================

              _DiscussionImage(
                imageUrl:
                    item['imageUrl']?.toString() ?? '',
              ),

              const SizedBox(width: 10),

              // =================================================
              // RIGHT CONTENT
              // =================================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    // ==========================================
                    // TITLE + TIME
                    // ==========================================

                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Expanded(
                          child: Text(
                            item['discussionTitle']
                                    ?.toString() ??
                                '',

                            maxLines: 1,

                            overflow:
                                TextOverflow.ellipsis,

                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight:
                                  FontWeight.w700,
                              color: darkGreen,
                            ),
                          ),
                        ),

                        const SizedBox(width: 5),

                        Text(
                          item['time']?.toString() ?? '',

                          style: const TextStyle(
                            fontSize: 9,
                            color:
                                Color(0xFF87968E),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // ==========================================
                    // DESCRIPTION
                    // ==========================================

                    Text(
                      item['discussionDescription']
                              ?.toString() ??
                          '',

                      maxLines: 1,

                      overflow:
                          TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF78877F),
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ==========================================
                    // LIKE + COMMENT
                    // ==========================================

                    Row(
                      children: [

                        // HEART
                        const Icon(
                          Icons.favorite,
                          size: 17,
                          color: Color(0xFFE9294F),
                        ),

                        const SizedBox(width: 5),

                        Text(
                          '${item['likeCount'] ?? 0}',

                          style: const TextStyle(
                            fontSize: 10,
                            color:
                                Color(0xFF66756E),
                            fontWeight:
                                FontWeight.w500,
                          ),
                        ),

                        const SizedBox(width: 17),

                        // COMMENT
                        const Icon(
                          Icons.chat_bubble_outline,
                          size: 17,
                          color: Color(0xFF7C8983),
                        ),

                        const SizedBox(width: 5),

                        Text(
                          '${item['replyCount'] ?? 0}',

                          style: const TextStyle(
                            fontSize: 10,
                            color:
                                Color(0xFF66756E),
                            fontWeight:
                                FontWeight.w500,
                          ),
                        ),
                      ],
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
// DISCUSSION IMAGE
// ==================================================================

class _DiscussionImage extends StatelessWidget {
  final String imageUrl;

  const _DiscussionImage({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(7),

      child: SizedBox(
        width: 50,
        height: 50,

        child: imageUrl.trim().isEmpty
            ? _placeholder()
            : Image.network(
                imageUrl,

                width: 50,
                height: 50,

                fit: BoxFit.cover,

                errorBuilder:
                    (context, error, stackTrace) {
                  return _placeholder();
                },
              ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 50,
      height: 50,

      color: const Color(0xFFEAF2EC),

      child: const Icon(
        Icons.agriculture,
        size: 26,
        color: Color(0xFF087F5B),
      ),
    );
  }
}