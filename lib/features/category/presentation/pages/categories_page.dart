import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/category_card.dart';
import '../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/route/app_router.dart';
import '../../../../init_dependencies.dart';
import '../bloc/category_cubit.dart';
import '../bloc/category_state.dart';
import '../constants/category_constants.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<CategoryCubit>()..loadCategoriesIfNeeded(),
      child: const _CategoriesView(),
    );
  }
}

class _CategoriesView extends StatefulWidget {
  const _CategoriesView();

  @override
  State<_CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<_CategoriesView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll - CategoryConstants.scrollLoadThreshold) {
      context.read<CategoryCubit>().loadMoreCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.categories,
        showBackButton: false,
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading || state is CategoryInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CategoryError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message),
                  const SizedBox(height: CategoryConstants.productGridSpacing),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<CategoryCubit>().loadCategories(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is CategoryLoaded) {
            return RefreshIndicator(
              onRefresh: () => context.read<CategoryCubit>().loadCategories(),
              child: CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(
                      CategoryConstants.screenPadding,
                    ),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (_, index) {
                          final category = state.categories[index];
                          return CategoryCard(
                            category: category,
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.categoryProducts,
                              arguments: category,
                            ),
                          );
                        },
                        childCount: state.categories.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            CategoryConstants.categoryGridColumns,
                        mainAxisSpacing:
                            CategoryConstants.categoryMainAxisSpacing,
                        crossAxisSpacing:
                            CategoryConstants.categoryCrossAxisSpacing,
                        childAspectRatio:
                            CategoryConstants.categoryChildAspectRatio,
                      ),
                    ),
                  ),
                  if (state.isLoadingMore)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: CategoryConstants.screenPadding,
                        ),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
