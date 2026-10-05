class ReplyItem {
  final String discussionId;

  final String discussionTitle;

  final String discussionDescription;

  final String authorName;

  final String imageUrl;

  final DateTime? replyDate;

  final String content;

  final int likeCount;

  final int replyCount;

  final bool isLiked;

  ReplyItem({
    required this.discussionId,
    required this.discussionTitle,
    required this.discussionDescription,
    required this.authorName,
    required this.imageUrl,
    required this.replyDate,
    required this.content,
    required this.likeCount,
    required this.replyCount,
    required this.isLiked,
  });
}