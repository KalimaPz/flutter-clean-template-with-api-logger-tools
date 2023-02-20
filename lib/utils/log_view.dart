import 'package:arainii_app_template/api_services.dart';
import 'package:arainii_app_template/models/common_response.dart';
import 'package:arainii_app_template/utils/tools.dart';
import 'package:flutter/material.dart';

BoxDecoration getBoxDecoration(int? statusCode) {
  if (statusCode == 200) {
    return BoxDecoration(
      color: Colors.green[100],
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: Colors.green[600]!),
    );
  } else {
    return BoxDecoration(
      color: Colors.red[100],
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: Colors.red[600]!),
    );
  }
}

class Log extends StatelessWidget {
  final CommonResponse commonResponse;
  const Log(
    this.commonResponse, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.width / 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: getBoxDecoration(commonResponse.statusCode),
                child: Text("${commonResponse.statusCode}",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: commonResponse.statusCode == 200
                            ? Colors.green[800]
                            : Colors.red[800])),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${commonResponse.method}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Expanded(child: Text(" : ${commonResponse.path}")),
                ],
              )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(commonResponse.responseTime),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.copy,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogDetail(
                          commonResponse: commonResponse,
                        ),
                      ));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue[900],
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.search),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LogDetail extends StatelessWidget {
  final CommonResponse commonResponse;
  const LogDetail({super.key, required this.commonResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue[900],
        toolbarHeight: 90,
        title: const Text("Log Detail : API Services"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: getBoxDecoration(commonResponse.statusCode),
                    child: Text("${commonResponse.statusCode}",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: commonResponse.statusCode == 200
                                ? Colors.green[800]
                                : Colors.red[800])),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('${commonResponse.method}'),
                  Expanded(child: Text(' : ${commonResponse.path}'))
                ],
              ),
            ),
            if (commonResponse.body != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Request Body : ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(Tools.prettierJson(commonResponse.body ?? {},
                        enableLog: false))
                  ],
                ),
              ),
            if (commonResponse.response != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Response : ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(Tools.prettierJson(commonResponse.response ?? {},
                        enableLog: false))
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class LogView extends StatefulWidget {
  const LogView({super.key});

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  List<CommonResponse> logs = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      logs = logGroup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue[900],
        toolbarHeight: 90,
        title: const Text("Log : API Services"),
      ),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Log(logs[index]),
          );
        },
      ),
    );
  }
}
