import 'package:generic_enum/generic_enum.dart';

class AgentChartType extends GenericEnum<String> {
  const AgentChartType._(String value) : super(value);

  static const AgentChartType PLATFORM = AgentChartType._('platform');

  static const AgentChartType CATEGORY = AgentChartType._('category');

  static const List<AgentChartType> LIST = [
    AgentChartType.PLATFORM,
    AgentChartType.CATEGORY,
  ];
}
