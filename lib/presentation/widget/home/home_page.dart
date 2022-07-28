import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_ahead/core/common/extensions/text_style_reducer.dart';
import 'package:search_ahead/core/common/utils/keyboard_helper.dart';
import 'package:search_ahead/core/coordinator/coordinator.dart';
import 'package:search_ahead/core/di/service_locator.dart';
import 'package:search_ahead/core/model/home/event.dart';
import 'package:search_ahead/presentation/bloc/common/value_notifier_cubit.dart';
import 'package:search_ahead/presentation/bloc/common/value_notifier_state.dart';
import 'package:search_ahead/presentation/bloc/home/home_cubit.dart';
import 'package:search_ahead/presentation/bloc/home/home_state.dart';
import 'package:search_ahead/presentation/widget/common/overflow_text_field.dart';
import 'package:search_ahead/presentation/widget/common/search_scaffold.dart';
import 'package:search_ahead/presentation/widget/home/itemwidget/event_item_widget.dart';

class MyHomePage extends StatefulWidget with AutoRouteWrapper {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<HomeCubit>(),
      child: this,
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late HomeCubit _homeCubit;
  late ValueNotifierCubit<bool> _notifierCubit;
  Timer? _debounce;
  var firstStart = true;
  int radNum = 0;
  bool showClearIcon = false;
  List<Event> prevEventList = [];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode(descendantsAreFocusable: false);
    _textEditingController.addListener(_performSearch);

    _notifierCubit = sl.get<ValueNotifierCubit<bool>>(param1: false);
    _homeCubit = BlocProvider.of<HomeCubit>(context);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _performSearch() {
    _homeCubit.shouldShowClearIcon(_textEditingController.value.text);
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(
      Duration(
          milliseconds: _textEditingController.value.text.isEmpty ? 50 : 400),
      () {
        _homeCubit.performSearch(_textEditingController.value.text);
      },
    );
  }

