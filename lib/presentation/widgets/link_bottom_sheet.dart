// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tsalul_url_player/domain/entities/link_entity.dart';
// import 'package:tsalul_url_player/presentation/bloc/link_bloc/link_bloc.dart';

// class AddLinkBottomSheet extends StatefulWidget {
//   const AddLinkBottomSheet({super.key});

//   @override
//   State<AddLinkBottomSheet> createState() => _AddLinkBottomSheetState();
// }

// class _AddLinkBottomSheetState extends State<AddLinkBottomSheet> {
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _urlController = TextEditingController();

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _urlController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(
//                   labelText: 'Title',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a title';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _urlController,
//                 decoration: const InputDecoration(
//                   labelText: 'URL',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a URL';
//                   }
//                   if (!Uri.tryParse(value)!.hasAbsolutePath) {
//                     return 'Please enter a valid URL';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _saveLink,
//                 child: const Text('Save Link'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _saveLink() {
//     if (_formKey.currentState!.validate()) {
//       context.read<LinkBloc>().add(
//         AddLink(
//           LinkEntity(
//             title: _titleController.text,
//             url: _urlController.text,
//             createdAt: DateTime.now(),
//           ),
//         ),
//       );
//       Navigator.pop(context);
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsalul_url_player/core/services/service_locator.dart';
import 'package:tsalul_url_player/core/theme/app_theme.dart';
import 'package:tsalul_url_player/domain/entities/link_entity.dart';
import 'package:tsalul_url_player/presentation/bloc/link_bloc/link_bloc.dart';

class LinkBottomSheet extends StatefulWidget {
  const LinkBottomSheet({super.key, this.linkEntity});
  final LinkEntity? linkEntity;
  @override
  State<LinkBottomSheet> createState() => _LinkBottomSheetState();
}

class _LinkBottomSheetState extends State<LinkBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();

  late LinkBloc _linkBloc;

  @override
  void initState() {
    _linkBloc = sl<LinkBloc>();
    if (widget.linkEntity != null) {
      _titleController.text = widget.linkEntity?.title ?? '';
      _urlController.text = widget.linkEntity?.url ?? '';
    }
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    _linkBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: BlocListener<LinkBloc, LinkState>(
          bloc: _linkBloc,
          listener: (context, state) {
            if (state is LinkError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppTheme.redDarkPastel,
                ),
              );
              Navigator.pop(context);
            } else if (state is LinkLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Link saved successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
              context.read<LinkBloc>().add(LoadLinks());
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.linkEntity == null
                          ? 'Add New Link'
                          : "Update Link",
                      style: AppTheme.titleStyle,
                    ),
                    IconButton(
                      icon: Icon(Icons.close, size: 24),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Title Field
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(hintText: 'Enter link title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                TextFormField(
                  controller: _urlController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(hintText: 'https://example.com'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a URL';
                    }
                    // final pattern =
                    //     r'^(https?:\/\/)?([\w\-]+\.)+[\w]{2,}(\/\S*)?$';
                    // final regex = RegExp(pattern);

                    // if (!regex.hasMatch(value.trim())) {
                    //   return 'Please enter a valid URL';
                    // }
                    return null;
                  },
                ),
                SizedBox(height: 24),

                _buildButton(
                  label:
                      widget.linkEntity == null ? "Save Link" : "Update Link",
                  icon: Icons.save,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.linkEntity != null) {
                        _linkBloc.add(
                          UpdateLink(
                            LinkEntity(
                              createdAt: widget.linkEntity!.createdAt,
                              id: widget.linkEntity!.id,
                              title: _titleController.text,
                              url: _urlController.text,
                            ),
                          ),
                        );
                      } else {
                        _linkBloc.add(
                          AddLink(
                            LinkEntity(
                              createdAt: DateTime.now(),
                              title: _titleController.text,
                              url: _urlController.text,
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
                SizedBox(height: 15),
                widget.linkEntity != null
                    ? _buildButton(
                      onPressed: () {
                        _linkBloc.add(DeleteLink(widget.linkEntity!.id));
                        Navigator.pop(context);
                        context.read<LinkBloc>().add(LoadLinks());
                      },
                      label: "Delete Link",
                      icon: Icons.delete,
                      backgroundColor: AppTheme.redDarkPastel,
                    )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildButton({
    IconData? icon,
    required String label,
    required void Function()? onPressed,
    Color? backgroundColor,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: icon != null ? Icon(icon, color: Colors.white) : null,
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppTheme.darkYellow,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        onPressed: onPressed,
      ),
    );
  }
}
