USE dbParqueAtracciones
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


INSERT INTO parq.tbCargos(carg_Nombre, [carg_UsuarioCreador])
VALUES	('Ventanilla', 1),
		('Vendedor', 1),
		('Supervisor Atracciones', 1),
		('Aseador', 1)
GO

INSERT INTO parq.tbRegiones(regi_Nombre)
VALUES	('Norte'),
		('Sur'),
		('Este'),
		('Oeste'),
		('Nordeste'),
		('Sudeste'),
		('Noroeste'),
		('Sudoeste')
GO		

UPDATE parq.tbRegiones
SET regi_UsuarioCreador = 1


INSERT INTO parq.tbClientes(clie_Nombres, clie_Apellidos, clie_DNI, clie_Sexo, clie_Telefono)
VALUES	('Consumidor', 'Final'	, '0000-0000-00000', NULL, '0000-0000'),
		('Juan', 'Camaney'		,   '0502-0045-57848', 'M', '8855-4477'),
		('Maria', 'Antonieta'	,'0224-5578-44157', 'F', '9985-2240'),
		('David', 'Castillo'	, '0544-2235-42517', 'M', '7754-1142'),
		('Alejandra', 'Peña'	, '0104-5575-11245', 'F', '8852-2241')
GO



INSERT INTO parq.tbClientesRegistrados(clie_Nombres,clie_Apellidos, clre_Usuario, clre_Clave, clre_Email, clre_UsuarioCreador)
VALUES	( 'David', 'Castillo',	'Juanca123', 'juanca123@', 'camaney.juan@gmail.com', 1),
		( 'Alejandra', 'Peña',	'ItsAle504', 'itsale504', 'peña.alejandra@gmail.com', 1)
GO


INSERT INTO parq.tbAreas (area_Nombre, area_Descripcion, regi_ID, area_UbicaionReferencia, area_UsuarioCreador, area_Imagen)
VALUES	('Zona Acuática', 'Zona con ambiente acuatico, lleno de entretenimiento, incluye piscinas!', 1, 'Ubicado en la zona norte del parque', 1, 'MAPA-2.png'),
		('Montañas Rusas', 'Zona con un ambiente lleno de diversión y adrenalina!', 3, 'Ubicado en la zona Este del parque', 1, 'MAPA-3.png'),
		('Zona Extrema', 'Zona con temáticas frenesí, desde paintball, hasta airsoft!', 2, 'Ubicado en la zona Sur del parque', 1, 'MAPA-1.png'),
		('Zona Infantíl', 'Zona con un ambiente más tranquilo y familiar con lo pequeños!', 4, 'Ubicado en la zona Oeste del parque', 1, 'MAPA-4.png')
GO


INSERT INTO parq.tbTickets(tckt_Nombre, tckt_Precio, tckt_UsuarioCreador)
VALUES	('Clásico', 150, 1),
		('VIP', 450, 1)
GO



INSERT INTO parq.tbTicketsCliente(tckt_ID, clie_ID, ticl_Cantidad, ticl_UsuarioCreador)
VALUES	(1, 2, 4, 1),
		(2, 5, 3, 1),
		(2, 3, 2, 1),
		(1, 4, 6, 1)
GO



INSERT INTO parq.tbAtracciones(area_ID, atra_Nombre, atra_Descripcion, regi_ID, atra_ReferenciaUbicacion, atra_LimitePersonas, atra_DuracionRonda, atra_UsuarioCreador)
VALUES	(1, 'Montaña Rusa', 'Solo para valientes', 1, 'A 10 metros de la entrada al area', 20, 5, 1),
		(2, 'La casa de los mil y un espejos', 'No te pierdas en el camino a la salida!', 2, 'Gira a la derecha despues de pasar el quiosco', 20, 20, 1),
		(3, 'El tren infinito', 'No te vallas a marear!', 3, 'Dirigete al este del area', 20, 5, 1),
		(4, 'AirSoft', 'Solo puede quedar uno en pie!', 4, 'De la entrada al area dirígete a la izquierda y verás la entrada a la atracción', 20, 20, 1)      


