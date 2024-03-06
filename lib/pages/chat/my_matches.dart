import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_madly_app/pages/chat/new_provider.dart';
import 'package:date_madly_app/utils/assert_re.dart';
import 'package:date_madly_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/text_feild_common.dart';
import '../../common/text_style.dart';
import '../../providers/chat_provider.dart';
import '../../utils/text_style.dart';
import '../../utils/texts.dart';
import 'chat_message.dart';

class MyMatches extends StatefulWidget {
  MyMatches({super.key, required this.chatUsers});
  final List chatUsers;

  @override
  State<MyMatches> createState() => _MyMatchesState();
}

class _MyMatchesState extends State<MyMatches> {
  List filterList = [];

  void searching(value) {
    filterList = (widget.chatUsers.where((element) {
      return element.participants![1].name
          .toString()
          .toLowerCase()
          .contains(value.toString().toLowerCase());
    }).toList());
    setState(() {});
    print(filterList);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorRes.white,
        appBar: AppBar(
          toolbarHeight: 65,
          centerTitle: true,
          backgroundColor: ColorRes.white,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: ColorRes.appColor,
                ),
              );
            },
          ),
          title: Text(
            Strings.matches,
            style: mulishbold.copyWith(
              fontSize: 18.75,
              color: ColorRes.appColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              NewTextField(
                controller: value.searchController,
                hintText: Strings.search_massages,
                prefix: AssertRe.Search_Icon,
                onChange: (p0) {
                  searching(p0);
                },
              ),
              SizedBox(
                height: 20,
              ),
              value.searchController.text.isEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.chatUsers.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          NewChatProvider newChatProvider =
                              Provider.of<NewChatProvider>(context,
                                  listen: false);
                          if (widget.chatUsers?[index].participants?[1]
                                      .images !=
                                  null &&
                              widget.chatUsers![index].participants![1].images!
                                  .isNotEmpty) {
                            newChatProvider.gotoChatScreen(
                                context,
                                widget.chatUsers[index].participants?[1]
                                        .email ??
                                    '',
                                widget.chatUsers[index].participants?[1]
                                        .email ??
                                    '',
                                widget.chatUsers?[index].participants?[1]
                                    .images?[0]);
                          } else {
                            newChatProvider.gotoChatScreen(
                                context,
                                widget.chatUsers[index].participants?[1]
                                        .email ??
                                    '',
                                widget.chatUsers[index].participants?[1]
                                        .email ??
                                    '',
                                '');
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              ClipOval(
                                child: widget.chatUsers?[index].participants?[1]
                                                .images !=
                                            null &&
                                        widget.chatUsers![index]
                                            .participants![1].images!.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: widget.chatUsers?[index]
                                                .participants?[1].images?[0] ??
                                            '',
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                              'assets/images/image_placeholder.png',
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.fill,
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                              'assets/images/image_placeholder.png',
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.fill,
                                            ))
                                    : CachedNetworkImage(
                                        imageUrl: '',
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                              'assets/images/image_placeholder.png',
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.fill,
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                              'assets/images/image_placeholder.png',
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.fill,
                                            )),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.chatUsers[index].participants?[1]
                                            .name ??
                                        '',
                                    style: mulishbold.copyWith(
                                      fontSize: 15,
                                      color: ColorRes.darkGrey,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: ColorRes.appColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Image.asset(
                                    AssertRe.chat,
                                    color: ColorRes.white,
                                    height: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filterList.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          NewChatProvider newChatProvider =
                              Provider.of<NewChatProvider>(context,
                                  listen: false);
                          if (filterList[index].participants?[1].images !=
                                  null &&
                              filterList![index]
                                  .participants![1]
                                  .images!
                                  .isNotEmpty) {
                            newChatProvider.gotoChatScreen(
                                context,
                                filterList[index].participants?[1].email ?? '',
                                filterList[index].participants?[1].email ?? '',
                                filterList?[index].participants?[1].images?[0]);
                          } else {
                            newChatProvider.gotoChatScreen(
                                context,
                                filterList[index].participants?[1].email ?? '',
                                filterList[index].participants?[1].email ?? '',
                                '');
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              ClipOval(
                                child: filterList?[index]
                                                .participants?[1]
                                                .images !=
                                            null &&
                                        filterList![index]
                                            .participants![1]
                                            .images!
                                            .isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: filterList?[index]
                                                .participants?[1]
                                                .images?[0] ??
                                            '',
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                              'assets/images/image_placeholder.png',
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.fill,
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                              'assets/images/image_placeholder.png',
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.fill,
                                            ))
                                    : CachedNetworkImage(
                                        imageUrl: '',
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                              'assets/images/image_placeholder.png',
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.fill,
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                              'assets/images/image_placeholder.png',
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.fill,
                                            )),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filterList[index].participants?[1].name ??
                                        '',
                                    style: mulishbold.copyWith(
                                      fontSize: 15,
                                      color: ColorRes.darkGrey,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: ColorRes.appColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Image.asset(
                                    AssertRe.chat,
                                    color: ColorRes.white,
                                    height: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
