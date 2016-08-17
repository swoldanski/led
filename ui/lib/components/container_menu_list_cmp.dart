/**
 * Copyright (c) 2016 ui. All rights reserved
 *
 * REDISTRIBUTION AND USE IN SOURCE AND BINARY FORMS,
 * WITH OR WITHOUT MODIFICATION, ARE NOT PERMITTED.
 *
 * DO NOT ALTER OR REMOVE THIS HEADER.
 *
 * Created on : 05/08/16
 * Author     : bwnyasse
 *
 */
part of fluentd_log_explorer;

@Component(
    selector: 'container-menu-list-cmp',
    templateUrl:
        'packages/fluentd_log_explorer/components/container_menu_list_cmp.html',
    useShadowDom: false)
class ContainerMenuListCmp {
  ElasticSearchService service;

  ContainerMenuListCmp(this.service);

  getLevelCss(String level) {
    String css = '';
    if (level != null) {
      level = level.toUpperCase();
      if (level.contains('INFO')) {
        return 'level-info-menu';
      } else if (level.contains('WARN')) {
        return 'level-warning-menu';
      } else if (level.contains('ERR')) {
        return 'level-error-menu';
      } else if (level.contains('DEBUG')) {
        return 'level-debug-menu';
      } else if (level.contains('TRACE')) {
        return 'level-trace-menu';
      } else if (level.contains('FATAL')) {
        return 'level-fatal-menu';
      }
      return css;
    }
  }

  getIndexAsLogHistory(String index) => index.replaceAll('fluentd-', '');

  getLogs(String container) => service.getLogsByContainerName(container);

  getLogsByLevel(Level level) =>
      service.getLogsByContainerName(service.currentContainerName,
          level: level, histo: service.currentHisto);

  getLogsByHisto(String histo) =>
      service.getLogsByContainerName(service.currentContainerName,
          level: service.currentLogLevel, histo: histo);

  getDuration(String histo) {
    DateTime dateTime = DateTime.parse(histo);
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(
        dateTime.millisecondsSinceEpoch);
    var strictDate = new DateFormat('HH:mm:ss');
    return "From : <b>" + strictDate.format(date).toString() + "</b>";
  }

  changeIndex() => new Future(() {
        service.getContainersForCurrentIndex();
      });
}
