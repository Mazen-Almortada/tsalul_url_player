import 'package:flutter/material.dart';
import 'package:tsalul_url_player/core/theme/app_theme.dart';
import 'package:tsalul_url_player/domain/entities/link_entity.dart';
import 'package:tsalul_url_player/presentation/widgets/link_bottom_sheet.dart';

class LinkCard extends StatelessWidget {
  final LinkEntity link;

  const LinkCard({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),

      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showEditBottomSheet(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const Icon(Icons.link, size: 28, color: Colors.blueAccent),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      link.title,
                      style: AppTheme.titleStyle.copyWith(
                        color: Theme.of(context).textTheme.titleMedium?.color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      link.url,
                      style: AppTheme.darkSubtitleStyle(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.play_circle_fill_rounded,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          // ignore: deprecated_member_use
                          ? Colors.white.withOpacity(0.6)
                          // ignore: deprecated_member_use
                          : AppTheme.darkYellow.withOpacity(0.6),
                  size: 28,
                ),
                onPressed: () => _playLink(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => LinkBottomSheet(linkEntity: link),
    );
  }

  void _playLink(BuildContext context) {
    // Placeholder: Implement actual link opening or playback
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Opening ${link.url}')));
  }
}