INSERT INTO parq.tbEmpleados(empl_PrimerNombre, empl_SegundoNombre, empl_PrimerApellido, empl_SegundoApellido, empl_DNI, empl_Email, empl_Telefono, empl_Sexo, civi_ID, carg_ID, empl_UsuarioCreador)
VALUES	('Juan', 'Pablo', 'González', 'López', '1234-6789-12345', 'juan.gonzalez@example.com', '1234-6789', 'M', 1, 1, 1),
		('María', 'Elena', 'Rodríguez', 'Gómez', '9876-4321-98765', 'maria.rodriguez@example.com', '9876-4321', 'F', 2, 1, 1),
		('Pedro', NULL, 'Sánchez', 'Martínez', '4567-9012-45678', 'pedro.sanchez@example.com', '4567-9012', 'M', 1, 2, 1),
		('Ana', 'María', 'López', 'García', '234567890123456', 'ana.lopez@example.com', '234567890', 'F', 2, 2, 1),
		('Carlos', 'Alberto', 'Ramírez', 'Vargas', '345678901234567', 'carlos.ramirez@example.com', '345678901', 'M', 3, 3, 1),
		('Laura', 'Isabel', 'Gómez', 'Hernández', '456789012345678', 'laura.gomez@example.com', '456789012', 'F', 4, 2, 1)
GO


INSERT INTO parq.tbQuioscos(area_ID, quio_Nombre, empl_ID, regi_ID, quio_ReferenciaUbicacion, quio_UsuarioCreador)
VALUES	(1, 'Quiosco La Delicia', 1, 1, 'A la par del letrero de baños', 1),
		(2, 'Quiosco Fresh & Tasty', 2, 1, 'Junto a la entrada principal', 1),
		(1, 'Quiosco La Esquina', 3, 2, 'Cerca de la fuente de agua', 1),
		(2, 'Quiosco Sweet & Salty', 4, 2, 'En la plaza de comidas', 1),
		(3, 'Quiosco Deli Corner', 5, 3, 'Al lado de la tienda de souvenirs', 1),
		(3, 'Quiosco Snack Paradise', 6, 3, 'Cerca de la atracción principal', 1)
GO


INSERT INTO parq.tbGolosinas(golo_Nombre, golo_Precio, golo_UsuarioCreador)
VALUES	('ChocoDelight', 10, 1),
		('Rainbow Drops', 15, 1),
		('Cotton Candy Crunch', 20, 1),
		('Sourlicious Gummies', 5, 1),
		('Popcorn Munchies', 25, 1),
		('Fruity Swirl Lollipop', 15, 1)
GO


INSERT INTO parq.tbInsumosQuiosco(quio_ID, golo_ID, insu_Stock, insu_UsuarioCreador)
VALUES	(1, 1, 200, 1),
		(1, 2, 200, 1),
		(1, 3, 200, 1),

		(2, 3, 200, 1),
		(2, 4, 200, 1),
		(2, 6, 200, 1),

		(3, 4, 200, 1),
		(3, 6, 200, 1),
		(3, 5, 200, 1),

		(4, 1, 200, 1),
		(4, 2, 200, 1),
		(4, 6, 200, 1),

		(5, 3, 200, 1),
		(5, 4, 200, 1),

		(6, 5, 200, 1),
		(6, 6, 200, 1)
GO


INSERT INTO parq.tbRatings(atra_ID, clie_ID, rati_Estrellas, rati_Comentario, rati_UsuarioCreador)
VALUES	(1, 2, 4, 'Excelente atracción. Me encantó la emoción que ofrece.', 1),
		(2, 3, 5, 'Increíble experiencia. No puedo esperar para volver.', 1),
		(3, 4, 3, 'La atracción estuvo bien, pero esperaba más emociones.', 1),
		(4, 5, 2, 'No quedé satisfecho con esta atracción. Falta emoción.', 1)
GO



INSERT INTO fact.tbVentasQuiosco(quio_ID, clie_ID, pago_ID, vent_UsuarioCreador)
VALUES	(1, 2, 1, 1),
		(2, 3, 2, 1),
		(3, 4, 1, 1),
		(4, 5, 2, 1)
GO


-- Inserts para la venta 1
INSERT INTO fact.tbVentasQuioscoDetalle(vent_ID, insu_ID, deta_Cantidad, deta_UsuarioCreador)
VALUES	(1, 1, 2, 1),
		(1, 2, 3, 1)
GO

-- Inserts para la venta 2
INSERT INTO fact.tbVentasQuioscoDetalle(vent_ID, insu_ID, deta_Cantidad, deta_UsuarioCreador)
VALUES	(2, 4, 2, 1),
		(2, 3, 1, 1)
GO

-- Inserts para la venta 3
INSERT INTO fact.tbVentasQuioscoDetalle(vent_ID, insu_ID, deta_Cantidad, deta_UsuarioCreador)
VALUES	(3, 5, 3, 1),
		(3, 6, 2, 1)
GO

-- Inserts para la venta 4
INSERT INTO fact.tbVentasQuioscoDetalle(vent_ID, insu_ID, deta_Cantidad, deta_UsuarioCreador)
VALUES	(4, 1, 2, 1),
		(4, 2, 3, 1)
GO




INSERT INTO fila.tbHistorialVisitantesAtraccion(atra_ID, viat_HoraEntrada ,ticl_ID, hiat_FechaFiltro,hiat_UsuarioCreador)
VALUES	(1, GETDATE(), 1, '2023-05-31'	, 1),
		(1, GETDATE(), 2, '2023-05-31'	, 1),
		(1, GETDATE(), 3, '2023-05-31'	, 1),
		(1, GETDATE(), 4, '2023-05-31'	, 1),
		(1, GETDATE(), 5, '2023-05-31'	, 1),
		(1, GETDATE(), 6, '2023-05-31'	, 1),
		(1, GETDATE(), 7, '2023-05-31'	, 1),
		(1, GETDATE(), 8, '2023-05-31'	, 1),
		(1, GETDATE(), 9, '2023-05-31'	, 1),
		(1, GETDATE(), 10, '2023-05-31'	, 1),

		(2, GETDATE(), 11, '2023-05-31'	, 1),
		(2, GETDATE(), 12, '2023-05-31'	, 1),
		(2, GETDATE(), 13, '2023-05-31'	, 1),
		(2, GETDATE(), 14, '2023-05-31'	, 1),
		(2, GETDATE(), 15, '2023-05-31'	, 1),
		(2, GETDATE(), 16, '2023-05-31'	, 1),
		(2, GETDATE(), 17, '2023-05-31'	, 1),
		(2, GETDATE(), 18, '2023-05-31'	, 1),
		(2, GETDATE(), 19, '2023-05-31'	, 1),
						 
		(3, GETDATE(), 20, '2023-05-31'	, 1),
		(3, GETDATE(), 21, '2023-05-31'	, 1),
		(3, GETDATE(), 22, '2023-05-31'	, 1),
		(3, GETDATE(), 23, '2023-05-31'	, 1),
		(3, GETDATE(), 24, '2023-05-31'	, 1),
		(3, GETDATE(), 25, '2023-05-31'	, 1),
		(3, GETDATE(), 26, '2023-05-31'	, 1),
		(3, GETDATE(), 27, '2023-05-31'	, 1),
		(3, GETDATE(), 28, '2023-05-31'	, 1),
		(3, GETDATE(), 29, '2023-05-31'	, 1),
						 
		(4, GETDATE(), 30, '2023-05-31'	, 1),
		(4, GETDATE(), 31, '2023-05-31'	, 1),
		(4, GETDATE(), 32, '2023-05-31'	, 1),
		(4, GETDATE(), 33, '2023-05-31'	, 1),
		(4, GETDATE(), 34, '2023-05-31'	, 1),
		(4, GETDATE(), 35, '2023-05-31'	, 1),
		(4, GETDATE(), 36, '2023-05-31'	, 1),
		(4, GETDATE(), 37, '2023-05-31'	, 1),
		(4, GETDATE(), 38, '2023-05-31'	, 1)
