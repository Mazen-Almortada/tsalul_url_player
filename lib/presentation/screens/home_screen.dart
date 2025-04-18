import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsalul_url_player/core/theme/app_theme.dart';
import 'package:tsalul_url_player/domain/entities/link_entity.dart';
import 'package:tsalul_url_player/presentation/bloc/link_bloc/link_bloc.dart';
import 'package:tsalul_url_player/presentation/screens/search_screen.dart';
import 'package:tsalul_url_player/presentation/widgets/link_bottom_sheet.dart';
import 'package:tsalul_url_player/presentation/widgets/link_card.dart';
import 'package:tsalul_url_player/presentation/widgets/search_bar_widget.dart';
import 'package:tsalul_url_player/presentation/widgets/theme_switch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(),
      body: Column(children: [_buildAppBar(), Expanded(child: _buildBody())]),
      floatingActionButton: _buildFAB(context),
    );
  }

  Widget _buildAppBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 50, 16, _isSearching ? 12 : 24),
      decoration: BoxDecoration(
        gradient:
            Theme.of(context).brightness == Brightness.dark
                ? AppTheme.darkGrayGradient
                : AppTheme.yellowGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tsalul URL Player',
                style: AppTheme.headline2Style.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              ThemeSwitch(),
            ],
          ),
          const SizedBox(height: 20),

          SearchBarWidget(
            onTap: () async {
              setState(() => _isSearching = true);
              await Future.delayed(const Duration(milliseconds: 400));
              if (mounted) {
                await Navigator.push(
                  // ignore: use_build_context_synchronously
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const SearchPage(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
                setState(() => _isSearching = false);
              }
            },
          ),
        ],
      ),
    );
    // return AppBar(
    //   backgroundColor: Colors.transparent,
    //   elevation: 0,
    //   centerTitle: true,
    //   title: const Text('TUP'),
    //   actions: const [ThemeSwitch()],
    // );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<LinkBloc, LinkState>(
        builder: (context, state) {
          if (state is LinkLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LinkError) {
            return Center(child: Text(state.message));
          } else if (state is LinkLoaded) {
            return _buildLinksList(state.links.reversed.toList());
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildLinksList(List<LinkEntity> links) {
    return ListView.builder(
      itemCount: links.length,
      itemBuilder: (context, index) {
        final link = links[index];
        return LinkCard(link: link);
      },
    );
  }

  FloatingActionButton _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddLinkBottomSheet(context),
      shape: CircleBorder(),
      child: const Icon(Icons.add),
    );
  }

  void _showAddLinkBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => LinkBottomSheet(),
    );
  }
}
