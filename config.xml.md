<?xml version="1.0" encoding="UTF-8"?>

<template title="Cluster1CAccessConfig">
  <settings>
	<cluster-list type="array">
		<cluster name="cluster.name.1" value="app-1">
			<srv name="server-name.1" value="xxxxxxxxxxx"/>
			<srv name="server-port.1" value="xx40"/>
		</cluster>
		<cluster name="cluster.name.2" value="app-2">
			<srv name="server-name.2" value="xxxxxxxxxxx"/>
			<srv name="server-port.2" value="xx40"/>
		</cluster>
	</cluster-list>
	<ib-list type="array">
		<base name="ibName.1" value="xxxx">
			<ib name="description.1" value="xxxxxxxxxx" />
			<ib name="type.1" value="server" />
			<ib name="ib.1" value="xxxxnu" />
			<ib name="user.1" value="xxxxxxxxxx" />
			<ib name="password.1" value="xxxxxxx"/>
		</base>
		<base name="ibName.2" value="xxxp">
			<ib name="description.2" value="xxxxxy" />
			<ib name="type.2" value="server" />
			<ib name="ib.2" value="xxxxxxp" />
			<ib name="user.2" value="xxxxxxx" />
			<ib name="password.2" value="xxxxxxx"/>
		</base>
		<base name="ibName.3" value="xxx">
			<ib name="description.3" value="xxxxxxxxxxxxxn" />
			<ib name="type.3" value="server" />
			<ib name="ib.3" value="xxxxxp" />
			<ib name="user.3" value="xxxxxxxxx" />
			<ib name="password.3" value="xxxxxxx"/>
		</base>
		<base name="ibName.5" value="xxxxxst">
			<ib name="description.5" value="xxxxxxxxxxxxxx tst" />
			<ib name="type.5" value="server" />
			<ib name="ib.5" value="xxxxxxxtst" />
			<ib name="user.5" value="xxxx" />
			<ib name="password.5" value="xxxxxxx"/>
		</base>
		<base name="ibName.4" value="Storagxxxxx">
			<ib name="description.4" value="xxxxxxxorage" />
			<ib name="type.4" value="file" />
			<ib name="ib.4" value="C:\bxxxxxxxxxxxxxxxxx" />
			<ib name="user.4" value="xxxxxxx" />
			<ib name="password.4" value="xxxxxxx"/>
		</base>
	</ib-list>
    <parameters type="none">
      <param name="agent.port" value="xx40" />
      <param name="cluster.admin" value="xxxxxxx" />
      <param name="cluster.admin.password" value="xxxxxx" />
      <param name="com.connector" value="V83.ComConnector" />
      <param name="db.name" value="xxxxxxxxxt" spec="text validationMode='notEmpty' display='normal'" />
      <param name="db.password" value="xxxxxxx" />
      <param name="db.user" value="xxxxx" spec="text validationMode='notEmpty' display='normal'" />
      <param name="lock.message" value="&quot;Выполняются регламентные работы. Пожалуйста, подождите...&quot;" />
      <param name="server.host" value="xxxxxxxxxxx" spec="text validationMode='notEmpty' display='normal'" />
      <param name="oscript.path" value="oscript.exe" spec="text validationMode='notEmpty' label='Путь к интерпретатору OneScript' display='hidden'" />
      <param name="storage.connection" value="xxxxxxxxxxxxxxxxxxxxxxxxxxxx" spec="text description='Путь к каталогу или адрес сервера в формате tcp://сервер|[:порт|]' validationMode='notEmpty' label='Строка подключения к хранилищу' display='normal'" />
      <param name="storage.password" value="xxxx" />
      <param name="storage.user" value="xxxxxxxxxx" spec="text validationMode='notEmpty' display='normal'" />
      <param name="v8.executable" value="C:\Program Files (x86)\1cv8\8.3.5.1460\bin\1cv8.exe" />
    </parameters>
    </settings>
</template>