GO


INSERT INTO fila.tbHistorialVisitantesAtraccion(atra_ID, viat_HoraEntrada, ticl_ID, hiat_FechaFiltro ,hiat_UsuarioCreador)
VALUES	(1, GETDATE(), 1, '2023-05-30'	, 1),
		(1, GETDATE(), 2, '2023-05-30'	, 1),
		(1, GETDATE(), 3, '2023-05-30'	, 1),
		(1, GETDATE(), 4, '2023-05-30'	, 1),
		(1, GETDATE(), 5, '2023-05-30'	, 1),
		(1, GETDATE(), 6, '2023-05-30'	, 1),
		(1, GETDATE(), 7, '2023-05-30'	, 1),
		(1, GETDATE(), 8, '2023-05-30'	, 1),
		(1, GETDATE(), 9, '2023-05-30'	, 1),
		(1, GETDATE(), 10, '2023-05-30'	, 1),
		(1, GETDATE(), 39, '2023-05-30'	, 1),
		(1, GETDATE(), 40, '2023-05-30'	, 1),
		(1, GETDATE(), 41, '2023-05-30'	, 1),
		(1, GETDATE(), 42, '2023-05-30'	, 1),
		(1, GETDATE(), 43, '2023-05-30'	, 1),
											 
		(2, GETDATE(), 11, '2023-05-30'	, 1),
		(2, GETDATE(), 12, '2023-05-30'	, 1),
		(2, GETDATE(), 13, '2023-05-30'	, 1),
		(2, GETDATE(), 14, '2023-05-30'	, 1),
		(2, GETDATE(), 15, '2023-05-30'	, 1),
		(2, GETDATE(), 16, '2023-05-30'	, 1),
		(2, GETDATE(), 17, '2023-05-30'	, 1),
		(2, GETDATE(), 18, '2023-05-30'	, 1),
		(2, GETDATE(), 19, '2023-05-30'	, 1),
								 			 
		(3, GETDATE(), 20, '2023-05-30'	, 1),
		(3, GETDATE(), 21, '2023-05-30'	, 1),
		(3, GETDATE(), 22, '2023-05-30'	, 1),
		(3, GETDATE(), 23, '2023-05-30'	, 1),
		(3, GETDATE(), 24, '2023-05-30'	, 1),
		(3, GETDATE(), 25, '2023-05-30'	, 1),
		(3, GETDATE(), 26, '2023-05-30'	, 1),
		(3, GETDATE(), 27, '2023-05-30'	, 1),
		(3, GETDATE(), 28, '2023-05-30'	, 1),
		(3, GETDATE(), 29, '2023-05-30'	, 1),
						 			 
		(4, GETDATE(), 30, '2023-05-30'	, 1),
		(4, GETDATE(), 31, '2023-05-30'	, 1),
		(4, GETDATE(), 32, '2023-05-30'	, 1),
		(4, GETDATE(), 33, '2023-05-30'	, 1),
		(4, GETDATE(), 34, '2023-05-30'	, 1),
		(4, GETDATE(), 35, '2023-05-30'	, 1),
		(4, GETDATE(), 36, '2023-05-30'	, 1),
		(4, GETDATE(), 37, '2023-05-30'	, 1),
		(4, GETDATE(), 38, '2023-05-30'	, 1)
GO

