﻿<?xml version="1.0" encoding="UTF-8"?>

<template>
  <name>Cluster1CAccessConfig</name>
  <settings>
    <parameters>
      <param name="env.agent_port" value="1540" />
      <param name="env.cluster_admin" value="" />
      <param name="env.cluster_admin_password" value="" />
      <param name="env.com_connector" value="V83.ComConnector" />
      <param name="env.db_name" value="" spec="text validationMode='not_empty' display='normal'" />
      <param name="env.db_password" value="" />
      <param name="env.db_user" value="" spec="text validationMode='not_empty' display='normal'" />
      <param name="env.lock_message" value="&quot;Выполняются регламентные работы. Пожалуйста, подождите...&quot;" />
      <param name="env.server_host" value="" spec="text validationMode='not_empty' display='normal'" />
      <param name="oscript_path" value="oscript.exe" spec="text validationMode='not_empty' label='Путь к интерпретатору OneScript' display='hidden'" />
      <param name="storage_connection" value="" spec="text description='Путь к каталогу или адрес сервера в формате tcp://сервер|[:порт|]' validationMode='not_empty' label='Строка подключения к хранилищу' display='normal'" />
      <param name="storage_password" value="" />
      <param name="storage_user" value="" spec="text validationMode='not_empty' display='normal'" />
      <param name="v8_executable" value="" />
    </parameters>
    <build-runners>
      <runner id="RUNNER_4" name="Блокировка и отключение пользователей" type="simpleRunner">
        <parameters>
          <param name="script.content"><![CDATA[@echo off
chcp 1251
"%oscript_path%" "%system.teamcity.build.checkoutDir%"\Scripts\disconnect_users.os]]></param>
          <param name="teamcity.step.mode" value="default" />
          <param name="use.custom.script" value="true" />
        </parameters>
      </runner>
      <runner id="RUNNER_5" name="Получение версии из хранилища" type="simpleRunner">
        <parameters>
          <param name="script.content"><![CDATA[@echo off
chcp 1251
"%oscript_path%" "%system.teamcity.build.checkoutDir%"\Scripts\retrieve_storage.os "%v8_executable%" "%storage_connection%" "%storage_user%" "%storage_password%"]]></param>
          <param name="teamcity.step.mode" value="default" />
          <param name="use.custom.script" value="true" />
        </parameters>
      </runner>
      <runner id="RUNNER_7" name="Обновление конфигурации ИБ" type="simpleRunner">
        <parameters>
          <param name="script.content"><![CDATA[@echo off
chcp 1251
"%oscript_path%" "%system.teamcity.build.checkoutDir%"\Scripts\update_dbconf.os "%v8_executable%"]]></param>
          <param name="teamcity.step.mode" value="default" />
          <param name="use.custom.script" value="true" />
        </parameters>
      </runner>
      <runner id="RUNNER_8" name="Обновить базу в режиме предприятие" type="simpleRunner">
        <parameters>
          <param name="script.content"><![CDATA[@echo off
chcp 1251
"%oscript_path%" "%system.teamcity.build.checkoutDir%"\Scripts\update_enterprise.os "%v8_executable%"]]></param>
          <param name="teamcity.step.mode" value="default" />
          <param name="use.custom.script" value="true" />
        </parameters>
      </runner>
      <runner id="RUNNER_6" name="Снятие запрета на подключение" type="simpleRunner">
        <parameters>
          <param name="script.content"><![CDATA[@echo off
chcp 1251
"%oscript_path%" "%system.teamcity.build.checkoutDir%"\Scripts\remove_lock.os]]></param>
          <param name="teamcity.step.mode" value="execute_always" />
          <param name="use.custom.script" value="true" />
        </parameters>
      </runner>
    </build-runners>
    <vcs-settings />
    <requirements />
    <build-triggers />
    <cleanup />
  </settings>
</template>

