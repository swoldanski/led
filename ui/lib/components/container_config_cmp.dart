/**
 * Copyright (c) 2016 ui. All rights reserved
 * 
 * REDISTRIBUTION AND USE IN SOURCE AND BINARY FORMS,
 * WITH OR WITHOUT MODIFICATION, ARE NOT PERMITTED.
 * 
 * DO NOT ALTER OR REMOVE THIS HEADER.
 * 
 * Created on : 16/09/16
 * Author     : bwnyasse
 *  
 */
part of led_ui;

@Component(
    selector: 'container-config-cmp',
    templateUrl: 'components/container_config_cmp.html')
class ContainerConfigCmp implements AfterViewInit {

  ElasticSearchService service;
  LConfiguration configuration;
  LCurator curator;
  List levelConfigurations = [];
  List getLogTagFormat;
  ContainerConfigCmp(this.service,this.configuration,this.curator);


  register() =>  configuration.saveLevelConfig(levelConfigurations);
  restore() =>  configuration.reloadDefaultLevelConfig();
  performCurator() => curator.callCurator();

  @override
  ngAfterViewInit() {
    levelConfigurations= configuration.getLevelsConfiguration();
    getLogTagFormat= configuration.getLogTagFormat();
    jsinterop.initJSC();
  }
}