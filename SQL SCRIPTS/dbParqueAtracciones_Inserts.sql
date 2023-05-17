﻿USE dbParqueAtracciones
GO

INSERT INTO gral.tbEstadosCiviles (civi_Descripcion)
VALUES	('Soltero(a)'),
		('Casado(a)'),
		('Divorciado(a)'),
		('Viudo(a)'),
		('Union Libre')
GO

INSERT INTO gral.tbDepartamentos(dept_Codigo, dept_Nombre)
VALUES	('01','Atlántida'),
		('02','Colón'),
		('03','Comayagua'),
		('04','Copán'),
		('05','Cortés'),
		('06','Choluteca'),
		('07','El Paraíso'),
		('08','Francisco Morazán'),
		('09','Gracias a Dios'),
		('10','Intibucá'),
		('11','Islas de la Bahía'),
		('12','La Paz'),
		('13','Lempira'),
		('14','Ocotepeque'),
		('15','Olancho'),
		('16','Santa Bárbara'),
		('17','Valle'),
		('18','Yoro');
GO

INSERT INTO gral.tbMunicipios(dept_ID, muni_Codigo, muni_Nombre, muni_Estado, muni_UsuarioCreador, muni_FechaCreacion, muni_UsuarioModificador, muni_FechaModificacion)
VALUES	('1','0101','La Ceiba', '1', NULL, GETDATE(), NULL, GETDATE()),
		('1','0102','El Porvenir', '1', NULL, GETDATE(), NULL, GETDATE()),
		('1','0103','Tela', '1', NULL, GETDATE(), NULL, GETDATE()),
		('1','0104','Jutiapa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('1','0105','La Masica', '1', NULL, GETDATE(), NULL, GETDATE()),
		('1','0106','San Francisco', '1', NULL, GETDATE(), NULL, GETDATE()),
		('1','0107','Arizona', '1', NULL, GETDATE(), NULL, GETDATE()),
		('1','0108','Esparta', '1', NULL, GETDATE(), NULL, GETDATE()),
	

		('2','0201','Trujillo', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0202','Balfate', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0203','Iriona', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0204','Limón', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0205','Sabá', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0206','Santa Fe', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0207','Santa Rosa de Aguán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0208','Sonaguera', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0209','Tocoa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('2','0210','Bonito Oriental', '1', NULL, GETDATE(), NULL, GETDATE()),


		('3',		'0301',		'Comayagua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0302',		'Ajuterique', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0303',		'El Rosario', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0304',		'Esquías', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0305',		'Humuya', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0306',		'La Libertad', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0307',		'Lamaní', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0308',		'La Trinidad', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0309',		'Lejamaní', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0310',		'Meámbar', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0311',		'Minas de Oro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0312',		'Ojos de Agua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0313',		'San Jerónimo', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0314',		'San José de Comayagua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0315',		'San José del Potrero', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0316',		'San Luis', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0317',		'San Sebastián', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0318',		'Siguatepeque', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0319',		'Villa de San Antonio', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0320',		'Las Lajas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('3',		'0321',		'Taulabé', '1', NULL, GETDATE(), NULL, GETDATE()),


		('4',	'0401','Santa Rosa de Copán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0402','Cabañas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0403','Concepción', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0404','Copán Ruinas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0405','Corquín', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0406','Cucuyagua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0407','Dolores', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0408','Dulce Nombre', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0409','El Paraíso', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0410','Florida', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0411','La Jigua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0412','La Unión', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0413','Nueva Arcadia', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0414','San Agustín', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0415','San Antonio', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0416','San Jerónimo', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0417','San José', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0418','San Juan de Opoa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0419','San Nicolás', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0420','San Pedro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0421','Santa Rita', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0422','Trinidad de Copán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('4',	'0423','Veracruz', '1', NULL, GETDATE(), NULL, GETDATE()),


		('5',	'0501','San Pedro Sula', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0502','Choloma', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0503','Omoa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0504','Pimienta', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0505','Potrerillos', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0506','Puerto Cortés', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0507','San Antonio de Cortés', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0508','San Francisco de Yojoa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0509','San Manuel', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0510','Santa Cruz de Yojoa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0511','Villanueva', '1', NULL, GETDATE(), NULL, GETDATE()),
		('5',	'0512','La Lima', '1', NULL, GETDATE(), NULL, GETDATE()),


		('6',	'0601','Choluteca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0602','Apacilagua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0603','Concepción de María', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0604','Duyure', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0605','El Corpus', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0606','El Triunfo', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0607','Marcovia', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0608','Morolica', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0609','Namasigüe', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0610','Orocuina', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0611','Pespire', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0612','San Antonio de Flores', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0613','San Isidro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0614','San José', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0615','San Marcos de Colón', '1', NULL, GETDATE(), NULL, GETDATE()),
		('6',	'0616','Santa Ana de Yusguare', '1', NULL, GETDATE(), NULL, GETDATE()),


		('7', '0701', 'Yuscarán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0702', 'Alauca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0703', 'Danlí', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0704', 'El Paraíso', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0705', 'Güinope', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0706', 'Jacaleapa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0707', 'Liure', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0708', 'Morocelí', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0709', 'Oropolí', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0710', 'Potrerillos', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0711', 'San Antonio de Flores', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0712', 'San Lucas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0713', 'San Matías', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0714', 'Soledad', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0715', 'Teupasenti', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0716', 'Texiguat', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0717', 'Vado Ancho', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0718', 'Yauyupe', '1', NULL, GETDATE(), NULL, GETDATE()),
		('7', '0719', 'Trojes', '1', NULL, GETDATE(), NULL, GETDATE()),


		('8', '0801', 'Distrito Central', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0802', 'Alubarén', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0803', 'Cedros', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0804', 'Curarén', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0805', 'El Porvenir', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0806', 'Guaimaca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0807', 'La Libertad', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0808', 'La Venta', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0809', 'Lepaterique', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0810', 'Maraita', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0811', 'Marale', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0812', 'Nueva Armenia', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0813', 'Ojojona', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0814', 'Orica', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0815', 'Reitoca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0816', 'Sabanagrande', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0817', 'San Antonio de Oriente', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0818', 'San Buenaventura', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0819', 'San Ignacio', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0820', 'San Juan de Flores', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0821', 'San Miguelito', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0822', 'Santa Ana', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0823', 'Santa Lucía', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0824', 'Talanga', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0825', 'Tatumbla', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0826', 'Valle de Ángeles', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0827', 'Villa de San Francisco', '1', NULL, GETDATE(), NULL, GETDATE()),
		('8', '0828', 'Vallecillo', '1', NULL, GETDATE(), NULL, GETDATE()),


		('9', '0901', 'Puerto Lempira', '1', NULL, GETDATE(), NULL, GETDATE()),
		('9', '0902', 'Brus Laguna', '1', NULL, GETDATE(), NULL, GETDATE()),
		('9', '0903', 'Ahuas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('9', '0904', 'Juan Francisco Bulnes', '1', NULL, GETDATE(), NULL, GETDATE()),
		('9', '0905', 'Ramón Villeda Morales', '1', NULL, GETDATE(), NULL, GETDATE()),
		('9', '0906', 'Wampusirpe', '1', NULL, GETDATE(), NULL, GETDATE()),


		('10', '1001', 'La Esperanza', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1002', 'Camasca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1003', 'Colomoncagua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1004', 'Concepción', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1005', 'Dolores', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1006', 'Intibucá', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1007', 'Jesús de Otoro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1008', 'Magdalena', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1009', 'Masaguara', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1010', 'San Antonio', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1011', 'San Isidro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1012', 'San Juan', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1013', 'San Marcos de la Sierra', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1014', 'San Miguel Guancapla', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1015', 'Santa Lucía', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1016', 'Yamaranguila', '1', NULL, GETDATE(), NULL, GETDATE()),
		('10', '1017', 'San Francisco de Opalaca', '1', NULL, GETDATE(), NULL, GETDATE()),


		('11', '1101', 'Roatán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('11', '1102', 'Guanaja', '1', NULL, GETDATE(), NULL, GETDATE()),
		('11', '1103', 'José Santos Guardiola', '1', NULL, GETDATE(), NULL, GETDATE()),
		('11', '1104', 'Utila', '1', NULL, GETDATE(), NULL, GETDATE()),


		('12', '1201', 'La Paz', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1202', 'Aguanqueterique', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1203', 'Cabañas.', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1204', 'Cane', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1205', 'Chinacla', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1206', 'Guajiquiro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1207', 'Lauterique', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1208', 'Marcala', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1209', 'Mercedes de Oriente', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1210', 'Opatoro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1211', 'San Antonio del Norte', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1212', 'San José', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1213', 'San Juan', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1214', 'San Pedro de Tutule', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1215', 'Santa Ana', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1216', 'Santa Elena', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1217', 'Santa María', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1218', 'Santiago de Puringla', '1', NULL, GETDATE(), NULL, GETDATE()),
		('12', '1219', 'Yarula', '1', NULL, GETDATE(), NULL, GETDATE()),


		('13', '1301', 'Gracias', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1302', 'Belén', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1303', 'Candelaria', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1304', 'Cololaca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1305', 'Erandique', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1306', 'Gualcince', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1307', 'Guarita', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1308', 'La Campa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1309', 'La Iguala', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1310', 'Las Flores', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1311', 'La Unión', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1312', 'La Virtud', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1313', 'Lepaera', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1314', 'Mapulaca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1315', 'Piraera', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1316', 'San Andrés', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1317', 'San Francisco', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1318', 'San Juan Guarita', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1319', 'San Manuel Colohete', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1320', 'San Rafael', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1321', 'San Sebastián', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1322', 'Santa Cruz', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1323', 'Talgua', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1324', 'Tambla', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1325', 'Tomalá', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1326', 'Valladolid', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1327', 'Virginia', '1', NULL, GETDATE(), NULL, GETDATE()),
		('13', '1328', 'San Marcos de Caiquín', '1', NULL, GETDATE(), NULL, GETDATE()),


		('14', '1401', 'Ocotepeque', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1402', 'Belén Gualcho', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1403', 'Concepción', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1404', 'Dolores Merendón', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1405', 'Fraternidad', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1406', 'La Encarnación', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1407', 'La Labor', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1408', 'Lucerna', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1409', 'Mercedes', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1410', 'San Fernando', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1411', 'San Francisco del Valle', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1412', 'San Jorge', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1413', 'San Marcos', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1414', 'Santa Fe', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1415', 'Sensenti', '1', NULL, GETDATE(), NULL, GETDATE()),
		('14', '1416', 'Sinuapa', '1', NULL, GETDATE(), NULL, GETDATE()),


		('15', '1501', 'Juticalpa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1502', 'Campamento', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1503', 'Catacamas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1504', 'Concordia', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1505', 'Dulce Nombre de Culmí', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1506', 'El Rosario', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1507', 'Esquipulas del Norte', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1508', 'Gualaco', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1509', 'Guarizama', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1510', 'Guata', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1511', 'Guayape', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1512', 'Jano', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1513', 'La Unión', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1514', 'Mangulile', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1515', 'Manto', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1516', 'Salamá', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1517', 'San Esteban', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1518', 'San Francisco de Becerra', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1519', 'San Francisco de la Paz', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1520', 'Santa María del Real', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1521', 'Silca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1522', 'Yocón', '1', NULL, GETDATE(), NULL, GETDATE()),
		('15', '1523', 'Patuca', '1', NULL, GETDATE(), NULL, GETDATE()),


		('16', '1601' , 'Santa Bárbara', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1602' , 'Arada', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1603' , 'Atima', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1604' , 'Azacualpa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1605' , 'Ceguaca', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1606' , 'Concepción del Norte', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1607' , 'Concepción del Sur', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1608' , 'Chinda', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1609' , 'El Níspero', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1610' , 'Gualala', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1611' , 'Ilama', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1612' , 'Las Vegas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1613' , 'Macuelizo', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1614' , 'Naranjito', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1615' , 'Nuevo Celilac', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1616' , 'Nueva Frontera', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1617' , 'Petoa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1618' , 'Protección', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1619' , 'Quimistán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1620' , 'San Francisco de Ojuera', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1621' , 'San José de las Colinas', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1622' , 'San Luis', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1623' , 'San Marcos', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1624' , 'San Nicolás', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1625' , 'San Pedro Zacapa', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1626' , 'San Vicente Centenario', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1627' , 'Santa Rita', '1', NULL, GETDATE(), NULL, GETDATE()),
		('16', '1628' , 'Trinidad', '1', NULL, GETDATE(), NULL, GETDATE()),


		('17', '1701', 'Nacaome', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1702', 'Alianza', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1703', 'Amapala', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1704', 'Aramecina', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1705', 'Caridad', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1706', 'Goascorán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1707', 'Langue', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1708', 'San Francisco de Coray', '1', NULL, GETDATE(), NULL, GETDATE()),
		('17', '1709', 'San Lorenzo', '1', NULL, GETDATE(), NULL, GETDATE()),


		('18', '1801', 'Yoro', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1802', 'Arenal', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1803', 'El Negrito', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1804', 'El Progreso', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1805', 'Jocón', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1806', 'Morazán', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1807', 'Olanchito', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1808', 'Santa Rita', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1809', 'Sulaco', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1810', 'Victoria', '1', NULL, GETDATE(), NULL, GETDATE()),
		('18', '1811', 'Yorito', '1', NULL, GETDATE(), NULL, GETDATE());
GO

INSERT INTO gral.tbMetodosPago(pago_Nombre, pago_UsuarioCreador)
VALUES	('Efectivo', 1),
		('Tarjeta', 1),
		('Transferencia', 1)
GO

UPDATE gral.tbDepartamentos
SET dept_UsuarioCreador = 1

UPDATE gral.tbMunicipios
SET muni_UsuarioCreador = 1













       
--ALTER TABLE gral.tbEstadosCiviles
--ADD CONSTRAINT FK_gral_tbEstadosCiviles_civi_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (civi_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_gral_tbEstadosCiviles_civi_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (civi_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)	
--GO


--ALTER TABLE gral.tbDepartamentos
--ADD CONSTRAINT FK_gral_tbDepartamentos_dept_UsuarioCreador_acce_tbUsuarios_usua_ID	FOREIGN KEY (dept_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_gral_tbDepartamentos_dept_UsuarioModificador_acce_tbUsuarios_usua_ID	FOREIGN KEY (dept_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO	


--ALTER TABLE gral.tbMunicipios
--ADD CONSTRAINT FK_gral_tbMunicipios_muni_UsuarioCreador_acce_tbUsuarios_usua_ID	FOREIGN KEY (muni_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_gral_tbMunicipios_muni_UsuarioModificador_acce_tbUsuarios_usua_ID	FOREIGN KEY (muni_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO


--ALTER TABLE gral.tbMetodosPago
--ADD CONSTRAINT FK_gral_tbMetodosPago_pago_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (pago_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_gral_tbMetodosPago_pago_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (pago_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO


--ALTER TABLE acce.tbRoles
--ADD CONSTRAINT FK_acce_tbRoles_role_UsuarioCreador_tbUsuarios_usua_ID FOREIGN KEY (role_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_acce_tbRoles_role_UsuarioModificador_tbUsuarios_usua_ID FOREIGN KEY (role_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE acce.tbPantallas
--ADD CONSTRAINT FK_acce_tbPantallas_pant_UsuarioCreador_tbUsuarios_usua_ID FOREIGN KEY (pant_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_acce_tbPantallas_pant_UsuarioModificador_tbUsuarios_usua_ID FOREIGN KEY (pant_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO


--ALTER TABLE acce.tbRolesXPantallas
--ADD	CONSTRAINT FK_acce_tbRolesXPantallas_ropa_UsuarioCreador_tbUsuarios_usua_ID FOREIGN KEY (ropa_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_acce_tbRolesXPantallas_ropa_UsuarioModificador_tbUsuarios_usua_ID FOREIGN KEY (ropa_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO



--ALTER TABLE acce.tbUsuarios
--ADD CONSTRAINT FK_acce_tbUsuarios_cons_tbEmpleados_empl_ID FOREIGN KEY (empl_ID) REFERENCES cons.tbEmpleados (empl_ID),
--	CONSTRAINT FK_acce_tbUsuarios_usua_UsuarioCreador_tbUsuarios_usua_ID FOREIGN KEY (usua_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_acce_tbUsuarios_usua_UsuarioModificador_tbUsuarios_usua_ID FOREIGN KEY (usua_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO