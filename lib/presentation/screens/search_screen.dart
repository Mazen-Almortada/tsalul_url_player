import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsalul_url_player/domain/entities/link_entity.dart';
import 'package:tsalul_url_player/presentation/bloc/link_bloc/link_bloc.dart';
import 'package:tsalul_url_player/presentation/widgets/link_card.dart';
import 'package:tsalul_url_player/presentation/widgets/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  void _onSearchChanged(String query) {
    if (query.isNotEmpty) {
      context.read<LinkBloc>().add(SearchLinks(query));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.read<LinkBloc>().add(LoadLinks());
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
              child: SearchBarWidget(
                onSearchChanged: _onSearchChanged,
                enabled: true,
              ),
            ),

            Expanded(
              child: BlocBuilder<LinkBloc, LinkState>(
                builder: (context, state) {
                  if (state is LinkLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LinkError) {
                    return Center(child: Text(state.message));
                  } else if (state is SearchLinkLoaded) {
                    final List<LinkEntity> links = state.links;
                    if (links.isEmpty) {
                      return const Center(child: Text("No Links found"));
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: links.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final link = links[index];
                        return LinkCard(link: link);
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
