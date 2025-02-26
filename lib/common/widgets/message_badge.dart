import 'package:flutter/material.dart';

class MessageBadge extends StatefulWidget {
  final int unreadCount;

  const MessageBadge({Key? key, required this.unreadCount}) : super(key: key);

  @override
  State<MessageBadge> createState() => _MessageBadgeState();
}

class _MessageBadgeState extends State<MessageBadge> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 小红点
        if (widget.unreadCount > 0)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            constraints: const BoxConstraints(
              minWidth: 20,
              minHeight: 20,
            ),
            child: Text(
              widget.unreadCount > 99 ? '99+' : '${widget.unreadCount}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}