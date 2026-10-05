import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/reply_item.dart';

class ReplyService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  // ============================================================
  // GET MY REPLIES
  // ============================================================

  Future<List<ReplyItem>> getMyReplies() async {

    // ----------------------------------------------------------
    // TEMPORARY USER ID
    // ----------------------------------------------------------
    //
    // You previously used:
    //
    // authId = 1
    //
    // So this is currently 1.
    //
    // Later replace this with the logged-in user's authId.
    // ----------------------------------------------------------

    const int currentAuthId = 1;

    // ----------------------------------------------------------
    // GET REPLIES
    // ----------------------------------------------------------

    final replySnapshot = await _firestore
        .collection('replies')
        .where(
          'authId',
          isEqualTo: currentAuthId,
        )
        .get();

    List<ReplyItem> result = [];

    // ----------------------------------------------------------
    // PROCESS EACH REPLY
    // ----------------------------------------------------------

    for (final replyDoc
        in replySnapshot.docs) {

      final replyData = replyDoc.data();

      // --------------------------------------------------------
      // DISCUSSION ID
      // --------------------------------------------------------

      final String discussionId =
          replyData['discussionId']
                  ?.toString() ??
              '';

      if (discussionId.isEmpty) {
        continue;
      }

      // --------------------------------------------------------
      // GET DISCUSSION
      // --------------------------------------------------------

      final discussionDoc =
          await _firestore
              .collection('discussions')
              .doc(discussionId)
              .get();

      if (!discussionDoc.exists) {
        continue;
      }

      final discussionData =
          discussionDoc.data();

      if (discussionData == null) {
        continue;
      }

      // --------------------------------------------------------
      // CREATED AT
      // --------------------------------------------------------

      DateTime? replyDate;

      final createdAt =
          replyData['createdAt'];

      if (createdAt is Timestamp) {
        replyDate = createdAt.toDate();
      }

      // --------------------------------------------------------
      // CREATE REPLY ITEM
      // --------------------------------------------------------

      result.add(
        ReplyItem(
          discussionId: discussionId,

          discussionTitle:
              discussionData['discussionTitle']
                      ?.toString() ??
                  '',

          discussionDescription:
              discussionData['description']
                      ?.toString() ??
                  '',

          authorName:
              discussionData['authorName']
                      ?.toString() ??
                  '',

          imageUrl:
              discussionData['imageUrl']
                      ?.toString() ??
                  '',

          replyDate: replyDate,

          content:
              replyData['content']
                      ?.toString() ??
                  '',

          likeCount:
              _getInt(
            discussionData['likeCount'],
          ),

          replyCount:
              _getInt(
            discussionData['replyCount'],
          ),

          isLiked:
              replyData['isLiked'] == true,
        ),
      );
    }

    // ----------------------------------------------------------
    // NEWEST REPLIES FIRST
    // ----------------------------------------------------------

    result.sort((a, b) {
      if (a.replyDate == null &&
          b.replyDate == null) {
        return 0;
      }

      if (a.replyDate == null) {
        return 1;
      }

      if (b.replyDate == null) {
        return -1;
      }

      return b.replyDate!
          .compareTo(a.replyDate!);
    });

    return result;
  }

  // ============================================================
  // SAFE INTEGER
  // ============================================================

  int _getInt(dynamic value) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return 0;
  }
}