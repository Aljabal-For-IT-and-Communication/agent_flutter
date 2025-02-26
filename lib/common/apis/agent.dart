import 'package:app/common/entities/entities.dart';
import 'package:app/common/utils/utils.dart';

class AgentAPI {

  static Future<AgentResponseEntity> agentList() async {
    var response = await HttpUtil().post(
      'agent/agent_child_list',
    );
    return AgentResponseEntity.fromJson(response);
  }


}