INSERT INTO fila.tbHistorialVisitantesAtraccion(atra_ID, viat_HoraEntrada, ticl_ID, hiat_FechaFiltro, hiat_UsuarioCreador)
VALUES	(1, GETDATE(), 1, '2023-05-29'	, 1),
		(1, GETDATE(), 2, '2023-05-29'	, 1),
		(1, GETDATE(), 3, '2023-05-29'	, 1),
		(1, GETDATE(), 4, '2023-05-29'	, 1),
		(1, GETDATE(), 5, '2023-05-29'	, 1),
		(1, GETDATE(), 6, '2023-05-29'	, 1),
		(1, GETDATE(), 7, '2023-05-29'	, 1),

									
		(2, GETDATE(), 11, '2023-05-29'	, 1),
		(2, GETDATE(), 12, '2023-05-29'	, 1),
		(2, GETDATE(), 13, '2023-05-29'	, 1),
		(2, GETDATE(), 14, '2023-05-29'	, 1),
		(2, GETDATE(), 15, '2023-05-29'	, 1),
		(2, GETDATE(), 16, '2023-05-29'	, 1),
		(2, GETDATE(), 17, '2023-05-29'	, 1),
		(2, GETDATE(), 18, '2023-05-29'	, 1),
						 			
		(3, GETDATE(), 20, '2023-05-29'	, 1),
		(3, GETDATE(), 21, '2023-05-29'	, 1),
		(3, GETDATE(), 22, '2023-05-29'	, 1),
		(3, GETDATE(), 23, '2023-05-29'	, 1),
		(3, GETDATE(), 24, '2023-05-29'	, 1),
		(3, GETDATE(), 25, '2023-05-29'	, 1),
		(3, GETDATE(), 26, '2023-05-29'	, 1),
		(3, GETDATE(), 27, '2023-05-29'	, 1),
		(3, GETDATE(), 28, '2023-05-29'	, 1),
		(3, GETDATE(), 29, '2023-05-29'	, 1),
						 			
		(4, GETDATE(), 30, '2023-05-29'	, 1),
		(4, GETDATE(), 31, '2023-05-29'	, 1),
		(4, GETDATE(), 32, '2023-05-29'	, 1),
		(4, GETDATE(), 33, '2023-05-29'	, 1),
		(4, GETDATE(), 34, '2023-05-29'	, 1),
		(4, GETDATE(), 35, '2023-05-29'	, 1),
		(4, GETDATE(), 36, '2023-05-29'	, 1),
		(4, GETDATE(), 37, '2023-05-29'	, 1),
		(4, GETDATE(), 38, '2023-05-29'	, 1),
		(4, GETDATE(), 39, '2023-05-29'	, 1),
		(4, GETDATE(), 40, '2023-05-29'	, 1),
		(4, GETDATE(), 41, '2023-05-29'	, 1),
		(4, GETDATE(), 42, '2023-05-29'	, 1),
		(4, GETDATE(), 43, '2023-05-29'	, 1),
		(4, GETDATE(), 44, '2023-05-29'	, 1)
