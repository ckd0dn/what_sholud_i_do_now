import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../activity/activity_view_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ActivityViewModel>();
    final state = viewModel.state;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "활동 완료시 달력에 추가됩니다.",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: viewModel.favoriteActivity.length,
                  itemBuilder: (context, idx){
                    return Container(
                      margin: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(viewModel.favoriteActivity[idx]),
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TextButton(
                                  onPressed: () {
                                    viewModel.delFavoriteList(idx);
                                  },
                                  child: const Text(
                                    "삭제",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),),
                              TextButton(
                                onPressed: () {
                                  viewModel.addCompleteActivity(idx);
                                },
                                child: const Text(
                                  '완료',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