  Widget buildSearchTextField(bool isShowClearIcon) {
    return OverflowTextField(
      maxLines: 1,
      minLines: null,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      focusNode: _focusNode,
      showCursor: KeyboardHelper.detectKeyboardVisibility(context),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      inputFormatters: [LengthLimitingTextInputFormatter(50)],
      cursorColor: Colors.blueAccent,
      cursorHeight: Platform.isAndroid ? 20 : null,
      controller: _textEditingController,
      textCapitalization: TextCapitalization.sentences,
      style: black16w400,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
              color: Colors.blueAccent,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: Colors.transparent,
              )),
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "Type here",
          hintStyle: black16w400.copyWith(color: Colors.grey),
          suffixIconConstraints:
              const BoxConstraints(minWidth: 20, minHeight: 56),
          suffixIcon: isShowClearIcon
              ? IconButton(
                  onPressed: () => _textEditingController.clear(),
                  padding: const EdgeInsets.all(2.0),
                  icon: const Icon(Icons.close),
                )
              : const IconButton(
                  onPressed: null,
                  padding: EdgeInsets.all(2.0),
                  icon: Icon(Icons.search),
                )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValueNotifierCubit<bool>, ValueNotifierState<bool>>(
        bloc: _notifierCubit,
        builder: (context, state) {
          var focusedState = firstStart ? true : _focusNode.hasFocus;
          if (state is InitialValueNotifierState<bool>) {
            focusedState = state.value;
          }
          if (state is UpdateValueNotifierState<bool>) {
            focusedState = state.value;
          }
          return SearchScaffold(
            _buildAppBar(),
            _buildScaffoldBody(),
            _buildSearchUi(),
            isFocusedState: focusedState,
          );
        });
  }

  AppBar _buildAppBar() {
    return AppBar(
      key: scaffoldKey,
      title: Column(
        children: [
          Text(
            "Search Ahead",
            style: black20w800.copyWith(color: Colors.white),
          ),
        ],
      ),
      centerTitle: true,
      elevation: 0.0,
      toolbarHeight: 48,
      flexibleSpace: Container(),
      leading: sl.get<Coordinator>().canPop(context)
          ? IconButton(
              onPressed: () {
                sl.get<Coordinator>().pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 24,
              ),
            )
          : null,
    );
  }

  Widget _buildScaffoldBody() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prevState, nextState) {
        if (prevState == nextState ||
            (nextState is InitialHomeState &&
                !firstStart &&
                _textEditingController.value.text.length >= 3) ||
            nextState is ShowTextFieldClearIcon ||
            (nextState is DoneLoadResultsState &&
                prevEventList == nextState.eventList)) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if (state is InitialHomeState) {
          if (state.length <= 0) {
            if (firstStart) {
              firstStart = false;
              _focusNode.requestFocus();
            }
            return Container();
          } else {
            return _buildResultsView(isInvalid: true, eventList: []);
          }
        }

        if (state is LoadingHomeState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is DoneLoadResultsState &&
            _textEditingController.value.text.isNotEmpty) {
          return _buildResultsView(eventList: state.eventList);
        }

        if (state is EmptyHomeState) {
          return _buildEmptyScreen();
        }

        if (state is ErrorHomeState) {
          return _buildErrorScreen();
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSearchUi() {
    _notifierCubit
        .updateValue(KeyboardHelper.detectKeyboardVisibility(context));
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _homeCubit,
      buildWhen: (p, c) => c is InitialHomeState || c is ShowTextFieldClearIcon,
      builder: (context, state) {
        if (state is InitialHomeState) {
          if (state.length == 0) {
            return buildSearchTextField(false);
          }
          return buildSearchTextField(true);
        }
        if (state is ShowTextFieldClearIcon) {
          return buildSearchTextField(state.shouldShowIcon);
        }

        return buildSearchTextField(false);
      },
    );
  }

  Widget _buildResultsView(
      {required List<Event> eventList, bool isInvalid = false}) {
    return Column(
      children: [
        const SizedBox(
          height: 35,
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: isInvalid
                ? _buildInvalidSearchEntryMessageView()
                : _buildEventList(eventList: eventList),
          ),
        ),
      ],
    );
  }

  Widget _buildEventList({required List<Event> eventList}) {
    if (prevEventList != eventList) {
      radNum = Random().nextInt(200);
      prevEventList = eventList;
    }

    return ListView.separated(
      shrinkWrap: true,
      key: PageStorageKey<String>('channel$radNum'),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: eventList.length,
      padding: const EdgeInsets.only(right: 16, left: 4),
      itemBuilder: (BuildContext context, int index) {
        var event = eventList[index];
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '${eventList.length} results for keyword ${_textEditingController.value.text}',
                  style: black12w400.copyWith(color: Colors.blueGrey),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              EventItemWidget(
                callback: _focusNode.unfocus,
                eventItem: event,
                updateIsFav: (newState) {
                  _homeCubit.performSearch(_textEditingController.value.text,
                      isRefresh: true);
                },
              ),
            ],
          );
        }
        return EventItemWidget(
          callback: _focusNode.unfocus,
          eventItem: event,
          updateIsFav: (newState) {
            _homeCubit.performSearch(_textEditingController.value.text,
                isRefresh: true);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 16,
        );
      },
    );
  }

  Widget _buildInvalidSearchEntryMessageView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Text(
            'Invalid search entry',
            style: black24w800,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Text(
            'Please enter more than 2 characters',
            style: black16w400.copyWith(height: 1.375),
          ),
        )
      ],
    );
  }

  Widget _buildEmptyScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            'No results found',
            style: black24w800,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Please ensure words are spelled correctly',
            style: black16w400.copyWith(height: 1.375),
          )
        ],
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            'An unexpected error occurred',
            style: black24w800,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Please try again later',
            style: black16w400.copyWith(height: 1.375),
          )
        ],
      ),
    );
  }
}