GO


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
--ADD CONSTRAINT FK_acce_tbUsuarios_cons_tbEmpleados_empl_ID FOREIGN KEY (empl_ID) REFERENCES parq.tbEmpleados (empl_ID),
--	CONSTRAINT FK_acce_tbUsuarios_usua_UsuarioCreador_tbUsuarios_usua_ID FOREIGN KEY (usua_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_acce_tbUsuarios_usua_UsuarioModificador_tbUsuarios_usua_ID FOREIGN KEY (usua_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO


--ALTER TABLE parq.tbCargos
--ADD	CONSTRAINT FK_parq_tbCargos_carg_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (carg_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_parq_tbCargos_carg_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (carg_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE parq.tbRegiones
--ADD
--	CONSTRAINT FK_parq_tbRegiones_regi_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (regi_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_parq_tbRegiones_regi_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (regi_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE parq.tbClientes
--ADD
--	CONSTRAINT FK_parq_tbClientes_clie_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (clie_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_parq_tbClientes_clie_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (clie_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE parq.tbClientesRegistrados 
--ADD
--	CONSTRAINT FK_parq_tbClientesRegistrados_clre_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (clre_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_parq_tbClientesRegistrados_clre_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (clre_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE parq.tbAreas
--ADD
--	CONSTRAINT FK_parq_tbAreas_area_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (area_UsuarioCreador) REFERENCES acce.tbUsuarios(usua_ID),
--	CONSTRAINT FK_parq_tbAreas_area_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (area_UsuarioModificador) REFERENCES acce.tbUsuarios(usua_ID)
--GO

--ALTER TABLE parq.tbTickets
--ADD
--	CONSTRAINT FK_parq_tbTickets_tckt_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (tckt_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_parq_tbTickets_tckt_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (tckt_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE parq.tbTicketsCliente
--ADD
--	CONSTRAINT FK_parq_tbTicketsCliente_ticl_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (ticl_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_parq_tbTicketsCliente_ticl_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (ticl_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO


--ALTER TABLE parq.tbAtracciones
--ADD
--	CONSTRAINT FK_parq_tbAtracciones_atra_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (atra_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_parq_tbAtracciones_atra_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (atra_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE parq.tbEmpleados
--ADD
--	CONSTRAINT FK_parq_tbEmpleados_empl_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (empl_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_parq_tbEmpleados_empl_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (empl_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE parq.tbQuioscos
--ADD
--	CONSTRAINT FK_parq_tbQuioscos_quio_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (quio_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_parq_tbQuioscos_quio_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (quio_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE parq.tbGolosinas
--ADD
--	CONSTRAINT FK_parq_tbGolosinas_golo_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (golo_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_parq_tbGolosinas_golo_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (golo_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE parq.tbInsumosQuiosco
--ADD
--	CONSTRAINT FK_parq_tbInsumosQuiosco_insu_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (insu_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_parq_tbInsumosQuiosco_insu_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (insu_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE parq.tbRatings
--ADD
--	CONSTRAINT FK_parq_tbRatings_rati_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (rati_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_parq_tbRatings_rati_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (rati_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE fila.tbTemporizadores
--ADD
--	CONSTRAINT FK_fila_tbTemporizadores_temp_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (temp_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_fila_tbTemporizadores_temp_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (temp_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE fila.tbTipoFilas
--ADD
--	CONSTRAINT FK_fila_tbTipoFilas_tifi_UsuarioCreador_acce_tbUsuarios_usua_ID	FOREIGN KEY (tifi_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_fila_tbTipoFilas_tifi_UsuarioModificador_acce_tbUsuarios_usua_ID	FOREIGN KEY (tifi_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE fila.tbFilasAtraccion
--ADD
--	CONSTRAINT FK_fila_tbFilasAtraccion_fiat_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (fiat_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_fila_tbFilasAtraccion_fiat_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (fiat_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE fila.tbHistorialFilasPosiciones
--ADD
--	CONSTRAINT FK_fila_tbHistorialFilasPosiciones_hipo_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (hipo_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_fila_tbHistorialFilasPosiciones_hipo_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (hipo_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE fila.tbHistorialVisitantesAtraccion
--ADD
--	CONSTRAINT FK_fila_tbHistorialVisitantesAtraccion_hiat_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (hiat_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_fila_tbHistorialVisitantesAtraccion_hiat_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (hiat_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE fact.tbVentasQuiosco
--ADD
--	CONSTRAINT FK_fact_tbVentasQuiosco_vent_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (vent_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_fact_tbVentasQuiosco_vent_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (vent_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO

--ALTER TABLE fact.tbVentasQuioscoDetalle
--ADD
--	CONSTRAINT FK_fact_tbVentasQuioscoDetalle_deta_UsuarioCreador_acce_tbUsuarios_usua_ID FOREIGN KEY (deta_UsuarioCreador) REFERENCES acce.tbUsuarios (usua_ID),
--	CONSTRAINT FK_fact_tbVentasQuioscoDetalle_deta_UsuarioModificador_acce_tbUsuarios_usua_ID FOREIGN KEY (deta_UsuarioModificador) REFERENCES acce.tbUsuarios (usua_ID)
--GO