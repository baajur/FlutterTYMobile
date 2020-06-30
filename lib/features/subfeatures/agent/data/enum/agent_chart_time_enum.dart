import 'package:generic_enum/generic_enum.dart';

class AgentChartTime extends GenericEnum<int> {
  const AgentChartTime._(int value) : super(value);

  static const AgentChartTime THIS_MONTH = AgentChartTime._(1);

  static const AgentChartTime LAST_MONTH = AgentChartTime._(0);

  static const List<AgentChartTime> LIST = [
    AgentChartTime.LAST_MONTH,
    AgentChartTime.THIS_MONTH,
  ];
}
