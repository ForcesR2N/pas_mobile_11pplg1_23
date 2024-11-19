import 'package:flutter/material.dart';

class ExpandableDescription extends StatefulWidget {
  final String description;
  const ExpandableDescription({super.key, required this.description});

  @override
  State<ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool _isExpanded = false;

  static const int _maxLength = 200;

  @override
  Widget build(BuildContext context) {
    final shouldShowButton = widget.description.length > _maxLength;
    final displayText = shouldShowButton && !_isExpanded
        ? '${widget.description.substring(0, _maxLength)}...'
        : widget.description;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          displayText,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.5,
          ),
          textAlign: TextAlign.justify,
        ),
        if (shouldShowButton)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Row(
                children: [
                  Text(
                    _isExpanded ? 'Show Less' : 'Show More',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.blue,
                    size: 18,
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}
