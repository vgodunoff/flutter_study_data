import 'package:flutter/material.dart';
import 'package:flutter_study_data/work_with_net/widgets/example/example_model.dart';

class ExampleGetPost extends StatefulWidget {
  const ExampleGetPost({Key? key}) : super(key: key);

  @override
  State<ExampleGetPost> createState() => _ExampleGetPostState();
}

class _ExampleGetPostState extends State<ExampleGetPost> {
  final model = ExampleWidgetModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ExampleModelProvider(
          model: model,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              _ReloadButton(),
              _CreateButton(),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: _PostsWidget()),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ReloadButton extends StatelessWidget {
  const _ReloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () =>
            ExampleModelProvider.read(context)?.model.reloadPosts(),
        child: const Text('Обновить посты'));
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () =>
            ExampleModelProvider.read(context)?.model.createPosts(),
        child: const Text('Создать пост'));
  }
}

class _PostsWidget extends StatelessWidget {
  const _PostsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ExampleModelProvider.watch(context)?.model.posts.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return _PostsRowWidget(
            index: index,
          );
        });
  }
}

class _PostsRowWidget extends StatelessWidget {
  final int index;
  const _PostsRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = ExampleModelProvider.read(context)!.model.posts[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(post.id.toString()),
        const SizedBox(
          height: 10,
        ),
        Text(post.title),
        const SizedBox(
          height: 10,
        ),
        Text(post.body),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
